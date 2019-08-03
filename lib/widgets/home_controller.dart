import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_sql_lite/model/item.dart';
import 'package:flutter_sql_lite/widgets/empty_data.dart';
import 'package:flutter_sql_lite/model/databaseClient.dart';

class HomeController extends StatefulWidget {
  HomeController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {

  String newList;
  List<Item> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new FlatButton(
            onPressed: (){
              add();
            },
            child: new Text(
              'ADD',
            ),
          ),
        ],
      ),
      body: (items == null || items.length == 0)
        ?
          new EmptyData()
        :
          new ListView.builder(
              itemCount: items.length,
              itemBuilder: (buildContext,i){
                Item item = items[i];
                return new ListTile(
                  title: new Text(item.name),
                );
              }
          )
        ,
    );
  }

  Future add() async{
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext){
        return new AlertDialog(
          title: new Text('Add wish list'),
          content: new TextField(
            decoration: new InputDecoration(
              labelText: 'List:',
              hintText: 'Ex: My favorites games',
            ),
            onChanged: (String str){
              newList = str;
            },
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: (){
                Navigator.pop(buildContext);
              },
              child: new Text(
                  'Cancel'
              ),
            ),
            new FlatButton(
              onPressed: (){
                if(newList != null) {
                  Map<String, dynamic> map = {'name': newList};
                  Item item = new Item();
                  item.fromMap(map);
                  DatabaseClient().addItem(item).then((i) => getData());
                  newList = null;
                }
                Navigator.pop(buildContext);
              },
              child: new Text(
                  'Save'
              ),
            ),
          ],
        );
      },
    );
  }

  getData(){
    DatabaseClient().allItems().then((items){
      setState(() {
        this.items = items;
      });
    });
  }
}