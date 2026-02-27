import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revenue_explorer/http/http.dart';
import 'package:revenue_explorer/preferences/cookies.dart';

class RevExTransaction {
  final int id;
  final String purchaserName;
  final String purchaseDate;
  final double amount;
  final String productCode;

  RevExTransaction({
    required this.id,
    required this.purchaserName,
    required this.purchaseDate,
    required this.amount,
    required this.productCode,
  });

  RevExTransaction.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        purchaserName = map["purchaserName"],
        purchaseDate = map["purchaseDate"],
        amount = map["amount"],
        productCode = map["productCode"];
}

Future<List<RevExTransaction>> revExGetTransactions() async {
  final response = await http.get(
    Uri.http(revexApiUrl, '/transaction'),
    headers: await revexDefaultHeaders.withCookies(),
  );

  if (response.statusCode == 401) {
    throw UnauthorizedException();
  }

  if (response.statusCode != 200) {
    return List.empty();
  }

  final List<dynamic> responseList = jsonDecode(response.body);
  return responseList.map((map) => RevExTransaction.fromMap(map)).toList();
}
