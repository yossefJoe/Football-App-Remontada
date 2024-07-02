import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remontada/Presentation/Pages/Home_Page/Home_Page.dart';
import 'package:remontada/Presentation/Widgets/Custom_Button.dart';
import 'package:remontada/Presentation/Widgets/Custom_Textfield.dart';
import 'package:remontada/Presentation/Widgets/Loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SIgnIn extends StatelessWidget {
  SIgnIn({super.key});
  var password, email;
  @override
  Widget build(BuildContext context) {
    Future<void> signin() async {
      try {
        showloading(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Password or email is incorrect"),
                title: Text("Try Again"),
                actions: [CloseButton()],
              );
            });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Form(
              child: Column(
            children: [
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
            ],
          )),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 10, right: 50, left: 50),
            child: CustomButton(
              child: Text(
                AppLocalizations.of(context)!.signin,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              color: Colors.indigo,
              onpressed: signin,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
