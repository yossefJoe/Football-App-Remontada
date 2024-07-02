import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Api/Teams_Api.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Pages/Matches_Page.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Pages/Standings_Page.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Pages/Top_Scorers_Page.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchesScreen extends StatelessWidget {
  MatchesScreen({super.key});

  int which_league(String league) {
    if (league == 'PPL') {
      return 34;
    } else if (league == 'CL') {
      return 6;
    } else if (league == 'CLI') {
      return 6;
    } else if (league == 'WC') {
      return 7;
    } else if (league == 'FL1') {
      return 34;
    } else if (league == 'DED') {
      return 34;
    } else if (league == 'BL1') {
      return 34;
    } else {
      return 38;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themdata = Theme.of(context);
    return Consumer<RemontadaModel>(
      builder: (context, v, child) {
        TextStyle style = TextStyle(fontSize: 20);
        List<String> weeks = List.generate(which_league(v.default_championship),
            (index) => (index + 1).toString());

        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.remontada),
                actions: [
                  Visibility(
                    visible: v.tab_index == 0 ? true : false,
                    child: DropdownButton(
                      style: TextStyle(color: Colors.white),
                      value: v.selected_item,
                      hint: Text(
                        "Select Week",
                        style: TextStyle(fontSize: 10),
                      ),
                      focusColor: primary_color,
                      dropdownColor: themdata.brightness == Brightness.dark
                          ? Colors.grey[850]
                          : Colors.grey,
                      items:
                          weeks.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newvalue) {
                        v.dropdown(newvalue!);
                      },
                    ),
                  ),
                ],
                centerTitle: true,
                backgroundColor: Colors.blueGrey[900],
                bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (value) {
                      v.select_tap(value);
                    },
                    labelColor: primary_color,
                    indicatorColor: primary_color,
                    unselectedLabelStyle: TextStyle(color: Colors.white),
                    tabs: [
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.matches,
                          style: style,
                        ),
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.standings,
                          style: style,
                        ),
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.scorers,
                          style: style,
                        ),
                      ),
                    ]),
              ),
              body: TabBarView(
                  children: [MatchesPage(), StandingsPage(), ScorersPage()])),
        );
      },
    );
  }
}
