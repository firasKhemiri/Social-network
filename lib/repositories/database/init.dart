import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  //private constructor
  AppDatabase._();

  //create single instance of AppDatabase via the private constructor
  static final AppDatabase _singleton = AppDatabase._();

  //getter for class instance
  static AppDatabase get instance => _singleton;

  //database instance
  Database? _database;

  Future<Database> get database async {
    //open db if db is null
    _database == null ? _database = await _openDatabase() : log('Opening DB');

    //return already opened db
    return _database!;
  }

  Future<Database> _openDatabase() async {
    //get application directory
    final directory = await getApplicationDocumentsDirectory();

    //construct path
    final dbPath = join(directory.path, 'bitcloth.db');

    //open database
    final db = await databaseFactoryIo.openDatabase(dbPath);
    return db;
  }
}
