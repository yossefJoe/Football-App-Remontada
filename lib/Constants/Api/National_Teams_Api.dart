import 'dart:convert';

import 'package:remontada/Models/National_Team_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class National_Api {
  bool get_African(String national) {
    const Set<String> africanCountries = {
      "Egypt",
      "Angola",
      "Algeria",
      "Burkina Faso",
      "Cameroon",
      "Ivory Coast",
      "Gabon",
      "Ghana",
      "Guinea",
      "Kenya",
      "Mali",
      "Morocco",
      "Mozambique",
      "Tunisia",
      "Congo",
      "Nigeria"
    };
    return africanCountries.contains(national);
  }

  bool get_Asian(String national) {
    const Set<String> asianCountries = {
      "Saudi Arabia",
      "Australia",
      "UAE",
      "Qatar",
      "China",
      "South Korea",
      "India",
      "Iraq",
      "Iran",
      "Japan",
      "Jordan",
      "Kuwait",
      "Oman",
      "New Zealand",
      "Uzbekistan",
      "Palestine"
    };
    return asianCountries.contains(national);
  }

  bool get_European(String national) {
    const Set<String> africanCountries = {
      "Germany",
      "England",
      "Portugal",
      "Spain",
      "France",
      "Italy",
      "Croatia",
      "Scotland",
      "Greece",
      "Ireland",
      "Turkey",
      "Switzerland",
      "Sweden",
      "Russia",
      "Poland",
      "Netherlands"
    };
    return africanCountries.contains(national);
  }

  bool get_North_American(String national) {
    const Set<String> africanCountries = {
      "United States",
      "Jamaica",
      "Canada",
      "Mexico",
      "Panama",
      "Costa Rica",
      "Dominican Republic",
      "Honduras"
    };
    return africanCountries.contains(national);
  }

  bool get_South_American(String national) {
    const Set<String> africanCountries = {
      "Brazil",
      "Argentina",
      "Colombia",
      "Peru",
      "Chile",
      "Venezuela",
      "Uruguay",
      "Paraguay",
      "Trinidad and Tobago",
      "Bolivia"
    };
    return africanCountries.contains(national);
  }

  Future<List<Countries>> get_nationals(String continent) async {
    String api_url =
        "https://apiclient.besoccerapps.com/scripts/api/api.php?key=36fcdec140e0017dd4d35dc2bc4aaa56&tz=Europe/Madrid&format=json&req=countries_competitions&filter=${continent}&lang=en";
    final response = await http.get(Uri.parse(api_url));
    if (response.statusCode == 200) {
      final decode_data = json.decode(response.body)['countries'] as List;
      List<Countries> countries =
          decode_data.map((team) => Countries.fromJson(team)).toList();

      await saveCountriesData(countries, continent);

      return countries;
    } else {
      throw Exception("Something Happened");
    }
  }

  Future<void> saveCountriesData(
      List<Countries> countries, String continent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(countries.map((e) => e.toJson()).toList());
    await prefs.setString('countriesData_$continent', jsonData);
  }

  Future<List<Countries>> getSavedOrFetchNationals(
      String continent, String america) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('countriesData_$continent');

    if (jsonData != null) {
      // Load data from SharedPreferences
      Iterable<dynamic> decodedData = json.decode(jsonData);
      return decodedData
          .map((e) => Countries.fromJson(e))
          .where((element) => continent == 'af'
              ? get_African(element.name.toString())
              : continent == 'as'
                  ? get_Asian(element.name.toString())
                  : continent == 'eu'
                      ? get_European(element.name.toString())
                      : continent == 'am' && america == 'sa'
                          ? get_South_American(element.name.toString())
                          : continent == 'am' && america == 'na'
                              ? get_North_American(element.name.toString())
                              : false)
          .toList();
    } else {
      // Fetch data from the API and save it
      return await get_nationals(continent);
    }
  }
}
