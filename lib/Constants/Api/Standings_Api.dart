import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remontada/Models/Standings_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Standings_Api {
  Future<List<Standings>> get_tables(String league) async {
    final String api_url =
        'https://api.football-data.org/v4/competitions/${league}/standings';
    final response = await http.get(Uri.parse(api_url),
        headers: {'X-Auth-Token': 'fa1cc82363374d998d0dfd37fe65c531'});
    if (response.statusCode == 200) {
      final decoded_data = json.decode(response.body)['standings'] as List;
      List<Standings> tables =
          decoded_data.map((tables) => Standings.fromJson(tables)).toList();
      save_tables(tables, league);
      return tables;
    } else {
      throw Exception('Couldn' 't get data');
    }
  }

  Future<void> save_tables(List<Standings> tables, String league) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(tables.map((e) => e.toJson()).toList());
    await prefs.setString('standings_data$league', data);
  }

  Future<List<Standings>> getsavedtables(String league) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('standings_data$league');
    if (data != null) {
      Iterable<dynamic> decodeddata = json.decode(data);
      return decodeddata.map((e) => Standings.fromJson(e)).toList();
    } else {
      return await get_tables(league);
    }
  }
}
