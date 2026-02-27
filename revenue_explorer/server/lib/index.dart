import 'dart:async';

import 'package:dart_server/auth/session.dart';
import 'package:dart_server/controllers/auth.controller.dart';
import 'package:dart_server/controllers/client.controller.dart';
import 'package:dart_server/controllers/transaction.controller.dart';
import 'package:dart_server/controllers/user.controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:sqlite3/sqlite3.dart';

FutureOr<Response> Function(Request) registerControllers(
  Database db,
  bool useSecurity,
) {
  final authorize = createAuthorizeMiddleware(db);

  final unsecuredControllers = [
    AuthController(),
  ];

  final securedControllers = [
    UserController(useSecurity),
    ClientController(),
    TransactionController(),
  ];

  var cascade = Cascade();

  for (var controller in unsecuredControllers) {
    cascade = cascade.add(controller.handle(Router(), db));
  }

  for (var controller in securedControllers) {
    final insecure = controller.handle(Router(), db);
    final secured = authorize(insecure);
    cascade = cascade.add(useSecurity ? secured : insecure);
  }

  return cascade.handler;
}

abstract class Controller {
  abstract final String baseRoute;
  Handler handle(Router router, Database db);
}
