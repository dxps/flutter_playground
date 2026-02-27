import 'dart:convert';

import 'package:dart_server/index.dart';
import 'package:shelf/shelf.dart';
import 'package:sqlite3/src/ffi/api/database.dart';
import 'package:shelf_router/src/router.dart';

class _ClientDto {
  final int id;
  final String name;
  final String contactFullName;
  final String contactEmail;
  final String contactPhone;
  final double contractSize;

  _ClientDto({
    required this.id,
    required this.name,
    required this.contactFullName,
    required this.contactEmail,
    required this.contactPhone,
    required this.contractSize,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "contactFullName": contactFullName,
      "contactEmail": contactEmail,
      "contactPhone": contactPhone,
      "contractSize": contractSize,
    };
  }
}

class ClientController implements Controller {
  @override
  final String baseRoute = '/client';

  @override
  Handler handle(Router router, Database db) {
    router.get("$baseRoute", (Request request) {
      final clientIds = request.url.queryParameters["clientIds"]?.split(",");

      if (clientIds == null || clientIds.isEmpty) {
        return Response.badRequest();
      }

      final clients = db
          .select("SELECT * FROM client WHERE id IN (${clientIds.join(",")})")
          .map((row) => new _ClientDto(
                id: row["id"],
                name: row["name"],
                contactFullName: row["contactFullName"],
                contactEmail: row["contactEmail"],
                contactPhone: row["contactPhone"],
                contractSize: row["contractSize"],
              ));

      return Response.ok(json.encode(clients.map((c) => c.toMap()).toList()));
    });

    return router;
  }
}
