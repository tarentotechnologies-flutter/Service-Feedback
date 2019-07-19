import 'dart:async';
import 'dart:io';

import 'package:flutter_app_sqlite_master/models/UserDetail.dart';
import 'package:flutter_app_sqlite_master/models/gender.dart';
import 'package:flutter_app_sqlite_master/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
        await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
        await db.execute(
            "CREATE TABLE GenderSelection(age TEXT)");
        await db.execute(
        "CREATE TABLE Services(categoryId INTEGER, categoryName TEXT, servicesId TEXT, servicesName TEXT, count INTEGER)");
    print("Table is created");
  }


//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }
  //insertion
  Future<int> savegender(Gender gender) async {
    var dbClient = await db;
    print(dbClient);
    print('GenderSelection');
    int res = await dbClient.insert('GenderSelection', gender.toMap());
    return res;
  }

  //service Insertion
  Future<int> saveService(SelectedServicesModel servicesave) async {
    var dbClient = await db;
    print(dbClient);
    print('GenderSelection');
    int res = await dbClient.insert('Services', servicesave.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
}
