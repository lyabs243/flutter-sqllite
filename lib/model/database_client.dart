import 'dart:io';
import 'item.dart';
import 'article.dart';
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
        version: 2,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
    );

    return bdd;
  }


  Future _onUpgrade(Database db,int oldVersion,newVersion) async{

    if(oldVersion < 2) {
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
    myDB.delete('article',where: 'item = ?',whereArgs: [id]);
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

  Future<Article> addArticle(Article article) async{
    Database myDB = await database;
    article.id = await myDB.rawInsert('INSERT INTO article(name,item,price,shop,image) VALUES(?,?,?,?,?)',
        [article.name,article.item,article.price,article.shop,article.image]);
    return article;
  }

  Future<int> updateArticle(Article article) async{
    Database myDB = await database;
    return myDB.update('article', article.toMap(), where: 'id = ?', whereArgs: [article.id]);
  }

  Future<Article> upSertArticle(Article article) async{
    if(article.id == null){
      article = await addArticle(article);
    }
    else{
      await updateArticle(article);
    }
    return article;
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

  Future<List<Article>> allArticles(int item) async{
    Database myDB = await database;
    List<Map<String,dynamic>> result = await myDB.query('article',where: 'item = ?', whereArgs: [item]);
    List<Article> articles = [];
    result.forEach((m){
      Article article = new Article();
      article.id = m['id'];
      article.name = m['name'];
      article.item = m['item'];
      article.price = m['price'];
      article.shop = m['shop'];
      article.image = m['image'];
      articles.add(article);
    });
    return articles;
  }

}