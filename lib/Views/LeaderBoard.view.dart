import 'package:flutter/material.dart';
import 'package:proxykhel/Model/LeaderBoard.model.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LeaderBoard"),),
      body: new Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: LeaderBoardModel.instance.getLeaderBoard(),
              builder: (context,snapshot){
                return new Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
