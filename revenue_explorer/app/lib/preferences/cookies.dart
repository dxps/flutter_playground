import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const COOKIE_PREFIX = 'COOKIE_';
const COOKIE_EXPIRY = 'COOKIE-EXPIRY';

Future<List<Cookie>> revexGetAuthCookies() async {
  final prefs = await SharedPreferences.getInstance();

  final expiry = prefs.getString(COOKIE_EXPIRY);
  if (expiry == null || DateTime.parse(expiry).isBefore(DateTime.now())) {
    await _clearAuthCookies();
    return [];
  }

  final storedCookies =
      prefs.getKeys().where((key) => key.startsWith(COOKIE_PREFIX));

  return storedCookies.map((key) {
    final cookie = prefs.getString(key) ?? "";
    return Cookie.fromSetCookieValue(cookie);
  }).toList();
}

Future<void> revexSetAuthCookies(List<Cookie> cookies) async {
  final prefs = await SharedPreferences.getInstance();

  print(">>> cookies: $cookies");

  final maxAge = cookies.map((c) => c.maxAge).whereNotNull().reduce(min);
  if (maxAge == 0) {
    await _clearAuthCookies();
    return;
  }

  for (var cookie in cookies) {
    final key = "$COOKIE_PREFIX${cookie.name}";
    await prefs.setString(key, cookie.toString());
  }

  final expiry =
      DateTime.now().add(Duration(seconds: maxAge)).toIso8601String();
  await prefs.setString(COOKIE_EXPIRY, expiry);
}

Future<void> _clearAuthCookies() async {
  final prefs = await SharedPreferences.getInstance();
  final storedCookies =
      prefs.getKeys().where((key) => key.startsWith(COOKIE_PREFIX));

  for (var key in storedCookies) {
    await prefs.remove(key);
  }
}

extension RevExStoreCookies on Response {
  Future<void> captureCookies() async {
    print(">>> Got headers['Set-Cookie']: ${headers['Set-Cookie']}");
    final cookies = headers['set-cookie']
            ?.split(',')
            .map((val) => Cookie.fromSetCookieValue(val))
            .toList() ??
        [];
    await revexSetAuthCookies(cookies);
  }
}

extension RevExUseCookies on Map<String, String> {
  Future<Map<String, String>> withCookies() async {
    final cookies = await revexGetAuthCookies();
    final cookieString = cookies.map((c) => "${c.name}=${c.value}").join("; ");
    final newHeaders = <String, String>{};
    newHeaders.addAll(this);
    newHeaders['Cookie'] = cookieString;
    return newHeaders;
  }
}
