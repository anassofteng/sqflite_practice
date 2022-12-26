import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_practice/main.dart';

class crud {
  static const dbName = "myDatabase.db";
  static const dbversion = 1;
  static const dbtable = "myTable";
  static const columnId = "id";
  static const columnName = "name";

  static final crud instance = crud();
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbversion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    db.execute('''

CREATE TABLE $dbtable(
  $columnId INTEGER PRIMARY KEY,
  $columnName TEXT NOT NULL
)

''');
  }

  insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(dbtable, row);
  }

  Future<List<Map<String, dynamic>>> queryDatabase() async {
    Database? db = await instance.database;
    return await db!.query(dbtable);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!
        .update(dbtable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(dbtable, where: '$columnId=?', whereArgs: [id]);
  }
}
