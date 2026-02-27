import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revenue_explorer/http/http.dart';
import 'package:revenue_explorer/preferences/cookies.dart';

class RevExClient {
  final int id;
  final String name;
  final String contactFullName;
  final String contactEmail;
  final String contactPhone;
  final double contractSize;

  RevExClient({
    required this.id,
    required this.name,
    required this.contactFullName,
    required this.contactEmail,
    required this.contactPhone,
    required this.contractSize,
  });

  RevExClient.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        contactFullName = map["contactFullName"],
        contactEmail = map["contactEmail"],
        contactPhone = map["contactPhone"],
        contractSize = map["contractSize"];
}

Future<List<RevExClient>> revExGetClients(List<int> clientIds) async {
  final response = await http.get(
    Uri.http(
      revexApiUrl,
      '/client',
      <String, dynamic>{"clientIds": clientIds.join(',')},
    ),
    headers: await revexDefaultHeaders.withCookies(),
  );

  if (response.statusCode == 401) {
    throw UnauthorizedException();
  }

  if (response.statusCode != 200) {
    return List.empty();
  }

  final List<dynamic> responseList = jsonDecode(response.body);
  return responseList.map((map) => RevExClient.fromMap(map)).toList();
}
