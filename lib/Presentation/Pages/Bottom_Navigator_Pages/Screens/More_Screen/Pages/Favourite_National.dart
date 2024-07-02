import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Api/National_Teams_Api.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Models/National_Team_Model.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Favourite_Team.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:remontada/Presentation/Widgets/Custom_Button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteNational extends StatelessWidget {
  const FavouriteNational({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<String> flags = ['ue.png', 'a2.png', 'as.png', 'am.png', 'na.png'];
    List names = [
      AppLocalizations.of(context)!.europe,
      AppLocalizations.of(context)!.africa,
      AppLocalizations.of(context)!.asia,
      AppLocalizations.of(context)!.samerica,
      AppLocalizations.of(context)!.namerica
    ];
    Future<void> add_favourites(String teamname, String Teamlogo) async {
      final favourites = FirebaseFirestore.instance.collection('favourites');
      final String? uid = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await favourites
          .where('teamname', isEqualTo: teamname)
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (querySnapshot.docs.isEmpty) {
        await favourites.add({
          'teamname': teamname,
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'teamlogo': Teamlogo
        });
        print('Item added to favourites.');
      } else {
        print('Item already exists in favourites.');
      }
    }

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.indigo
          : Colors.grey[900],
      appBar:
          CustomAppBar(AppLocalizations.of(context)!.choosenational, context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            child: ListView.builder(
              reverse: true,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 7),
                    child: Consumer<RemontadaModel>(
                      builder: (context, v, child) {
                        return GestureDetector(
                          onTap: () async {
                            await v.choose_continent(index);
                            v.empty_national_set();
                            v.which_america(index);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: ClipOval(
                                    child: Image.asset(
                                        "assets/images/${flags[index]}")),
                              ),
                              Text(
                                names[index],
                                style:
                                    TextStyle(fontSize: 8, color: Colors.white),
                              )
                            ],
                          ),
                        );
                      },
                    ));
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              AppLocalizations.of(context)!.follownational,
              style: TextStyle(
                  color: theme.brightness == Brightness.light
                      ? Colors.white
                      : primary_color),
            ),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: (50)),
                child: Consumer<RemontadaModel>(
                  builder: (context, v, child) {
                    return FutureBuilder(
                      future: National_Api().getSavedOrFetchNationals(
                          v.Continent, v.default_america),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            height: height * 0.4,
                            width: width * 0.8,
                            child: Center(
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                ),
                                itemCount: 16,
                                itemBuilder: (context, index) {
                                  if (index < snapshot.data!.length) {
                                    return GestureDetector(
                                      onTap: () async {
                                        v.change_national_border(index);
                                        await add_favourites(
                                            snapshot.data![index].name
                                                .toString(),
                                            snapshot.data![index].flag
                                                .toString());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: v.selectednationals
                                                        .contains(index)
                                                    ? primary_color
                                                    : Colors.transparent),
                                            color: theme.brightness ==
                                                    Brightness.light
                                                ? Colors.cyan
                                                : Colors.grey[800],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                          child: ClipOval(
                                            child: Image.network(
                                              "${snapshot.data![index].flag.toString()}",
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox
                                        .shrink(); // Return an empty widget if index is out of range
                                  }
                                },
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                        }
                      },
                    );
                  },
                )),
          ),
          Center(
            child: CustomButton(
              child: Text(
                AppLocalizations.of(context)!.next,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              color: primary_color,
              height: height * 0.075,
              width: width * 0.5,
              onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavouriteTeam(),
                ));
              },
            ),
          )
        ],
      ),
    );
  }
}
