import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQL Lite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Flutter SQL Lite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String newList;

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
      body: Center(
      ),
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
}
