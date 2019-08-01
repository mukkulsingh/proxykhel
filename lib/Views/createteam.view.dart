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
         title: Text('TEAM SELECT',style: TextStyle(color: Colors.white,fontSize: 16.0),),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.account_balance_wallet,color: Colors.white,),onPressed: (){},),
//
            new PopupMenuButton<int>(
              icon: Icon(Icons.menu,color: Colors.white,),
              itemBuilder: (context)=>[PopupMenuItem<int>(
                value:1,
                child: new Text('My Profile'),),
                PopupMenuItem<int>(
                  value: 2,
                  child: new Text('Logout'),
                ),
              ],
              onSelected: (value)async{
                if(value == 2){
                  _showLogoutDialog('Warning','You sure you want to logout?');
                }
              } ,
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            new Container(
              height: 200,
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
            Scrollable(
              physics: ScrollPhysics(),
              semanticChildCount: 2,
              viewportBuilder: (context, index){

              },
            ),
          ],
        ),
      ),
    );
  }
}
