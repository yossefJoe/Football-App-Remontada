import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Pages/Home_Page/Home_Page.dart';
import 'package:remontada/Start_Page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isArabic = prefs.getBool("is_arabic") ?? false;
  final isDark = prefs.getBool("is_dark") ?? false;
  runApp(MyApp(
    isDark: isDark,
    isArabic: isArabic,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isDark, required this.isArabic});
  final bool isDark;
  final bool isArabic;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RemontadaModel(isDark, isArabic),
        child: Consumer<RemontadaModel>(
          builder: (context, v, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Remontada',
              theme: v.themedata,
              locale: v.locale,
              supportedLocales: [
                Locale('ar', ''),
                Locale('en', ''),
              ],
              home: FirebaseAuth.instance.currentUser != null
                  ? HomePage()
                  : StartPage(),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale!.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
            );
          },
        ));
  }
}
