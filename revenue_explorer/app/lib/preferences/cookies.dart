import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const COOKIE_PREFIX = 'COOKIE_';
const COOKIE_EXPIRY = 'COOKIE-EXPIRY';

// Fallback if Max-Age is not parseable (3 days)
const int DEFAULT_MAX_AGE_SECONDS = 259200;

int? _parseMaxAgeSeconds(String setCookie) {
  final m = RegExp(r'(?i)\bmax-age=(\d+)\b').firstMatch(setCookie);
  return m == null ? null : int.tryParse(m.group(1)!);
}

String? _parseNameValue(String setCookie) {
  // First segment is "name=value"
  final first = setCookie.split(';').first.trim();
  if (first.isEmpty) return null;
  final eq = first.indexOf('=');
  if (eq <= 0) return null;
  return first; // keep as "name=value"
}

String? _parseName(String nameValue) {
  final eq = nameValue.indexOf('=');
  if (eq <= 0) return null;
  return nameValue.substring(0, eq);
}

Future<List<String>> revexGetStoredCookieNameValues() async {
  final prefs = await SharedPreferences.getInstance();

  final expiry = prefs.getString(COOKIE_EXPIRY);
  if (expiry == null || DateTime.parse(expiry).isBefore(DateTime.now())) {
    await _clearAuthCookies();
    return [];
  }

  final keys = prefs.getKeys().where((k) => k.startsWith(COOKIE_PREFIX));
  return keys.map((k) => prefs.getString(k)).whereType<String>().toList();
}

Future<void> revexSetAuthCookiesFromSetCookie(String setCookie) async {
  final prefs = await SharedPreferences.getInstance();

  final nameValue = _parseNameValue(setCookie);
  if (nameValue == null) {
    return;
  }
  final name = _parseName(nameValue);
  if (name == null) {
    return;
  }

  final maxAge = _parseMaxAgeSeconds(setCookie) ?? DEFAULT_MAX_AGE_SECONDS;

  if (maxAge == 0) {
    await _clearAuthCookies();
    return;
  }

  // Store only "name=value" because that's what you need for request Cookie header
  await prefs.setString('$COOKIE_PREFIX$name', nameValue);

  final expiry =
      DateTime.now().add(Duration(seconds: maxAge)).toIso8601String();
  await prefs.setString(COOKIE_EXPIRY, expiry);
}

Future<void> _clearAuthCookies() async {
  final prefs = await SharedPreferences.getInstance();
  final keys =
      prefs.getKeys().where((k) => k.startsWith(COOKIE_PREFIX)).toList();
  for (final k in keys) {
    await prefs.remove(k);
  }
  await prefs.remove(COOKIE_EXPIRY);
}

extension RevExStoreCookies on Response {
  Future<void> captureCookies() async {
    // package:http lowercases header keys
    final sc = headers['set-cookie'];
    if (sc == null || sc.isEmpty) return;

    // You now only send one cookie, so do NOT split on commas.
    await revexSetAuthCookiesFromSetCookie(sc.trim());
  }
}

extension RevExUseCookies on Map<String, String> {
  Future<Map<String, String>> withCookies() async {
    final nameValues = await revexGetStoredCookieNameValues();
    final cookieHeader = nameValues.join('; ');

    final newHeaders = <String, String>{...this};
    if (cookieHeader.isNotEmpty) {
      newHeaders['Cookie'] = cookieHeader;
    }
    return newHeaders;
  }
}
