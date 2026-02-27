import 'dart:convert';

import 'package:dart_server/auth/password.dart';
import 'package:dart_server/auth/session.dart';
import 'package:dart_server/index.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';
import 'package:sqlite3/src/ffi/api/database.dart';
import 'package:shelf_router/src/router.dart';

class AuthController implements Controller {
  @override
  final String baseRoute = '/auth';

  @override
  Handler handle(Router router, Database db) {
    // /login
    router.post("$baseRoute/login", (Request request) async {
      final body = json.decode(await request.readAsString());
      final email = body["email"];
      final passwordAttempt = body["password"];

      if (email == null || passwordAttempt == null) {
        return Response.badRequest();
      }

      final loginResult = attemptPassword(db, passwordAttempt, email);
      switch (loginResult) {
        case PasswordAttemptResult.NoUserFound:
          return Response.unauthorized(null);
        case PasswordAttemptResult.Incorrect:
          return Response.unauthorized(null);
        case PasswordAttemptResult.Correct:
          final cookies = request.context["cookies"] as CookieParser;
          final authCookie = createSession(db, email);
          cookies.set(
            authCookieName,
            authCookie,
            maxAge: 259200,
            secure: true,
            httpOnly: true,
          );
          cookies.set(
            emailCookieName,
            email,
            maxAge: 259200,
            secure: true,
            httpOnly: true,
          );
          return Response.ok(null);
      }
    });

    // /logout
    router.get("$baseRoute/logout", (Request request) async {
      final cookies = request.context["cookies"] as CookieParser;
      clearSessionCookies(cookies);

      final userEmail = cookies.get(emailCookieName)?.value;
      if (userEmail != null) {
        endAllSessions(db, userEmail);
      }
      return Response.ok(null);
    });

    return router;
  }
}
