import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revenue_explorer/preferences/cookies.dart';

import 'http.dart';

class RevExUser {
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String? profilePictureUrl;
  final String jobTitle;
  final List<int> clientAccountIds;

  RevExUser({
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    this.profilePictureUrl,
    required this.jobTitle,
    required this.clientAccountIds,
  });

  RevExUser.fromMap(Map<String, dynamic> map)
      : username = map["username"],
        fullName = map["fullName"],
        email = map["email"],
        phone = map["phone"],
        profilePictureUrl = map["profilePictureUrl"],
        jobTitle = map["jobTitle"],
        clientAccountIds =
            (jsonDecode(map["clientAccountIds"]) as List<dynamic>)
                .map((id) => id as int)
                .toList();
}

Future<RevExUser> revExGetUser() async {
  final response = await http.get(
    Uri.http(
      revexApiUrl,
      '/user',
    ),
    headers: await revexDefaultHeaders.withCookies(),
  );

  if (response.statusCode == 401) {
    throw UnauthorizedException();
  }

  if (response.statusCode != 200) {
    throw Exception("Couldn't get user.");
  }

  final dynamic responseObject = jsonDecode(response.body);
  return RevExUser.fromMap(responseObject);
}
