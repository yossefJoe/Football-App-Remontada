import 'dart:convert';

import 'package:remontada/Models/Teams_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Teams_Api {
  Future<List<Teams>> get_teams(String league) async {
    String api_url =
        "https://www.thesportsdb.com/api/v1/json/3/search_all_teams.php?l=${league}";
    final response = await http.get(Uri.parse(api_url));
    if (response.statusCode == 200) {
      final decode_data = json.decode(response.body)['teams'] as List;
      List<Teams> teams =
          decode_data.map((team) => Teams.fromJson(team)).toList();
      await saveTeamsData(teams, league);
      return teams;
    } else {
      throw Exception("Failed to load teams");
    }
  }

  Future<void> saveTeamsData(List<Teams> teams, String league) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(teams.map((e) => e.toJson()).toList());
    await prefs.setString('teamsData_$league', jsonData);
  }

  Future<List<Teams>> getSavedOrFetchTeams(String league) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('teamsData_$league');

    if (jsonData != null) {
      // Load data from SharedPreferences
      Iterable<dynamic> decodedData = json.decode(jsonData);
      return decodedData.map((e) => Teams.fromJson(e)).toList();
    } else {
      // Fetch data from the API and save it
      return await get_teams(league);
    }
  }
}
