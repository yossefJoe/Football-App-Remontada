import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Change_Font_Size.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Change_Language.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Custom_List_Tile.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(AppLocalizations.of(context)!.settings, context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 8),
        child: Column(
          children: [
            CustomListTile(
              trailingTrueorFalse: true,
              title: AppLocalizations.of(context)!.language,
              leading: Icons.translate_rounded,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ChangeLanguage();
                  },
                ));
              },
            ),
            CustomListTile(
              trailingTrueorFalse: true,
              title: AppLocalizations.of(context)!.fontsize,
              leading: Icons.format_size_rounded,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FontSizePage(),
                ));
              },
            ),
            Consumer<RemontadaModel>(
              builder: (context, v, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: SwitchListTile(
                      secondary: Icon(
                        Icons.dark_mode_rounded,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: Colors.grey[850],
                      title: Text(
                        AppLocalizations.of(context)!.nightmode,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      activeColor: primary_color,
                      value:
                          theme.brightness == Brightness.light ? false : true,
                      onChanged: (value) {
                        v.open_switch(value);
                        v.change_mode();
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
