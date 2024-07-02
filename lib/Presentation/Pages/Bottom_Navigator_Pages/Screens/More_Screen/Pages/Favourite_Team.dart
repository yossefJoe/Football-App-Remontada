import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/retry.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Api/Teams_Api.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Favourites_List.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Leagues_Widget.dart';
import 'package:remontada/Presentation/Pages/Home_Page/Home_Page.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:remontada/Presentation/Widgets/Custom_Button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteTeam extends StatelessWidget {
  FavouriteTeam({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Future<void> add_favourites(String teamname, String Teamlogo) async {
      final favourites = FirebaseFirestore.instance.collection('favourites');
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
      appBar: CustomAppBar(AppLocalizations.of(context)!.chooseteam, context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeagueWidget(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Text(
              AppLocalizations.of(context)!.followteam,
              style: TextStyle(
                  color: theme.brightness == Brightness.light
                      ? Colors.white
                      : primary_color),
            ),
          ),
          Center(child: Consumer<RemontadaModel>(
            builder: (context, v, child) {
              return FutureBuilder(
                future: Teams_Api().getSavedOrFetchTeams(v.League),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: height * 0.6,
                      width: width * 0.8,
                      child: Center(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            if (index < snapshot.data!.length) {
                              return GestureDetector(
                                onTap: () async {
                                  v.change_team_border(index);
                                  await add_favourites(
                                      snapshot.data![index].strTeam.toString(),
                                      snapshot.data![index].strTeamBadge
                                          .toString());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: v.selectedteams.contains(index)
                                              ? primary_color
                                              : Colors.transparent),
                                      color:
                                          theme.brightness == Brightness.light
                                              ? Colors.cyan
                                              : Colors.grey[800],
                                      borderRadius: BorderRadius.circular(5)),
                                  margin: EdgeInsets.all(10),
                                  child: Center(
                                    child: Image.network(
                                      snapshot.data![index].strTeamBadge
                                          .toString(),
                                      height: 40,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false);
              },
            ),
          )
        ],
      ),
    );
  }
}
