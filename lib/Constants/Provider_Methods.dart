// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemontadaModel with ChangeNotifier {
  int currentindex = 0;

  void changeindex(int value) {
    currentindex = value;
    notifyListeners();
  }

  Locale _locale = Locale('ar', '');
  Locale get locale => _locale;
  void change_language() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_locale.languageCode == 'ar') {
      _locale = Locale('en', '');
      prefs.setBool("is_arabic", false);
    } else if (_locale.languageCode == 'en') {
      _locale = Locale('ar', '');
      prefs.setBool("is_arabic", true);
    }
    notifyListeners();
  }

  bool is_switched = false;

  void open_switch(bool value) {
    is_switched = value;
    notifyListeners();
  }

  RemontadaModel(bool is_dark, bool is_arabic) {
    if (is_dark) {
      _themedata = ThemeData.light();
    } else {
      _themedata = ThemeData.dark();
    }

    if (is_arabic) {
      _locale = Locale('ar', '');
    } else {
      _locale = Locale('en', '');
    }
  }
  ThemeData _themedata = ThemeData.light();
  ThemeData get themedata => _themedata;
  void change_mode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_themedata == ThemeData.light()) {
      _themedata = ThemeData.dark();
      prefs.setBool("is_dark", false);
    } else {
      _themedata = ThemeData.light();
      prefs.setBool("is_dark", true);
    }
    notifyListeners();
  }

  int old_position = 0;
  void change_position(int position) {
    old_position = position.toInt();
    notifyListeners();
  }

  String Continent = 'eu';
  Future<void> choose_continent(int index) async {
    List<String> types = ['eu', 'af', 'as', 'am', 'am'];
    Continent = types[index];
    notifyListeners();
  }

  String default_america = "sa";
  void which_america(int index) {
    if (index == 4) {
      default_america = 'na';
    } else {
      default_america = 'sa';
    }
    notifyListeners();
  }

  String League = 'Spanish%20La%20Liga';
  Future<void> choose_league(int index) async {
    List<String> types = [
      'Spanish%20La%20Liga',
      'Italian%20Serie%20A',
      'English%20Premier%20League',
      'German%20Bundesliga',
      'French%20Ligue%201',
      'Egyptian%20Premier%20League',
      'Saudi-Arabian%20Pro%20League',
      'Brazilian%20Serie%20A'
    ];
    League = types[index];
    notifyListeners();
  }

  Set<int> selectedteams =
      {}; // Initialize an empty set to keep track of selected items
  void change_team_border(int index) {
    if (selectedteams.contains(index)) {
      selectedteams.remove(index); // Deselect if already selected
    } else {
      selectedteams.add(index); // Select if not selected
    }
    notifyListeners();
  }

  void empty_team_set() {
    selectedteams = {};
    notifyListeners();
  }

  Set<int> selectednationals =
      {}; // Initialize an empty set to keep track of selected items
  void change_national_border(int index) {
    if (selectednationals.contains(index)) {
      selectednationals.remove(index); // Deselect if already selected
    } else {
      selectednationals.add(index); // Select if not selected
    }
    notifyListeners();
  }

  void empty_national_set() {
    selectednationals = {};
    notifyListeners();
  }

  String default_news = 'epl';
  Future<void> choose_news(int index) async {
    List news_type = ['la-liga', 'epl', 'intl-soccer', 'uefa-champions-league'];
    default_news = news_type[index];
    notifyListeners();
  }

  String default_championship = 'PL';
  Future<void> choose_chmpionship(int index) async {
    List championship_type = [
      'PL',
      'BL1',
      'DED',
      'BSA',
      'PD',
      'FL1',
      'PPL',
      'SA',
      'CL',
      'CLI',
      'WC'
    ];
    default_championship = championship_type[index];
    notifyListeners();
  }

  int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  void selectChampionship(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int tab_index = 0;
  void select_tap(int value) {
    tab_index = value;
    print('tap changed');

    notifyListeners();
  }

  String selected_item = '1';
  Future<void> dropdown(String new_value) async {
    selected_item = new_value;
    print('drop down pressed');
    notifyListeners();
  }

  void return_default() {
    selected_item = '1';
    notifyListeners();
  }

  double font_size = 15;
  void default_size() {
    font_size = 15;
    notifyListeners();
  }

  void change_font_size(double newvalue) {
    font_size = newvalue;
    notifyListeners();
  }
}
