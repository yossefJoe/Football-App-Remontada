import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:remontada/Constants/Api/Top_Scorers_Api.dart";
import "package:remontada/Constants/Constants.dart";
import 'package:flutter_svg/flutter_svg.dart';
import "package:remontada/Constants/Provider_Methods.dart";
import "package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Pages/Player_Info_Pages/Player_Info.dart";
import "package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Widgets/championship_Tile.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScorersPage extends StatelessWidget {
  ScorersPage({super.key});
  double get_percent(int matches, int goals) {
    double percent = (goals * 100) / matches;
    return percent.floor().toDouble();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final TextStyle defaul_style = TextStyle(
        color:
            theme.brightness == Brightness.light ? Colors.white : primary_color,
        fontSize: 10);

    return Scaffold(
        backgroundColor: theme.brightness == Brightness.light
            ? Colors.indigo
            : Colors.grey[900],
        body: ListView(
          children: [
            Championships(),
            Container(
              color: theme.brightness == Brightness.light
                  ? Colors.cyan
                  : Colors.grey[700],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              AppLocalizations.of(context)!.scorereslist,
                              style: defaul_style,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.goals,
                            style: defaul_style,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppLocalizations.of(context)!.assists,
                            style: defaul_style,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppLocalizations.of(context)!.scoringpercent,
                            style: defaul_style,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppLocalizations.of(context)!.team,
                            style: defaul_style,
                          )
                        ],
                      ),
                    ),
                    Consumer<RemontadaModel>(
                      builder: (context, v, child) {
                        return FutureBuilder(
                          future: Scorers_Api()
                              .getsavedscorers(v.default_championship),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => PlayerInfo(
                                            id: snapshot.data![index],
                                          ),
                                        ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: 20,
                                              child:
                                                  Text((index + 1).toString())),
                                          Container(
                                            width: 130,
                                            child: Text(snapshot
                                                .data![index].player!.name
                                                .toString()),
                                          ),
                                          Container(
                                              width: 30,
                                              child: Text(snapshot
                                                  .data![index].goals
                                                  .toString())),
                                          Container(
                                              width: 30,
                                              child: Text(snapshot.data![index]
                                                          .assists !=
                                                      null
                                                  ? snapshot
                                                      .data![index].assists
                                                      .toString()
                                                  : '0')),
                                          Container(
                                            width: 50,
                                            child: Text(get_percent(
                                                        snapshot.data![index]
                                                            .playedMatches!,
                                                        snapshot.data![index]
                                                            .goals!)
                                                    .toString()
                                                    .substring(0, 2) +
                                                '%'),
                                          ),
                                          snapshot.data![index].team!.crest
                                                  .toString()
                                                  .contains('svg')
                                              ? Container(
                                                  width: 50,
                                                  child: SvgPicture.network(
                                                    snapshot.data![index].team!
                                                        .crest
                                                        .toString(),
                                                    height: 50,
                                                  ),
                                                )
                                              : Container(
                                                  width: 50,
                                                  child: Image.network(
                                                    snapshot.data![index].team!
                                                        .crest
                                                        .toString(),
                                                    height: 50,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data!.length,
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
              ),
            )
          ],
        ));
  }
}
