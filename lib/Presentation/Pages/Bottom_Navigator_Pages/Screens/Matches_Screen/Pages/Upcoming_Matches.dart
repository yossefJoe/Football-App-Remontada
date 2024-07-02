import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remontada/Constants/Api/Upcoming_Matches_Api.dart';
import 'package:remontada/Models/League_Matches_Model.dart';
import 'package:remontada/Models/Standings_Model.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingMatches extends StatelessWidget {
  UpcomingMatches({
    super.key,
    this.id,
  });
  final Team? id;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar:
          CustomAppBar(AppLocalizations.of(context)!.upcomingmatches, context),
      body: ListView(
        children: [
          FutureBuilder(
            future: Upcoming_Api().getsavedupcomingmatches(id!.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      String homelogo =
                          snapshot.data![index].homeTeam!.crest.toString();
                      String awaylogo =
                          snapshot.data![index].awayTeam!.crest.toString();
                      TextStyle namestyle = TextStyle(
                          fontSize: 12,
                          color: theme.brightness == Brightness.light
                              ? Colors.black
                              : Colors.white);
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            color: theme.brightness == Brightness.light
                                ? Colors.cyan
                                : Colors.grey[850],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    homelogo.contains('svg')
                                        ? SvgPicture.network(
                                            homelogo,
                                            height: 40,
                                          )
                                        : Image.network(
                                            homelogo,
                                            height: 40,
                                          ),
                                    Text(
                                      snapshot.data![index].homeTeam!.name
                                          .toString(),
                                      style: namestyle,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.network(
                                      snapshot.data![index].competition!.emblem
                                          .toString(),
                                      height: 40,
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
                                      snapshot.data![index].utcDate
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                          color: theme.brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    awaylogo.contains('svg')
                                        ? SvgPicture.network(
                                            awaylogo,
                                            height: 40,
                                          )
                                        : Image.network(
                                            awaylogo,
                                            height: 40,
                                          ),
                                    Text(
                                      snapshot.data![index].awayTeam!.name
                                          .toString(),
                                      style: namestyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                  ),
                );
              } else if (!snapshot.hasData) {
                return Center(
                    child: Text(AppLocalizations.of(context)!.noupcoming));
              } else if (snapshot.data!.length == 0) {
                return Center(
                    child: Text(AppLocalizations.of(context)!.noupcoming));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
