import 'package:crypt/crypt.dart';
import 'package:sqlite3/sqlite3.dart';

String hashPassword(String plaintext) {
  return Crypt.sha256(plaintext).toString();
}

bool _passwordMatches(String attempt, String cryptString) {
  final crypt = Crypt(cryptString);
  return crypt.match(attempt);
}

enum PasswordAttemptResult { NoUserFound, Incorrect, Correct }

PasswordAttemptResult attemptPassword(
  Database db,
  String attempt,
  String userEmail,
) {
  final users = db.select("""
    SELECT * FROM user
    WHERE email = ?
  """, [userEmail]);

  if (users.isEmpty) {
    return PasswordAttemptResult.NoUserFound;
  }

  final user = users.first;
  final matches = _passwordMatches(attempt, user["password"]);
  return matches
      ? PasswordAttemptResult.Correct
      : PasswordAttemptResult.Incorrect;
}
