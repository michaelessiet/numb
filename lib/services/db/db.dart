import 'package:flutter/material.dart';
import 'package:numb/services/idgen.dart';
import 'package:sqflite/sqflite.dart';

DB db = DB();

class DB {
  late Database database;

  Future<void> init() async {
    var databasePath = await getDatabasesPath();
    String path = '$databasePath/numb.db';

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Calculations (id INTEGER PRIMARY KEY, calculation TEXT, result TEXT, key TEXT)');
    });
    print(database);
  }

  Future<void> add(String expression, String result) async {
    String key = getRandomString(30);
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Calculations(calculation, result, key) VALUES("$expression", "$result", "$key")');
    });
  }

  Future<void> modify(int id, String expression, String result) async {
    await database.rawUpdate(
        'UPDATE Calculations SET calculation = ?, result = ? WHERE id = ?',
        [expression, result, id]);
  }

  Future<Map> getIdData(int id) async {
    Map data = (await database.query('Calculations', where: 'id=$id'))[0];
    return data;
  }

  Future<List<Map<String, dynamic>>> getData() async {
    List<Map<String, dynamic>> dbData = await database.query('Calculations');
    if (dbData.isEmpty) {
      await add('', '--');
    }
    return dbData;
  }

  Future<void> delete(int id) async {
    await database.rawDelete('DELETE FROM Calculations WHERE id = ?', [id]);
  }

  Future<void> deleteAll() async {
    await database.rawDelete('DELETE FROM Calculations');
  }
}
