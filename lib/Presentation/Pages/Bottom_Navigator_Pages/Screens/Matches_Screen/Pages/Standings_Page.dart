import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Api/Standings_Api.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Pages/Upcoming_Matches.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Widgets/championship_Tile.dart';
import 'package:remontada/Models/Standings_Model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StandingsPage extends StatelessWidget {
  StandingsPage({super.key});

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
          Consumer<RemontadaModel>(
            builder: (context, v, child) {
              return FutureBuilder<List<Standings>>(
                future: Standings_Api().getsavedtables(v.default_championship),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primary_color,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // Access each standings group (e.g., total, home, away)
                        final standingsGroup = snapshot.data![index];

                        return Container(
                          color: theme.brightness == Brightness.light
                              ? Colors.cyan
                              : Colors.grey[800],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.teams,
                                      style: defaul_style,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.played,
                                          style: defaul_style,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.wins,
                                          style: defaul_style,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.draws,
                                          style: defaul_style,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.loses,
                                          style: defaul_style,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.goals,
                                          style: defaul_style,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.points,
                                          style: defaul_style,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: standingsGroup.table!.length,
                                itemBuilder: (context, teamIndex) {
                                  final team =
                                      standingsGroup.table![teamIndex].team;
                                  final table =
                                      standingsGroup.table![teamIndex];
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => UpcomingMatches(
                                            id: table.team,
                                          ),
                                        ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              width: 20,
                                              child: Text(
                                                  (teamIndex + 1).toString())),
                                          team!.crest.toString().contains('svg')
                                              ? Container(
                                                  width: 50,
                                                  child: SvgPicture.network(
                                                    team.crest.toString(),
                                                    height: 30,
                                                  ),
                                                )
                                              : Container(
                                                  width: 50,
                                                  child: Image.network(
                                                    team.crest.toString(),
                                                    height: 30,
                                                  ),
                                                ),
                                          Container(
                                              width: 110,
                                              child:
                                                  Text(team!.name.toString())),
                                          Container(
                                              width: 20,
                                              child: Text(table.playedGames
                                                  .toString())),
                                          Container(
                                              width: 20,
                                              child:
                                                  Text(table.won.toString())),
                                          Container(
                                              width: 20,
                                              child:
                                                  Text(table.lost.toString())),
                                          Container(
                                              width: 20,
                                              child:
                                                  Text(table.draw.toString())),
                                          Container(
                                              width: 20,
                                              child: Text(
                                                  table.goalsFor.toString())),
                                          Container(
                                              width: 20,
                                              child: Text(
                                                  table.points.toString())),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
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
