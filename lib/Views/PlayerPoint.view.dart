import 'package:flutter/material.dart';
import 'package:proxykhel/Model/LeaderBoard.model.dart';
import 'package:proxykhel/Model/PlayerPointModel.model.dart';
import './../Constants/slideTransitions.dart';
import './wallet.view.dart';
import './../Model/logout.model.dart';
import './login.view.dart';
import './profile.view.dart';
import './../Model/JoinedContestListModel.model.dart';

class PlayerPoint extends StatefulWidget {
  @override
  _PlayerPointState createState() => _PlayerPointState();
}

class _PlayerPointState extends State<PlayerPoint> {
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Player Point',style: TextStyle(fontSize: 16.0,color: Colors.white),),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,SlideLeftRoute(widget: Wallet()));
            },
          ),
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
              else if(value == 1){
                Navigator.push(context,SlideLeftRoute(widget: Profile()));
              }
            } ,
          )
        ],
      ),
      body: FutureBuilder(
        future: PlayerPointModel.instance.getPlayerPoint(),
        builder: (context,snapshot){
          return new ListView(
            children: <Widget>[
              Container(
                  height: 65.0,
                  color: Color(0XFFc4301e),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text('${JoinedContestListModel.instance.getTeam1}  VS  ${JoinedContestListModel.instance.getTeam2}',style: TextStyle(color: Colors.white),),
                      new Text('EXPIRED',style: TextStyle(color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: new Text('${JoinedContestListModel.instance.getMatchType??''}',style: TextStyle(color: Colors.white),)),
                      )
                    ],
                  )
              ),

              new Container(
                height: 80.0,
                child: new Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Image(image: NetworkImage("https://www.proxykhel.com/assets/image/hp.png",),height: 50.0,width: 50.0,),
                        new SizedBox(width: 12.0,),
                        new Text("${PlayerPointModel.instance.getName}"),
                      ],
                    ),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Text("Total Points"),
                        new SizedBox(height: 4.0,),
                        new Text("${PlayerPointModel.instance.getPlayerpoint}",style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    )
                  ],
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  color: Colors.grey[100],
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Event"),
                      new Text("Points   ")
                    ],
                  ),
                ),
              ),

              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Run"),
                      new Text("${PlayerPointModel.instance.getPerRun}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Four"),
                      new Text("${PlayerPointModel.instance.getPerFour}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Six"),
                      new Text("${PlayerPointModel.instance.getPerSix}       ")
                    ],
                  ),
                ),
              ),

              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Wicket"),
                      new Text("${PlayerPointModel.instance.getPerWicket}       ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Dot Ball"),
                      new Text("${PlayerPointModel.instance.getPerDotBall}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Maiden Over"),
                      new Text("${PlayerPointModel.instance.getMaidenOver}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Economy Rate"),
                      new Text("0      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Catch"),
                      new Text("${PlayerPointModel.instance.getCatch}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Runout"),
                      new Text("${PlayerPointModel.instance.getRunOut}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Stump"),
                      new Text("${PlayerPointModel.instance.getRunOutStump}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   lbw"),
                      new Text("${PlayerPointModel.instance.getLbw}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   Bowled"),
                      new Text("${PlayerPointModel.instance.getBowled}      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   50's"),
                      new Text("0      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   75's"),
                      new Text("0      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   100's"),
                      new Text("0      ")
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50.0,
                child: Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("   120's"),
                      new Text("0      ")
                    ],
                  ),
                ),
              ),


              
            ],
          );
        },
      ),
    );
  }
}
