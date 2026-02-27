import 'package:shelf/shelf.dart';

Middleware corsAll() {
  const headers = <String, String>{
    'access-control-allow-origin': '*',
    'access-control-allow-methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
    'access-control-allow-headers':
        'Origin, Content-Type, Accept, Authorization',
    // optional:
    // 'access-control-max-age': '86400',
  };

  return (Handler inner) {
    return (Request req) async {
      // Preflight
      if (req.method.toUpperCase() == 'OPTIONS') {
        return Response.ok('', headers: headers);
      }

      final res = await inner(req);
      return res.change(headers: {
        ...res.headers,
        ...headers,
      });
    };
  };
}
