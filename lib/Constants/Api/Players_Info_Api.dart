import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:remontada/Models/Player_Details_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Player_Info_Api {
  Future<List<Player>> get_upcoming_matches(String player_id) async {
    List<Player> players = [];

    final String api_url =
        'https://api.football-data.org/v4/persons/${player_id}';
    final response = await http.get(Uri.parse(api_url),
        headers: {'X-Auth-Token': 'fa1cc82363374d998d0dfd37fe65c531'});
    if (response.statusCode == 200) {
      final decoded_data = json.decode(response.body);
      var res = Player.fromJson(decoded_data);
      players.add(res);
      save_players(players, player_id);
      return players;
    } else {
      throw Exception('Couldn' 't get data');
    }
  }

  Future<void> save_players(List<Player> players, String player_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(players.map((e) => e.toJson()).toList());
    await prefs.setString('player_info$player_id', data);
  }

  Future<List<Player>> getsavedplayers(String player_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('player_info$player_id');
    if (data != null) {
      Iterable<dynamic> decodeddata = json.decode(data);
      return decodeddata.map((e) => Player.fromJson(e)).toList();
    } else {
      return await get_upcoming_matches(
        player_id,
      );
    }
  }
}
