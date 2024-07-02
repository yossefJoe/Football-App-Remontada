import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:remontada/Constants/Api/Players_Info_Api.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Models/Top_Scorers_Model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Statistics extends StatelessWidget {
  Statistics({super.key, this.id});
  final Scorers? id;
  String get_rating(String assists, String goals, String matches) {
    List<String> data = [assists, goals, matches];
    List<int> stats = data.map(int.parse).toList();
    if (stats[0] + stats[1] > stats[2]) {
      return '8';
    } else {
      return '7';
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.indigo
          : Colors.grey[800],
      body: FutureBuilder(
        future: Player_Info_Api().getsavedplayers(id!.player!.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Card(
                  color: theme.brightness == Brightness.light
                      ? Colors.cyan
                      : Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/pitch.png',
                                        height: 40,
                                      ),
                                      Text(id!.playedMatches.toString()),
                                    ],
                                  ),
                                  Text(AppLocalizations.of(context)!
                                      .matchesplayed)
                                ],
                              ),
                              VerticalDivider(
                                indent: 10,
                                endIndent: 50,
                                color: Colors.grey,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/football.png',
                                        height: 40,
                                      ),
                                      Text(id!.goals.toString()),
                                    ],
                                  ),
                                  Text(AppLocalizations.of(context)!.goals)
                                ],
                              ),
                              VerticalDivider(
                                indent: 10,
                                endIndent: 50,
                                color: Colors.grey,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/sneaker.png',
                                        height: 40,
                                      ),
                                      Text(id!.assists.toString()),
                                    ],
                                  ),
                                  Text(AppLocalizations.of(context)!.assists)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/goal.png',
                                        height: 40,
                                      ),
                                      Text(id!.penalties.toString()),
                                    ],
                                  ),
                                  Text(AppLocalizations.of(context)!.penalities)
                                ],
                              ),
                              VerticalDivider(
                                indent: 10,
                                endIndent: 50,
                                color: Colors.grey,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/star.png',
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(get_rating(
                                            id!.assists.toString(),
                                            id!.goals.toString(),
                                            id!.playedMatches.toString())),
                                      ),
                                    ],
                                  ),
                                  Text(AppLocalizations.of(context)!
                                      .playerratings)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: primary_color,
              ),
            );
          }
        },
      ),
    );
  }
}
