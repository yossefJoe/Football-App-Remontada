import 'package:flutter/material.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Custom_List_Tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUs extends StatelessWidget {
  ContactUs({super.key});
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchPhoneDialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: Icons.email_outlined,
      title: AppLocalizations.of(context)!.contactus,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            TextStyle style = TextStyle(fontSize: 12, color: Colors.grey);
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              content: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.facebook),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                              style: ButtonStyle(),
                              onPressed: () {
                                _launchURL(
                                    'https://www.facebook.com/abo.treika.zamalek');
                              },
                              child: Text(
                                'Youssef Mahmoud',
                                style: style,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                              onPressed: () {
                                _launchPhoneDialer('01125826623');
                              },
                              child: Text(
                                '01125826623',
                                style: style,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              title: Text('Contact Us'),
              actions: [CloseButton()],
            );
          },
        );
      },
      trailingTrueorFalse: false,
    );
  }
}
