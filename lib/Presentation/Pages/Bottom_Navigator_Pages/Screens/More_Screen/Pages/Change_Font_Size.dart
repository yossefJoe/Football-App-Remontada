import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FontSizePage extends StatelessWidget {
  const FontSizePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 20);
    return Scaffold(
      appBar:
          CustomAppBar(AppLocalizations.of(context)!.changefontsize, context),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<RemontadaModel>(
                builder: (context, tile, child) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onTap: () {
                      tile.default_size();
                    },
                    tileColor:
                        tile.font_size == 15 ? primary_color : Colors.grey[900],
                    leading: Text(AppLocalizations.of(context)!.defaultfont),
                  );
                },
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<RemontadaModel>(
                builder: (context, v, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () {
                        v.change_font_size(10);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        color: v.font_size != 15
                            ? primary_color.withOpacity(0.5)
                            : Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.manuelcontroll,
                                style: style,
                              ),
                              Text(
                                AppLocalizations.of(context)!.choosesize,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                AppLocalizations.of(context)!.appfontsize,
                                style: style,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'A',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Expanded(
                                    child: Slider(
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.black,
                                      thumbColor: primary_color,
                                      divisions: 15,
                                      min: 5,
                                      max: 50,
                                      value: v.font_size,
                                      onChanged: (value) {
                                        v.change_font_size(value);
                                      },
                                    ),
                                  ),
                                  Text(
                                    'A',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
