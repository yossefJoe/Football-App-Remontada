import 'package:flutter/material.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Models/League_Matches_Model.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchDetails extends StatelessWidget {
  MatchDetails({super.key, this.details});
  final Matches? details;
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 20);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            title: Text(
              AppLocalizations.of(context)!.matchdetails,
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              labelColor: primary_color,
              indicatorColor: primary_color,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!.details,
                    style: style,
                  ),
                ),
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!.referes,
                    style: style,
                  ),
                )
              ],
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.all(10),
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            backgroundColor: Colors.blueGrey[900],
          ),
          body: TabBarView(children: [
            Details(
              data: details,
            ),
            Referes(
              data: details,
            )
          ])),
    );
  }
}

class Details extends StatelessWidget {
  Details({super.key, this.data});
  final Matches? data;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List details = [
      data!.homeTeam!.shortName.toString(),
      data!.awayTeam!.shortName.toString(),
      'From\n' +
          data!.season!.startDate.toString() +
          '\nTo\n' +
          data!.season!.endDate.toString(),
      data!.utcDate.toString().substring(0, 10),
      data!.utcDate.toString().substring(11, 16),
      data!.score!.winner.toString() != 'DRAW'
          ? data!.score!.winner.toString()
          : AppLocalizations.of(context)!.nowinner
    ];
    List Labels = [
      AppLocalizations.of(context)!.hometeam,
      AppLocalizations.of(context)!.awayteam,
      AppLocalizations.of(context)!.season,
      AppLocalizations.of(context)!.matchdate,
      AppLocalizations.of(context)!.matchhour,
      AppLocalizations.of(context)!.winner
    ];

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: ListView(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      color: theme.brightness == Brightness.light
                          ? Colors.cyan
                          : Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                Labels[index],
                                style: TextStyle(
                                    color: theme.brightness == Brightness.light
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                                width: 150,
                                child: Text(
                                  details[index],
                                  textAlign: TextAlign.center,
                                ))
                          ],
                        ),
                      ),
                    )),
              );
            },
            itemCount: details.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
          )
        ],
      ),
    );
  }
}

class Referes extends StatelessWidget {
  Referes({super.key, this.data});
  final Matches? data;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    List referes = [
      data!.referees![0].name.toString(),
      data!.referees![0].nationality.toString()
    ];
    List labels = [
      AppLocalizations.of(context)!.referename,
      AppLocalizations.of(context)!.referenationality
    ];
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: ListView(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      color: theme.brightness == Brightness.light
                          ? Colors.cyan
                          : Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                labels[index],
                                style: TextStyle(
                                    color: theme.brightness == Brightness.light
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 20),
                              ),
                            ),
                            Container(width: 150, child: Text(referes[index]))
                          ],
                        ),
                      ),
                    )),
              );
            },
            itemCount: referes.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
          )
        ],
      ),
    );
  }
}
