import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(centerTitle: true,
          title: new Text("Bedroom AC"),
          actions: <Widget>[
            new Icon(Icons.linear_scale),
          ],
        ),
        body: new Center(

        ),
      ),
    );
  }
}