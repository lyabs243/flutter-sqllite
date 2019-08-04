import 'package:flutter/material.dart';
import 'dart:io';

class AddArticle extends StatefulWidget{
  
  int id;
  
  AddArticle(int id){
    this.id = id;
  }
  
  @override
  _AddArticleState createState() {
    // TODO: implement createState
    return new _AddArticleState();
  }
  
}

class _AddArticleState extends State<AddArticle>{

  String image;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Article'),
        actions: <Widget>[
          new FlatButton(
            onPressed: (){

            },
            child: new Text('Validate')
          ),
        ],
      ),
      body: new SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          children: <Widget>[
            new Text('Article to add',textScaleFactor: 1.4,),
            new Card(
              elevation: 20.0,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (image == null)
                  ? new Image.asset('assets/no_image.png')
                  : new Image.file(new File(image)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.camera_enhance),
                        onPressed: (){
                          
                        }
                      ),
                      new IconButton(
                          icon: new Icon(Icons.photo_library),
                          onPressed: (){

                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}