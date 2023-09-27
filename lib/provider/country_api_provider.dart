import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/country_model.dart';
class CountryApiProvider with ChangeNotifier {
  var allCountries = <CountryModel>[];
  void getAllCountries() async {
    var url = 'https://restcountries.com/v2/all';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var countries in jsonData) {
        CountryModel countryModel = CountryModel.fromJSON(countries);
        allCountries.add(countryModel);
      }
      notifyListeners();
      print(allCountries.length);
    } else {
      print('went wrong');
    }
  }
}