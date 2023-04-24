import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timeline/model/game_card.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

   Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TimeLineDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE GameCard ("
          "id INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "blocked BIT"
          ")");
    });
  }

  Future<List<GameCard>> getAllGameCards() async {
    final db = await database;
    var res = await db!.query("GameCard");
    List<GameCard> list =
        res.isNotEmpty ? res.map((c) => GameCard.fromMap(c)).toList() : [];
    return list;
  }
}
