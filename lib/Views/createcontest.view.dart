import 'package:flutter/material.dart';
import './../Constants/theme.dart' as Theme;
import './bottomnavbar.view.dart';
import './../Model/logout.model.dart';
import './../Constants/slideTransitions.dart';
import './login.view.dart';
import './tabBarMega.view.dart';
import './tabBarHtoH.view.dart';
import './tabBarPartial.view.dart';

class CreateContest extends StatelessWidget {

  String matchId;
  CreateContest({@required this.matchId});

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

    void _showDialogWinningBreakdown() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("WINNINGS BREAKDOWN"),
            content: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text('Rank 1'),
                    new Text('Rs. 50'),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text('Rank 2'),
                    new Text('Rs. 30'),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text('Rank 3'),
                    new Text('Rs. 25'),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text('Rank 4'),
                    new Text('Rs. 20'),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text('Rank 5'),
                    new Text('Rs. 15'),
                  ],
                ),

              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Got it !",textAlign: TextAlign.center,),
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
      debugShowCheckedModeBanner: false,
      theme: Theme.ProxykhelThemeData,
      home: DefaultTabController(length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: Text('CONTEST CREATE',style: TextStyle(fontSize: 16.0,color: Colors.white),),
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
            bottom: TabBar(
              labelColor:Colors.white,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
              ),
              tabs: [
                Tab(
                  text: 'MEGA',
                ),
                Tab(text: 'PARTIAL'),
                Tab(text: 'H TO H'),
              ],
            ),
          ),
          body: TabBarView(children: [
//            new Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                Container(
//                  margin:EdgeInsets.all(10.0),
//                  child: new Text('upto 70% Winner',),
//                ),
//                new Container(
//                  height: 110,
//                  margin: EdgeInsets.all(8.0),
//                  child: new Card(
//                    child: new Column(
//                      children: <Widget>[
//                        LinearProgressIndicator(
//                          value: 0.5,
//                          backgroundColor: Colors.grey[300],
//                        ),
//                        new Column(
//                          crossAxisAlignment: CrossAxisAlignment.stretch,
//                          children: <Widget>[
//                            new Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceAround,
//                              children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: new Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      new CircleAvatar(
//                                        radius: 10.0,
//                                        backgroundColor: Colors.deepOrange,
//                                        child: new Text('M',style: TextStyle(color:Colors.white,fontSize: 10),),
//                                      ),
//                                      new InkWell(
//                                          onTap: _showDialogWinningBreakdown,
//                                          child:new Row(
//                                            children: <Widget>[
//                                              new Text('Winning'),
//                                              new Icon(Icons.arrow_drop_down),
//                                            ],
//                                          )
//                                      ),
//                                      new Text('Rs. 0'),
//                                    ],
//                                  ),
//                                ),
//                                new Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    new Text('Winners'),
//                                    new Text('3',style: TextStyle(fontWeight: FontWeight.bold),),
//                                  ],
//                                ),
//                                Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Padding(
//                                      padding: const EdgeInsets.only(left:12.0),
//                                      child: new Text('5/100 Joined',style: TextStyle(fontSize: 12.0),),
//                                    ),
//                                  ],
//                                ),
//                                new Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    new Text('Entry'),
//                                    Padding(
//                                      padding: EdgeInsets.all(8.0),
//                                      child: new FlatButton(onPressed: (){
////                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ContestDetails()));
//                                      },
//                                        color: Colors.deepOrange,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.circular(32.0)
//                                        ),
//                                        child: Text('free',style: TextStyle(color: Colors.white),),
//
//                                      ),
//                                    ),
//                                  ],
//                                ),
//
//                              ],
//                            )
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                )
//              ],
//            ),
            new TabBarMega(matchId:matchId),
            new TabBarPartial(matchId:matchId),
            new TabBarHtoH(matchId: matchId)
          ]),
          bottomNavigationBar:BottomNavBar(),
        ),
      ),
    );
  }
}
