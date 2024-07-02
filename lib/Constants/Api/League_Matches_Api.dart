import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:remontada/Models/League_Matches_Model.dart';
import 'package:remontada/Models/Top_Scorers_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Matches_Api {
  Future<List<Matches>> get_matches(String league, String week) async {
    final String api_url =
        'https://api.football-data.org/v4/competitions/${league}/matches?matchday=${week}';
    final response = await http.get(Uri.parse(api_url),
        headers: {'X-Auth-Token': 'fa1cc82363374d998d0dfd37fe65c531'});
    if (response.statusCode == 200) {
      final decoded_data = json.decode(response.body)['matches'] as List;
      List<Matches> matches =
          decoded_data.map((matches) => Matches.fromJson(matches)).toList();
      save_scorers(matches, league, week);
      return matches;
    } else {
      throw Exception('Couldn' 't get data');
    }
  }

  Future<void> save_scorers(
      List<Matches> matches, String league, String week) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(matches.map((e) => e.toJson()).toList());
    await prefs.setString('matches_data$league$week', data);
  }

  Future<List<Matches>> getsavedmatches(String league, String week) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('matches_data$league$week');
    if (data != null) {
      Iterable<dynamic> decodeddata = json.decode(data);
      return decodeddata.map((e) => Matches.fromJson(e)).toList();
    } else {
      return await get_matches(league, week);
    }
  }
}
