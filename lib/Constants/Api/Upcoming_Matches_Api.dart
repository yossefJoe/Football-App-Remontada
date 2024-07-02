import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:remontada/Models/League_Matches_Model.dart';
import 'package:remontada/Models/Top_Scorers_Model.dart';
import 'package:remontada/Models/Upcoming_Matches_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Upcoming_Api {
  Future<List<Upcoming>> get_upcoming_matches(String team_id) async {
    final String api_url =
        'https://api.football-data.org/v4/teams/${team_id}/matches?status=SCHEDULED';
    final response = await http.get(Uri.parse(api_url),
        headers: {'X-Auth-Token': 'fa1cc82363374d998d0dfd37fe65c531'});
    if (response.statusCode == 200) {
      final decoded_data = json.decode(response.body)['matches'] as List;
      List<Upcoming> matches =
          decoded_data.map((matches) => Upcoming.fromJson(matches)).toList();
      save_scorers(matches, team_id);
      return matches;
    } else {
      throw Exception('Couldn' 't get data');
    }
  }

  Future<void> save_scorers(List<Upcoming> matches, String team_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(matches.map((e) => e.toJson()).toList());
    await prefs.setString('upcoming_matches_data$team_id', data);
  }

  Future<List<Upcoming>> getsavedupcomingmatches(String team_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('upcoming_matches_data$team_id');
    if (data != null) {
      Iterable<dynamic> decodeddata = json.decode(data);
      return decodeddata.map((e) => Upcoming.fromJson(e)).toList();
    } else {
      return await get_upcoming_matches(
        team_id,
      );
    }
  }
}
