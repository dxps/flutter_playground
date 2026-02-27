import 'package:dart_server/auth/password.dart';
import 'package:dart_server/cors.dart';
import 'package:dart_server/db.dart';
import 'package:dart_server/index.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';

const useSecurity = true;

void main(List<String> arguments) async {
  final db = getDb();

  print('Running course server with security ${useSecurity ? "ON" : "OFF"}.');

  // Uncomment this line if you need to reset the user's password
  db.execute("UPDATE user SET password = ?", [hashPassword("joe")]);

  final address = 'localhost';
  final port = 8080;

  final handler = Pipeline()
      .addMiddleware(
        corsCredentials(allowedOrigins: {
          'http://localhost:54662',
        }),
      )
      .addMiddleware(logRequests())
      .addMiddleware(cookieParser())
      .addHandler(registerControllers(db, useSecurity));

  await shelf_io.serve(handler, address, port);
  print('Server running on $address:$port.');
}
