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
                  trailing: new IconButton(
                    icon: new Icon(Icons.delete),
                    onPressed: (){
                      DatabaseClient().deleteItem(item.id, 'item').then((id){
                        getData();
                      });
                    }
                  ),
                  leading: new IconButton(
                      icon: new Icon(Icons.edit),
                      onPressed: (){
                        add(update: true, item: item).then((dyn){
                          getData();
                        });
                      }
                  ),
                );
              }
          )
        ,
    );
  }

  //add or update an item
  Future add({update: false, item: null}) async{
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext){
        return new AlertDialog(
          title: new Text((update)? 'Update item' : 'Add wish list'),
          content: new TextField(
            decoration: new InputDecoration(
              labelText: 'List:',
              hintText: (!update)? 'Ex: My favorites games' : item.name,
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
                  if(!update) {
                    Map<String, dynamic> map = {'name': newList};
                    item = new Item();
                    item.fromMap(map);
                    DatabaseClient().addItem(item).then((i) => getData());
                  }
                  else{
                    item.name = newList;
                    DatabaseClient().updateItem(item);
                  }
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