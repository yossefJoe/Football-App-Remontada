import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:remontada/Models/Top_Scorers_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Scorers_Api {
  Future<List<Scorers>> get_socrers(String league) async {
    final String api_url =
        'https://api.football-data.org/v4/competitions/${league}/scorers';
    final response = await http.get(Uri.parse(api_url),
        headers: {'X-Auth-Token': 'fa1cc82363374d998d0dfd37fe65c531'});
    if (response.statusCode == 200) {
      final decoded_data = json.decode(response.body)['scorers'] as List;
      List<Scorers> scorers =
          decoded_data.map((scorers) => Scorers.fromJson(scorers)).toList();
      save_scorers(scorers, league);
      return scorers;
    } else {
      throw Exception('Couldn' 't get data');
    }
  }

  Future<void> save_scorers(List<Scorers> news, String league) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(news.map((e) => e.toJson()).toList());
    await prefs.setString('scorers_data$league', data);
  }

  Future<List<Scorers>> getsavedscorers(String league) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('scorers_data$league');
    if (data != null) {
      Iterable<dynamic> decodeddata = json.decode(data);
      return decodeddata.map((e) => Scorers.fromJson(e)).toList();
    } else {
      return await get_socrers(league);
    }
  }
}
