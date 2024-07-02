import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Championships extends StatelessWidget {
  Championships({super.key});

  List<String> logos = [
    'epl.png',
    'BL1.png',
    'ED.png',
    'BSA.png',
    'PD.png',
    'FL1.png',
    'PPL.png',
    'SEREIEA.png',
    'cl.png',
    'CLI.png',
    'WC.png'
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<String> names = [
      AppLocalizations.of(context)!.pl,
      AppLocalizations.of(context)!.bl,
      AppLocalizations.of(context)!.er,
      AppLocalizations.of(context)!.br,
      AppLocalizations.of(context)!.ll,
      AppLocalizations.of(context)!.l1,
      AppLocalizations.of(context)!.lp,
      AppLocalizations.of(context)!.sa,
      AppLocalizations.of(context)!.cl,
      AppLocalizations.of(context)!.cli,
      AppLocalizations.of(context)!.wc
    ];

    return Container(
        height: 120,
        child: Consumer<RemontadaModel>(
          builder: (context, v, child) {
            return ListView.builder(
              reverse: true,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: logos.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                bool isSelected = v.selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 7),
                  child: GestureDetector(
                    onTap: isSelected
                        ? null
                        : () async {
                            v.selectChampionship(index);
                            v.choose_chmpionship(index);
                            v.return_default();
                          },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: isSelected ? 80 : 60,
                          height: isSelected ? 80 : 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: isSelected
                                      ? primary_color
                                      : Colors.transparent),
                              shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset(
                              "assets/images/${logos[index]}",
                              fit: BoxFit.contain,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Text(
                          names[index],
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
