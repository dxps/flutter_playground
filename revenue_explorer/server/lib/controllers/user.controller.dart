import 'dart:convert';

import 'package:dart_server/auth/session.dart';
import 'package:dart_server/index.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/src/router.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';
import 'package:sqlite3/src/ffi/api/database.dart';

class _UserDto {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String? profilePictureUrl;
  final String jobTitle;
  final List<int> clientAccountIds;

  _UserDto({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.profilePictureUrl,
    required this.jobTitle,
    required this.clientAccountIds,
  });

  Map<String, Object?> toMap() {
    return <String, Object?>{
      "id": id,
      "username": username,
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "profilePictureUrl": profilePictureUrl,
      "jobTitle": jobTitle,
      "clientAccountIds": clientAccountIds.toString(),
    };
  }
}

class UserController implements Controller {
  final bool useSecurity;

  const UserController(this.useSecurity) : super();

  @override
  final String baseRoute = '/user';

  @override
  Handler handle(Router router, Database db) {
    router.get(baseRoute, (Request request) {
      String email;

      if (useSecurity) {
        final cookies = request.context["cookies"] as CookieParser;
        email = cookies.get(emailCookieName)?.value ?? '';
      } else {
        email = 'joe@doe.com';
      }

      final user = db
          .select("SELECT * FROM user WHERE email = '$email'")
          .map((row) => new _UserDto(
                id: row["id"],
                username: row["username"],
                fullName: row["fullName"],
                email: row["email"],
                phone: row["phone"],
                profilePictureUrl: row["profilePictureUrl"],
                jobTitle: row["jobTitle"],
                clientAccountIds: <int>[],
              ))
          .first;
      final userClients = db.select("SELECT * FROM user_clients");

      for (final row in userClients) {
        user.clientAccountIds.add(row["clientId"]);
      }

      return Response.ok(json.encode(user.toMap()));
    });

    // get logged-in user's userId
    router.get("$baseRoute/current", (Request request) {
      final session = request.context["session"] as AuthSession?;
      if (session == null) {
        return Response.badRequest();
      }

      return Response.ok(session.user_id.toString());
    });

    return router;
  }
}
