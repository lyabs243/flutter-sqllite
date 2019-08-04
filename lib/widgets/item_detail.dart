import 'package:flutter/material.dart';
import 'package:flutter_sql_lite/model/item.dart';

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text(this.widget.item.name),
      ),
    );
  }

}