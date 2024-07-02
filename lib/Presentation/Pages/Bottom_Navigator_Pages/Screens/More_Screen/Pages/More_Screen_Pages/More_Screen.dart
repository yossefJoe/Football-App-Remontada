import 'package:flutter/material.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/More_Screen_Pages/Delete_Account.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/More_Screen_Pages/Email_Name_Pic_Widget.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/More_Screen_Pages/SignOut.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Settings_Page.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Contact_Us_Dialoge.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Custom_List_Tile.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Rounded_Container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share/share.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoWidget(),
                RoundedContainer(),
                CustomListTile(
                  leading: Icons.settings,
                  title: AppLocalizations.of(context)!.settings,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SettingsPage();
                      },
                    ));
                  },
                  trailingTrueorFalse: true,
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.theapplication,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CustomListTile(
                  leading: Icons.share,
                  title: AppLocalizations.of(context)!.share,
                  onTap: () {
                    final String appLink =
                        'https://play.google.com/store/apps/details?id=com.remontada.yourapp';
                    Share.share('Check out this amazing app: $appLink');
                  },
                  trailingTrueorFalse: false,
                ),
                ContactUs(),
                SignOut(),
                DeleteAccount()
              ],
            ),
          )
        ],
      ),
    );
  }
}
