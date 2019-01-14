import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../models/item_model.dart';
import 'repository.dart';

//
class NewsDbProvider implements Source, Cache {
  //

  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    //
    Directory docsDir = await getApplicationDocumentsDirectory();
    final path = join(docsDir.path, "items.db");
    print('(dbg) [NewsDbProvider] > init() > Opening db file $path \n');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE items (
            id           INTEGER PRIMARY KEY,
            title        TEXT,
            type         TEXT,
            by           TEXT,
            time         INTEGER,
            text         TEXT,
            parent       INTEGER,
            kids         BLOB,
            dead         INTEGER,
            deleted      INTEGER,
            url          TEXT,
            score        INTEGER,
            descendants  INTEGER
          )
        """);
      },
    );
  }

  // TBD, now present just to satisfy the contract.
  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
    //
    final maps = await db.query("items", columns: null, where: "id = ?", whereArgs: [id]);
    if (maps.length > 0) {
      final entry = maps.first;
      //print('(dbg) [NewsDbProvider] fetchItem($id) > Found title "${entry['title']}"');
      return ItemModel.fromDb(entry);
    } else {
      return null;
    }
  }

  Future<int> addItem(ItemModel item) {
    //
    return db.insert("items", item.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> clear() {
    //
    return db.delete("items");
  }

  //
}
