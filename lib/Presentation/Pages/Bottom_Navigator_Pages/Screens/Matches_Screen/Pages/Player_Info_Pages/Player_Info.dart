import 'package:flutter/material.dart';
import 'package:remontada/Constants/Api/Players_Info_Api.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Models/Top_Scorers_Model.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Pages/Player_Info_Pages/Player_Profile.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen/Pages/Player_Info_Pages/Player_Stats.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerInfo extends StatelessWidget {
  PlayerInfo({super.key, this.id});
  final Scorers? id;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: MediaQuery.of(context).size.height * 0.15,
              title: FutureBuilder(
                future: Player_Info_Api()
                    .getsavedplayers(id!.player!.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person),
                          backgroundColor: theme.brightness == Brightness.light
                              ? Colors.grey
                              : Colors.white,
                        ),
                        Text(
                          snapshot.data![0].name.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          snapshot.data![0].position.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        )
                      ],
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
              bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.all(10),
                  indicatorColor: primary_color,
                  labelColor: primary_color,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: Text(AppLocalizations.of(context)!.profile),
                    ),
                    Tab(
                      child: Text(AppLocalizations.of(context)!.statistics),
                    )
                  ]),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            body: TabBarView(children: [
              Profile(
                id: id,
              ),
              Statistics(
                id: id,
              )
            ])));
  }
}
