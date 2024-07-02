import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Favourite_National.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Favourite_Team.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Favourites_List.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoundedContainer extends StatelessWidget {
  RoundedContainer({super.key});
  CollectionReference favourites =
      FirebaseFirestore.instance.collection("favourites");
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<RemontadaModel>(
      builder: (context, v, child) {
        return GestureDetector(
          onTap: () async {
            QuerySnapshot snapshot = await favourites
                .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                .get();
            if (snapshot.docs.isEmpty) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FavouriteTeam(),
              ));
              v.empty_national_set();
              v.empty_team_set();
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Favourites(),
              ));
            }
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.favourites,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.star_border,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? primary_color.withOpacity(0.6)
                    : Colors.indigo,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.grey)),
          ),
        );
      },
    );
  }
}
