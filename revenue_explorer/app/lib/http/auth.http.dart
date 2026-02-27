import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revenue_explorer/preferences/cookies.dart';
import 'http.dart';

Future<bool> revExLogIn(String email, String password) async {
  final response = await http.post(
    Uri.http(revexApiUrl, '/auth/login'),
    headers: revexDefaultHeaders,
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode != 200) {
    return false;
  }

  await response.captureCookies();
  return true;
}

Future revExLogOut() async {
  final response = await http.get(
    Uri.http(revexApiUrl, '/auth/logout'),
    headers: await revexDefaultHeaders.withCookies(),
  );
  await response.captureCookies();
}
