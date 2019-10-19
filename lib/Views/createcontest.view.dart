import 'package:flutter/material.dart';
import 'package:proxykhel/Views/ReferAndEarn.view.dart';
import 'MyProfile.view.dart';
import 'wallet.view.dart';
import './bottomnavbar.view.dart';
import './../Model/logout.model.dart';
import './../Constants/slideTransitions.dart';
import './login.view.dart';
import './tabBarMega.view.dart';
import './tabBarHtoH.view.dart';
import './tabBarPartial.view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CreateContest extends StatelessWidget {

  String matchId;
  CreateContest({@required this.matchId});

  final GoogleSignIn googleSignIn = GoogleSignIn();

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
                  await googleSignIn.signOut();
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
    return  DefaultTabController(
      length: 3,
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
                      value: 3,
                      child: new Text('Refer And Earn'),
                    ),
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
                      Navigator.push(context,SlideLeftRoute(widget: MyProfile()));
                    }
                    else if(value == 3){
                      Navigator.push(context,SlideLeftRoute(widget: ReferAndEarn()));
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
