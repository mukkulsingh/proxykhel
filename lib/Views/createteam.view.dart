import 'package:flutter/material.dart';
import './../Constants/theme.dart' as Theme;
import './../Model/logout.model.dart';
import './../Constants/slideTransitions.dart';
import './../Views/login.view.dart';

class CreateTeam extends StatefulWidget {
  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  Card getStructuredGridCell(String a) {
    return new Card(
      elevation: 2.0,
      color: Colors.white,
      child: new InkWell(
        highlightColor: Colors.white.withAlpha(30),
        splashColor: Colors.white.withAlpha(20),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              new Center(
                child: new Text(a),
              )
            ]),
        onTap: () {
//          _tappedCategoryCell(item.routeName);
        },
      ),
    );
  }

  List<Widget> _loadCategories() {
    List<Widget> categoryCells = [];
    List<dynamic> categories = ["abhishek","vivek","abhishek","vivie","vivek","abhishek","vivie",
      "vivek","abhishek","vivie","vivek","abhishek","vivie","vivek","abhishek","vivie",
    ];
    for (int i= 0; i<categories.length;i++) {
      categoryCells.add(getStructuredGridCell(categories[i]));
    }

    return categoryCells;
  }



  @override
  Widget build(BuildContext context) {
    void _showLogoutDialog(String title, String content) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () async {
                  await LogoutModel.instance.logoutRequest();
                  Navigator.of(context).pushAndRemoveUntil(SlideRightRoute(widget: LoginScreen()), (Route<dynamic> route)=>false);
                },
              ),
              new FlatButton(
                child: new Text("no"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    
    return MaterialApp(
      theme: Theme.ProxykhelThemeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text('CREATE TEAM'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex:1,
              child: new Container(
                height: 230,
                color: Colors.red[900],
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top:12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new CircleAvatar(
                                child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons/Batsman.png")),
                                backgroundColor: Colors.white,
                                radius: 24.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 4.0),
                                  child: new Text('BatsMan',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              new CircleAvatar(
                                child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons/Bowler.png")),
                                backgroundColor: Colors.white,
                                radius: 24.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 4.0),
                                  child: new Text('Bowler',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              new CircleAvatar(
                                child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons/Wicket-Keeper.png")),
                                backgroundColor: Colors.white,
                                radius: 24.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 4.0),
                                  child: new Text('Wicket Keeper',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              new CircleAvatar(
                                child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons/All-Rounder.png")),
                                backgroundColor: Colors.white,
                                radius: 24.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 4.0),
                                  child: new Text('All Rounder',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top:12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  new CircleAvatar(
                                    child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons/Man-of-the-Match.png")),
                                    backgroundColor: Colors.white,
                                    radius: 24.0,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 4.0),
                                      child: new Text('Star Player',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  new CircleAvatar(
                                    child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons/Super-Striker.png")),
                                    backgroundColor: Colors.white,
                                    radius: 24.0,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 4.0),
                                      child: new Text('X Player',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  new CircleAvatar(
                                    child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons/fwp.png")),
                                    backgroundColor: Colors.white,
                                    radius: 24.0,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 4.0),
                                      child: new Text('Super Five',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  new CircleAvatar(
                                    child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons/Choosen-Players.png")),
                                    backgroundColor: Colors.white,
                                    radius: 24.0,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 4.0),
                                      child: new Text('Choosen Player',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2,
                children:_loadCategories(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              new OutlineButton(
                onPressed: (){},
                child: Text("Save Team"),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(32.0),

                ),
                borderSide: BorderSide(
                  color: Colors.green,
                  style: BorderStyle.solid,
                  width: 0.8,
                ),
                color: Colors.green,
              ),

              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child:new Text('100 Creadit left'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
