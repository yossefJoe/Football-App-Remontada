import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remontada/Constants/Api/Players_Info_Api.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Models/Top_Scorers_Model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatelessWidget {
  Profile({super.key, this.id});
  final Scorers? id;
  String get_age(String date) {
    List<String> date_list = date.split('-');
    List<int> int_list = date_list.map(int.parse).toList();
    DateTime now = DateTime.now();
    int age = now.year - int_list[0];
    return age.toString();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = TextStyle(
        fontSize: 20,
        color:
            theme.brightness == Brightness.light ? Colors.white : Colors.grey);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.indigo
          : Colors.grey[800],
      body: FutureBuilder(
        future: Player_Info_Api().getsavedplayers(id!.player!.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String logo = snapshot.data![0].currentTeam!.crest.toString();
            String until =
                snapshot.data![0].currentTeam!.contract!.until.toString();
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.playerinfo,
                        style: TextStyle(
                            fontSize: 20,
                            color: theme.brightness == Brightness.light
                                ? Colors.white
                                : Colors.grey),
                      ),
                      CustomTile(
                        leading: AppLocalizations.of(context)!.club,
                        title: Text(
                          snapshot.data![0].currentTeam!.name.toString(),
                        ),
                      ),
                      CustomTile(
                        leading: AppLocalizations.of(context)!.nationality,
                        title: Text(snapshot.data![0].nationality.toString()),
                      ),
                      CustomTile(
                          leading: AppLocalizations.of(context)!.shirtnumber,
                          title: Container(
                            margin: EdgeInsets.only(left: 100),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        theme.brightness == Brightness.light
                                            ? Colors.white
                                            : primary_color!,
                                        BlendMode.srcIn),
                                    image:
                                        AssetImage('assets/images/kit.png'))),
                            child: Center(
                                child: Text(
                              snapshot.data![0].shirtNumber.toString(),
                            )),
                          )),
                      CustomTile(
                        leading: AppLocalizations.of(context)!.dateofbirth,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data![0].dateOfBirth.toString()),
                            Text(get_age(
                                    snapshot.data![0].dateOfBirth.toString()) +
                                " " +
                                AppLocalizations.of(context)!.years),
                          ],
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.contractdetails,
                        style: TextStyle(
                            fontSize: 20,
                            color: theme.brightness == Brightness.light
                                ? Colors.white
                                : Colors.grey),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          color: theme.brightness == Brightness.light
                              ? Colors.cyan
                              : Colors.grey[900],
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.from + ": ",
                                      style: style,
                                    ),
                                    Text(
                                      snapshot
                                          .data![0].currentTeam!.contract!.start
                                          .toString(),
                                      style: style,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.to + ": ",
                                      style: style,
                                    ),
                                    Text(
                                      until == 'null' ? "UnKnown" : until,
                                      style: style,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  children: [
                                    logo.contains('svg')
                                        ? SvgPicture.network(
                                            logo,
                                            height: 30,
                                          )
                                        : Image.network(
                                            logo,
                                            height: 30,
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      snapshot.data![0].currentTeam!.name
                                          .toString(),
                                      style: style,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
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

class CustomTile extends StatelessWidget {
  CustomTile({
    super.key,
    this.title,
    this.leading,
  });
  final Widget? title;
  final String? leading;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: theme.brightness == Brightness.light
            ? Colors.cyan
            : Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: title,
        leading: Container(
          width: 100,
          child: Text(
            leading!,
            style: TextStyle(
                color: theme.brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey,
                fontSize: 15),
          ),
        ),
      ),
    );
  }
}
