import 'package:flutter/material.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/Matches_Screen.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/More_Screen_Pages/More_Screen.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/News_Screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> MyPages = [
    MatchesScreen(),
    NewsScreen(),
    MoreScreen(),
  ];
  int currentindex = 0;
  int? index;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            backgroundColor: theme.brightness == Brightness.dark
                ? Colors.grey[900]
                : Colors.black,
            selectedItemColor: theme.brightness == Brightness.dark
                ? primary_color
                : Colors.blueGrey,
            unselectedItemColor: theme.brightness == Brightness.dark
                ? Colors.grey
                : Colors.white,
            currentIndex: currentindex,
            onTap: (value) {
              setState(() {
                currentindex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.matches,
                  icon: Icon(Icons.sports_soccer_outlined)),
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.news,
                  icon: Icon(Icons.newspaper_rounded)),
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.more,
                  icon: Icon(Icons.more_horiz)),
            ]),
        body: MyPages.elementAt(currentindex));
  }
}
