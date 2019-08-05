import 'package:flutter/material.dart';
import 'wallet.view.dart';
import './bottomnavbar.view.dart';
import './../Model/logout.model.dart';
import './../Constants/slideTransitions.dart';
import './login.view.dart';
import './tabBarMega.view.dart';
import './tabBarHtoH.view.dart';
import './tabBarPartial.view.dart';
import 'profile.view.dart';

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
    return  DefaultTabController(length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            title: Text('CONTEST CREATE',style: TextStyle(fontSize: 16.0,color: Colors.white),),
            actions: <Widget>[
              new IconButton(icon: Icon(Icons.account_balance_wallet,color: Colors.white,),onPressed: (){
                Navigator.push(context,SlideLeftRoute(widget: Wallet()));
              },),
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
                    else if(value == 1){
                      Navigator.push(context,SlideLeftRoute(widget: Profile()));
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
            new TabBarMega(matchId:matchId),
            new TabBarPartial(matchId:matchId),
            new TabBarHtoH(matchId: matchId)
          ]),
          bottomNavigationBar:BottomNavBar(),
        ),
      );
  }
}
