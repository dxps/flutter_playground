import 'dart:io';
import 'package:fsd_blog_be/src/pretty_logging.dart';
import 'package:fsd_blog_be/fsd_blog_be.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:logging/logging.dart';

void main() async {
  // Watch and hot-reload the server on changes
  // done in config/ and web/ directories.
  hierarchicalLoggingEnabled = true;

  var hot = HotReloader(() async {
    var logger = Logger.detached('fsd_blog_be')
      ..level = Level.ALL
      ..onRecord.listen(prettyLog);
    var app = Angel(logger: logger, reflector: MirrorsReflector());
    await app.configure(configureServer);
    return app;
  }, [
    Directory('config'),
    Directory('lib'),
  ]);

  var server = await hot.startServer('127.0.0.1', 3000);
  print('fsd_blog_be Server listening at http://${server.address.address}:${server.port}');
}
