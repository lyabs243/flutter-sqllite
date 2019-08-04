import 'package:flutter/material.dart';
import 'package:flutter_sql_lite/model/item.dart';
import 'package:flutter_sql_lite/model/article.dart';
import 'empty_data.dart';
import 'add_article.dart';
import 'package:flutter_sql_lite/model/database_client.dart';
import 'dart:io';

class ItemDetail extends StatefulWidget{

  Item item;

  ItemDetail(Item item){
    this.item = item;
  }

  @override
  _ItemDetail createState() {
    // TODO: implement createState
    return new _ItemDetail();
  }

}

class _ItemDetail extends State<ItemDetail>{

  List<Article> articles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text(this.widget.item.name),
        actions: <Widget>[
          new FlatButton(
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext){
                return new AddArticle(this.widget.item.id);
              })).then((value){
                loadArticles();
              });
            },
            child: new Text('ADD'),
          ),
        ],
      ),
      body: (articles == null || articles.length == 0)
        ? new EmptyData()
        : new GridView.builder(
          itemCount: articles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          itemBuilder: (context, i){
            Article article = articles[i];
            return new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(article.name),
                  new Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 1.5,
                    child: (article.image == null)
                        ? new Image.asset('assets/no_image.png',fit: BoxFit.cover,)
                        : new Image.file(new File(article.image),fit: BoxFit.cover,),
                  ),
                  (article.price == null)
                      ? new Text('No price')
                      : new Text('Price: ${article.price}'),
                  (article.shop == null)
                      ? new Text('No Shop')
                      : new Text('Shop: ${article.shop}'),
                ],
              ),
            );
          }
        )
    );
  }

  void loadArticles(){
    DatabaseClient().allArticles(widget.item.id).then((list){
      setState(() {
        articles = list;
      });
    });
  }

}