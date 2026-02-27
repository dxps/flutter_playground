import 'package:collection/collection.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

const authCookieName = "auth";
const emailCookieName = "email";

final uuid = Uuid(options: {
  "grng": UuidUtil.cryptoRNG,
});

class AuthSession {
  final int id;
  final int user_id;
  final String cookie;
  final DateTime expiration;

  AuthSession({
    required this.id,
    required this.user_id,
    required this.cookie,
    required this.expiration,
  });

  AuthSession.fromDb(Row row)
      : id = row["id"],
        user_id = row["user_id"],
        cookie = row["cookie"],
        expiration = DateTime.parse(row["expiration"]);
}

AuthSession? getValidSession(
    Database db, String userEmail, String sessionCookie) {
  final sessions = db.select('''
    SELECT s.* FROM session s
    INNER JOIN user u
      ON s.user_id = u.id
    WHERE u.email = ?
  ''', [userEmail]).map((row) => AuthSession.fromDb(row)).toList();

  final expiredSessionIds = sessions
      .where((session) => session.expiration.isBefore(DateTime.now()))
      .map((session) => session.id)
      .toList();

  if (expiredSessionIds.isNotEmpty) {
    db.execute('''
      DELETE FROM session
      WHERE id IN (${expiredSessionIds.join(",")})
    ''');
  }

  final validSessions =
      sessions.where((session) => session.expiration.isAfter(DateTime.now()));

  return validSessions
      .firstWhereOrNull((session) => session.cookie == sessionCookie);
}

String _generateSessionCookie() {
  return uuid.v4();
}

String createSession(Database db, String userEmail) {
  final users = db.select("""
    SELECT * FROM user
    WHERE email = ?
  """, [userEmail]);

  if (users.isEmpty) {
    throw new Exception("No user found.");
  }

  final user = users.first;
  final cookie = _generateSessionCookie();
  final expiration = DateTime.now().add(Duration(days: 3));
  db.execute("""
    INSERT INTO session (user_id, cookie, expiration)
    VALUES (${user["id"] as int}, '$cookie', '${expiration.toIso8601String()}')
  """);

  return cookie;
}

void endAllSessions(Database db, String userEmail) {
  final users = db.select("""
    SELECT * FROM user
    WHERE email = ?
  """, [userEmail]);

  if (users.isEmpty) {
    throw new Exception("No user found.");
  }

  final user = users.first;

  db.execute("""
    DELETE FROM session
    WHERE user_id = ?
  """, [user["id"] as int]);
}

void clearSessionCookies(CookieParser cookies) {
  cookies.set(authCookieName, '', maxAge: 0);
  cookies.set(emailCookieName, '', maxAge: 0);
}

Middleware Function(Database) createAuthorizeMiddleware = (Database db) =>
    createMiddleware(requestHandler: (request) {
      final cookies = request.context["cookies"] as CookieParser;
      final authCookie = cookies.get(authCookieName);

      if (authCookie == null || authCookie.value.isEmpty) {
        clearSessionCookies(cookies);
        return Response.unauthorized(null);
      }

      final email = cookies.get(emailCookieName);
      if (email == null || email.value.isEmpty) {
        clearSessionCookies(cookies);
        return Response.unauthorized(null);
      }

      final validSession = getValidSession(db, email.value, authCookie.value);

      if (validSession != null) {
        return null;
      }

      clearSessionCookies(cookies);
      return Response.unauthorized(null);
    });
