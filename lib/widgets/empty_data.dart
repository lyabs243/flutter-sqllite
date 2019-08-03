import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text(
        'No Data found',
        textScaleFactor: 2.0,
        style: new TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

}