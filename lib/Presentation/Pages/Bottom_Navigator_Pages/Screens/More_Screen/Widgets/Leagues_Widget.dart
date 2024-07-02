import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeagueWidget extends StatelessWidget {
  LeagueWidget({super.key});
  List logos = [
    'liga.png',
    'seriea.png',
    'en.png',
    'bundesliga.png',
    'ligue1.png',
    'eg.png',
    'sa.png',
    'brazilian.png'
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List names = [
      AppLocalizations.of(context)!.ll,
      AppLocalizations.of(context)!.sa,
      AppLocalizations.of(context)!.pl,
      AppLocalizations.of(context)!.bl,
      AppLocalizations.of(context)!.l1,
      AppLocalizations.of(context)!.epl,
      AppLocalizations.of(context)!.sp,
      AppLocalizations.of(context)!.br
    ];

    return Container(
      height: 100,
      child: ListView.builder(
        reverse: true,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 7),
              child: Consumer<RemontadaModel>(
                builder: (context, v, child) {
                  return GestureDetector(
                    onTap: () async {
                      await v.choose_league(index);
                      v.empty_team_set();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: ClipOval(
                              child:
                                  Image.asset("assets/images/${logos[index]}")),
                        ),
                        Text(
                          names[index],
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        )
                      ],
                    ),
                  );
                },
              ));
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
