import 'dart:convert';

import 'package:dart_server/index.dart';
import 'package:shelf/shelf.dart';
import 'package:sqlite3/src/ffi/api/database.dart';
import 'package:shelf_router/src/router.dart';

class _TransactionDto {
  final int id;
  final String purchaserName;
  final String purchaseDate;
  final double amount;
  final String productCode;
  final bool isFlagged;

  _TransactionDto({
    required this.id,
    required this.purchaserName,
    required this.purchaseDate,
    required this.amount,
    required this.productCode,
    required this.isFlagged,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "purchaserName": purchaserName,
      "purchaseDate": purchaseDate,
      "amount": amount,
      "productCode": productCode,
      "isFlagged": isFlagged,
    };
  }
}

class TransactionController implements Controller {
  @override
  final String baseRoute = '/transaction';

  @override
  Handler handle(Router router, Database db) {
    router.get("$baseRoute", (Request request) {
      final transactions = db.select(""" SELECT * FROM "transaction" """).map(
          (row) => new _TransactionDto(
                id: row["transaction_id"],
                purchaserName: row["purchaser_name"],
                purchaseDate: row["purchase_date"],
                amount: row["transaction_amount"],
                productCode: row["product_code"],
                isFlagged: row["is_flagged"] == 1,
              ));

      return Response.ok(
          json.encode(transactions.map((c) => c.toMap()).toList()));
    });

    return router;
  }
}
