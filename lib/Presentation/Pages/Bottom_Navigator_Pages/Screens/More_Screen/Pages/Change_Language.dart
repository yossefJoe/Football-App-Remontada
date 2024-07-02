import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});
  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);
    TextStyle textStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: CustomAppBar(AppLocalizations.of(context)!.language, context),
        body: Consumer<RemontadaModel>(
          builder: (context, v, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 5),
                  child: ListTile(
                    tileColor: defaultLocale.languageCode == 'ar'
                        ? primary_color
                        : Colors.grey[850],
                    onTap: defaultLocale.languageCode == 'ar'
                        ? null
                        : () {
                            v.change_language();
                          },
                    leading: Text(
                      AppLocalizations.of(context)!.arabic,
                      style: textStyle,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: ListTile(
                    onTap: defaultLocale.languageCode == "en"
                        ? null
                        : () {
                            v.change_language();
                          },
                    tileColor: defaultLocale.languageCode == 'en'
                        ? primary_color
                        : Colors.grey[850],
                    leading: Text(
                      AppLocalizations.of(context)!.english,
                      style: textStyle,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey)),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
