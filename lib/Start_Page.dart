import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remontada/Presentation/Pages/Home_Page/Home_Page.dart';
import 'package:remontada/Presentation/Pages/Sign_Up/Sign_Up_Page.dart';
import 'package:remontada/Presentation/Widgets/Custom_Button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // Save user info to Firestore
    await saveUserInfo(userCredential.user);
    return userCredential;
  }

  Future<void> saveUserInfo(User? user) async {
    if (user != null) {
      final FirebaseMessaging fbm = FirebaseMessaging.instance;
      final String? token = await fbm.getToken();
      final usersCollection = FirebaseFirestore.instance.collection('users');
      DocumentSnapshot doc = await usersCollection.doc(user.displayName).get();

      if (!doc.exists) {
        await usersCollection.doc(user.uid).set({
          'uid': user.uid,
          'displayName': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
          'phonenumber': user.phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
          'user_token': token
        });
      }
    }
  }

  late double height;
  late double width;
  late Orientation oreientation;
  late double defaultsize;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    oreientation = MediaQuery.of(context).orientation;
    defaultsize = oreientation == Orientation.landscape
        ? height! * 0.024
        : width! * 0.024;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/messi.jpg"),
                fit: BoxFit.fill)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.starttitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: defaultsize * 2,
                ),
                Text(
                  AppLocalizations.of(context)!.startsubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(0.8)),
                ),
                SizedBox(
                  height: defaultsize * 2,
                ),
                CustomButton(
                  child: Text(
                    AppLocalizations.of(context)!.signup,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.indigo,
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SignUp();
                      },
                    ));
                  },
                  height: height * 0.075,
                  width: width * 0.5,
                ),
                SizedBox(
                  height: defaultsize * 2,
                ),
                CustomButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.google,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                          width: defaultsize * 3,
                          height: defaultsize * 3,
                          child: Image.asset(
                            "assets/images/google.png",
                            color: Colors.white,
                          ))
                    ],
                  ),
                  color: Colors.redAccent,
                  onpressed: () async {
                    UserCredential userCredential = await signInWithGoogle();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  height: height * 0.075,
                  width: width * 0.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
