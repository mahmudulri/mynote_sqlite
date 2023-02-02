import 'dart:io';
import 'package:mynote_sflite/custom_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._PrivateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._PrivateConstructor();
  static Database? _dataBase;

  Future<Database> get database async => _dataBase ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'todo.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
         CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, 
         title TEXT, 
         description TEXT)
         ''');
  }

  Future<int> createTodo(Todo todo) async {
    Database db = await instance.database;
    return await db.insert(
      'todos',
      todo.toJson(),
    );
  }
}
