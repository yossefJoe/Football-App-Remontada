import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:remontada/Presentation/Pages/Home_Page/Home_Page.dart';
import 'package:remontada/Presentation/Pages/Sign_Up/Custom_Row.dart';
import 'package:remontada/Presentation/Widgets/Custom_Button.dart';
import 'package:remontada/Presentation/Widgets/Custom_Textfield.dart';
import 'package:remontada/Presentation/Widgets/Loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  var username, password, phonenumber, email;
  GlobalKey<FormState> formState = new GlobalKey<FormState>();

  Future<void> saveUserInfo(User? user) async {
    if (user == null) return;
    final FirebaseMessaging fbm = FirebaseMessaging.instance;
    final String? token = await fbm.getToken();
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final docSnapshot = await usersCollection.doc(user.uid).get();

    if (!docSnapshot.exists) {
      await usersCollection.doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'displayName': username,
        'photoURL': user.photoURL,
        'phonenumber': phonenumber,
        'createdAt': FieldValue.serverTimestamp(),
        'user_token': token
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Future<UserCredential?> signUp() async {
      var formdata = formState.currentState;

      if (formdata!.validate()) {
        formdata.save();
        try {
          showloading(context);
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          await saveUserInfo(credential.user);
          return credential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else {
        print("Not valid");
      }
      return null;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Form(
                key: formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextFormField(
                      hinttext: AppLocalizations.of(context)!.username,
                      iconData: Icons.person,
                      keyboardType: TextInputType.name,
                      obsecuretext: false,
                      validator: (value) {
                        if (value!.length < 7) {
                          return "UserName shouldn't be less than 7 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (newvalue) {
                        username = newvalue;
                      },
                    ),
                    CustomTextFormField(
                      hinttext: AppLocalizations.of(context)!.email,
                      iconData: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      obsecuretext: false,
                      validator: (value) {
                        if (!value!.contains("@")) {
                          return "E-mail must contain @";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (newvalue) {
                        email = newvalue;
                      },
                    ),
                    CustomTextFormField(
                      hinttext: AppLocalizations.of(context)!.password,
                      iconData: Icons.password_outlined,
                      keyboardType: TextInputType.visiblePassword,
                      obsecuretext: true,
                      validator: (value) {
                        if (value!.length < 7) {
                          return "Password shouldn't be less than 7 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (newvalue) {
                        password = newvalue;
                      },
                    ),
                    CustomTextFormField(
                      hinttext: AppLocalizations.of(context)!.phonenumber,
                      iconData: Icons.phone,
                      keyboardType: TextInputType.phone,
                      obsecuretext: false,
                      validator: (value) {
                        if (value!.length < 11) {
                          return "Phone Number shouldn't be less than 11 numbers";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (newvalue) {
                        phonenumber = newvalue;
                      },
                    )
                  ],
                )),
            CustomRow(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 10, right: 50, left: 50),
              child: CustomButton(
                child: Text(
                  AppLocalizations.of(context)!.signup,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                color: Colors.indigo,
                onpressed: () async {
                  UserCredential? response = await signUp();
                  if (response != null) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    print("Sign up failed");
                  }
                },
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
