import 'package:shelf/shelf.dart';

Middleware corsCredentials({
  Set<String>?
      allowedOrigins, // null => reflect any origin (not recommended for public APIs)
}) {
  return (Handler inner) {
    return (Request req) async {
      final origin = req.headers['origin'];

      // Decide if this origin is allowed
      final allowOrigin = origin != null &&
          (allowedOrigins == null || allowedOrigins.contains(origin));

      final corsHeaders = <String, String>{
        if (allowOrigin) 'access-control-allow-origin': origin,
        if (allowOrigin) 'vary': 'Origin',
        'access-control-allow-credentials': 'true',
        'access-control-allow-methods':
            'GET, POST, PUT, PATCH, DELETE, OPTIONS',
        'access-control-allow-headers':
            'Origin, Content-Type, Accept, Authorization',
        // optional:
        // 'access-control-max-age': '86400',
      };

      // Preflight
      if (req.method.toUpperCase() == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }

      final res = await inner(req);
      return res.change(headers: {...res.headers, ...corsHeaders});
    };
  };
}
