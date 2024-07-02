import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:provider/provider.dart";
import "package:remontada/Constants/Api/League_Matches_Api.dart";
import "package:remontada/Constants/Constants.dart";
import "package:remontada/Constants/Provider_Methods.dart";
import "package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Pages/Match_Details_Page.dart";
import "package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Widgets/championship_Tile.dart";
import "package:remontada/Presentation/Widgets/Custom_Button.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchesPage extends StatelessWidget {
  MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.indigo
          : Colors.grey[700],
      body: ListView(
        children: [
          Championships(),
          Consumer<RemontadaModel>(
            builder: (context, v, child) {
              return FutureBuilder(
                future: Matches_Api()
                    .getsavedmatches(v.default_championship, v.selected_item),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String homelogo = snapshot
                                .data![index].homeTeam!.crest
                                .toString();
                            String awaylogo = snapshot
                                .data![index].awayTeam!.crest
                                .toString();
                            TextStyle score_style = TextStyle(
                                color: theme.brightness == Brightness.light
                                    ? Colors.white
                                    : primary_color,
                                fontSize: 15);
                            TextStyle namestyle = TextStyle(
                                fontSize: 11,
                                color: theme.brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white);
                            String awayscore = snapshot
                                .data![index].score!.fullTime!.away
                                .toString();
                            String homescore = snapshot
                                .data![index].score!.fullTime!.home
                                .toString();
                            String match_status =
                                snapshot.data![index].score!.winner == null
                                    ? AppLocalizations.of(context)!
                                        .upcomingmatch
                                    : AppLocalizations.of(context)!.matchended;

                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: theme.brightness == Brightness.light
                                      ? Colors.cyan
                                      : Colors.grey[900],
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => MatchDetails(
                                          details: snapshot.data![index],
                                        ),
                                      ));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                width: 100,
                                                child: Column(
                                                  children: [
                                                    homelogo.contains('svg')
                                                        ? SvgPicture.network(
                                                            homelogo,
                                                            height: 50,
                                                          )
                                                        : Image.network(
                                                            homelogo,
                                                            height: 50,
                                                          ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .homeTeam!.name
                                                          .toString(),
                                                      style: namestyle,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].score!
                                                          .winner ==
                                                      null
                                                  ? ''
                                                  : homescore,
                                              style: score_style,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.vs,
                                              style: TextStyle(
                                                  color: theme.brightness ==
                                                          Brightness.light
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            Text(
                                              snapshot.data![index].score!
                                                          .winner ==
                                                      null
                                                  ? ''
                                                  : awayscore,
                                              style: score_style,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                width: 100,
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      awaylogo.contains('svg')
                                                          ? SvgPicture.network(
                                                              awaylogo,
                                                              height: 50,
                                                            )
                                                          : Image.network(
                                                              awaylogo,
                                                              height: 50,
                                                            ),
                                                      Text(
                                                          snapshot.data![index]
                                                              .awayTeam!.name
                                                              .toString(),
                                                          style: namestyle,
                                                          textAlign:
                                                              TextAlign.center),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          match_status,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: theme.brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primary_color,
                      ),
                    );
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
