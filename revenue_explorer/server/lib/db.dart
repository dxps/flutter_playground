import 'package:sqlite3/sqlite3.dart';

Database getDb() {
  final db = sqlite3.open("./lib/database.db", mode: OpenMode.readWrite);
  final tables = db.select(
      "SELECT name FROM sqlite_schema WHERE type='table' ORDER BY name");
  print(
    "${tables.length} SQLite tables found: ${tables.map((row) => row["name"])}",
  );
  return db;
}
