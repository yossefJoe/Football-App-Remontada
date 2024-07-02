import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Custom_List_Tile.dart';
import 'package:remontada/Start_Page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      SignoutTrueorFalse: true,
      leading: Icons.exit_to_app_rounded,
      title: AppLocalizations.of(context)!.signout,
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StartPage()),
          (Route<dynamic> route) => false,
        );
      },
      trailingTrueorFalse: false,
    );
  }
}
