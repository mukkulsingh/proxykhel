import 'package:flutter/material.dart';

class CreateTeamTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("CREATE TEAM"),),
      body: CreateTeamtemp(),
    );
  }
}
class CreateTeamtemp extends StatefulWidget {
  @override
  _CreateTeamtempState createState() => _CreateTeamtempState();
}

class _CreateTeamtempState extends State<CreateTeamtemp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex:1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Container(),

                  ],
                ),
              ),

            ],
          ),
        )  ,
        Expanded(
          flex: 7,
          child: GridView.count(crossAxisCount: 3),
        ),
        Expanded(
          flex:1,
          child: new Row(
            children: <Widget>[

            ],
          ),
        )
      ],
    );
  }
}

