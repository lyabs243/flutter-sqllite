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

    await db.execute(
        '''
      CREATE TABLE article(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        item INTEGER,
        price TEXT,
        shop TEXT,
        image TEXT
      )
    ''');

  }

  Future<Item> addItem(Item item) async{
    Database myDB = await database;
    item.id = await myDB.rawInsert('INSERT INTO item(name) VALUES(?)', [item.name]);
    return item;
  }

  Future<int> deleteItem(int id,String table) async{
    Database myDB = await database;
    return myDB.delete(table,where: 'id = ?',whereArgs: [id]);
  }

  Future<int> updateItem(Item item) async{
    Database myDB = await database;
    return myDB.update('item', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<Item> upSertItem(Item item) async{
    if(item == null){
      item = await addItem(item);
    }
    else{
      await updateItem(item);
    }
    return item;
  }

  Future<List<Item>> allItems() async{
    Database myDB = await database;
    List<Map<String,dynamic>> result = await myDB.rawQuery('SELECT * FROM item');
    List<Item> items = [];
    result.forEach((m){
      Item item = new Item();
      item.id = m['id'];
      item.name = m['name'];
      items.add(item);
    });
    return items;
  }

}