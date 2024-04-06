import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timeline/dual_game_classic/database/card_list.dart';
import 'package:timeline/dual_game_classic/model/game_card.dart';

import 'database_state.dart';

class DatabaseBloc extends Cubit<DatabaseState> {
  DatabaseBloc() : super(InitDatabaseState());
  Database? database;

  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'dual_game.db');
    try {
      await Directory(dirname(path)).create(recursive: true);
      database =
          await openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE game_card(id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'name TEXT, '
          'year INTEGER, '
          'date TEXT,'
          'image TEXT,'
          'description TEXT,'
          'source TEXT,'
          'author TEXT,'
          'category_id INTEGER,'
          'geography_id INTEGER,'
          'level_id INTEGER,'
          'century_id INTEGER,'
          'FOREIGN KEY (category_id) REFERENCES category(id)'
          'FOREIGN KEY (geography_id) REFERENCES geography(id)'
          'FOREIGN KEY (level_id) REFERENCES level(id)'
          'FOREIGN KEY (century_id) REFERENCES century(id)'
          ')',
        );
        await db.execute(
          'CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'category TEXT '
          ')',
        );
        await db.execute(
          'CREATE TABLE geography(id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'geography TEXT '
          ')',
        );
        await db.execute(
          'CREATE TABLE level(id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'level TEXT '
          ')',
        );
        await db.execute(
          'CREATE TABLE century(id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'century TEXT '
          ')',
        );
      });

      addAllCardFromLocal();
      emit(LoadDatabaseState());
    } catch (e) {
      log("error $e");
    }
  }

  Future<int?> insert<T extends GameCard>(T model) async =>
      await database?.insert(
        "game_card", // Получаем имя рабочей таблицы
        model.toMap(), // Переводим наш объект в мапу для вставки
        conflictAlgorithm: null, // Что должно происходить при конфликте вставки
        nullColumnHack:
            null, // Что делать, если not null столбец приходит как null
      );

  addAllCardFromLocal() async {
    await database?.transaction((txn) async {
      await txn.rawInsert("DELETE FROM game_card");
      for (var card in cardListOnHand) {
        log("insert date ${card.date.toString()}");
        insert(card);
      }
    });
  }
}
