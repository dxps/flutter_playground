import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///
///
///
class AppState with ChangeNotifier {
  //

  String _displayText = "";

  void setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }

  String get displayText => _displayText;

  String _dataUrl = "https://reqres.in/api/users?per_page=20";
  String _jsonResonse = "";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<void> fetchData() async {
    //
    _isFetching = true;
    notifyListeners();
    var response = await http.get(_dataUrl);
    _jsonResonse = (response.statusCode == 200) ? response.body : _jsonResonse;

    _isFetching = false;
    notifyListeners();
  }

  String get getResponseText => _jsonResonse;

  List<dynamic> getResponseJson() {
    if (_jsonResonse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(_jsonResonse);
      return json['data'];
    }
    return null;
  }

  //
}
