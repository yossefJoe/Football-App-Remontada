import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Custom_List_Tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:remontada/Start_Page.dart';

class DeleteAccount extends StatelessWidget {
  DeleteAccount({super.key});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> deleteUser(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
      await firestore.collection('images').doc(userId).delete();
      QuerySnapshot imageSnapshot = await FirebaseFirestore.instance
          .collection('favourites')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      for (QueryDocumentSnapshot doc in imageSnapshot.docs) {
        await doc.reference.delete();
      }
      print("User with ID $userId has been deleted.");
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      SignoutTrueorFalse: true,
      leading: Icons.delete_forever,
      title: AppLocalizations.of(context)!.deleteaccount,
      onTap: () async {
        await deleteUser(FirebaseAuth.instance.currentUser!.uid);
        await FirebaseAuth.instance.currentUser!.delete();

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StartPage()),
          (Route<dynamic> route) => false,
        );
      },
      trailingTrueorFalse: false,
    );
  }
}
