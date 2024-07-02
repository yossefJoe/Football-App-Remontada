import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remontada/Models/National_Team_Model.dart';
import 'package:remontada/Models/News_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class News_Api {
  Future<List<News>> get_news(String type, String date) async {
    final String api_url =
        'https://api.sportradar.com/content-soccer-t3/ap/${type}/news/${date}/all.json?api_key=za7171Xueo417Nl982CIz7IGMaW6Mg0y4tUMQ9Rk';
    final response = await http
        .get(Uri.parse(api_url), headers: {'accept': ' application/json'});
    if (response.statusCode == 200) {
      final decoded_data = json.decode(response.body)['items'] as List;
      List<News> news =
          decoded_data.map((news) => News.fromJson(news)).toList();
      save_news(news, type, date);
      return news;
    } else {
      throw Exception('Couldn' 't get data');
    }
  }

  Future<void> save_news(List<News> news, String type, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(news.map((e) => e.toJson()).toList());
    await prefs.setString('news_data$type$date', data);
  }

  Future<List<News>> getsavednews(String type, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('news_data$type$date');
    if (data != null) {
      Iterable<dynamic> decodeddata = json.decode(data);
      return decodeddata.map((e) => News.fromJson(e)).toList();
    } else {
      return await get_news(type, date);
    }
  }
}
