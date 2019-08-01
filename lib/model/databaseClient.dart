import 'dart:io';
import 'item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseClient{

  Database _database;

  Future<Database> get database async{
    if(_database == null){
      _database = await create();
    }
    return _database;
  }

  Future create() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String database_directory = join(directory.path,'database.db');
    var bdd = await openDatabase(
        database_directory,
        version: 1,
        onCreate: _onCreate,
    );

    return bdd;
  }

  Future _onCreate(Database db,int version) async{
    await db.execute(
    '''
      CREATE TABLE item(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
      )
    ''');
  }

  Future<Item> addItem(Item item) async{
    Database myDB = await database;
    item.id = await myDB.insert('ítem', item.toMap());
    return item;
  }

}