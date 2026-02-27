import 'dart:convert';

import 'package:dart_server/auth/password.dart';
import 'package:dart_server/auth/session.dart';
import 'package:dart_server/index.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';
import 'package:sqlite3/src/ffi/api/database.dart';

class AuthController implements Controller {
  @override
  final String baseRoute = '/auth';

  @override
  Handler handle(Router router, Database db) {
    router.post('$baseRoute/login', (Request request) async {
      final body = jsonDecode(await request.readAsString());
      final email = body['email'] as String?;
      final passwordAttempt = body['password'] as String?;

      if (email == null || passwordAttempt == null) {
        return Response.badRequest();
      }

      final loginResult = attemptPassword(db, passwordAttempt, email);
      switch (loginResult) {
        case PasswordAttemptResult.NoUserFound:
        case PasswordAttemptResult.Incorrect:
          return Response.unauthorized(null);

        case PasswordAttemptResult.Correct:
          final cookies = request.context['cookies'] as CookieParser;

          final sessionId = createSession(db, email);

          // For localhost over http, keep secure=false.
          // For production over https + cross-site cookies, use secure=true and SameSite=None.
          cookies.set(
            authCookieName,
            sessionId,
            maxAge: 259200,
            secure: false,
            httpOnly: false,
            // if your shelf_secure_cookie version supports it:
            // sameSite: SameSite.lax,
          );

          return Response.ok(
            jsonEncode({'email': email}),
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
      }
    });

    router.get('$baseRoute/logout', (Request request) async {
      final cookies = request.context['cookies'] as CookieParser;

      // Clear the session cookie.
      cookies.set(
        authCookieName,
        '',
        maxAge: 0,
        secure: false,
        httpOnly: true,
        // sameSite: SameSite.lax,
      );

      // If you need to end sessions, do it based on the session id (auth cookie),
      // or on server-side lookup, not an "email cookie".
      // Example if you can read session id from cookie parser:
      // final sessionId = cookies.get(authCookieName)?.value;
      // if (sessionId != null) endSession(db, sessionId);

      return Response.ok(
        jsonEncode({'ok': true}),
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });

    return router;
  }
}
