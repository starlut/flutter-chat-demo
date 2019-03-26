import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:flutter_chat_demo/dataModels/dbModel/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static final table_user = "User";

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
    "CREATE TABLE $table_user(id INTEGER PRIMARY KEY, user_name TEXT, user_id TEXT, user_pic TEXT, user_position TEXT, user_full_name TEXT )");
    print("Created tables");
  }

  Future<int> saveUser(User user) async {
    print(user.toJson());
    var dbClient = await db;
    int res = await dbClient.insert(table_user, user.toJson());
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete(table_user);
    return res;
  }

  Future<User> getUser() async {
    List<Map> maps = await _db.query(table_user,
        columns: ['id', 'user_name', 'user_id', 'user_pic', 'user_position', 'user_full_name']);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query(table_user);
    return res.length > 0? true: false;
  }

}