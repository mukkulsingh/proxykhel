//import 'package:flutter/material.dart';
//import 'package:proxykhel/Constants/slideTransitions.dart';
//import 'package:proxykhel/Model/logout.model.dart';
//import 'package:proxykhel/Views/profile.view.dart';
//import 'package:proxykhel/Views/wallet.view.dart';
//
//import 'login.view.dart';
//
//class JoinedContestDetail extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    void _showLogoutDialog(String title, String content) {
//      showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          // return object of type Dialog
//          return AlertDialog(
//            title: new Text(title),
//            content: new Text(content),
//            actions: <Widget>[
//              // usually buttons at the bottom of the dialog
//              new FlatButton(
//                child: new Text("Yes"),
//                onPressed: () async {
//                  await LogoutModel.instance.logoutRequest();
//                  Navigator.of(context).pushAndRemoveUntil(SlideRightRoute(widget: LoginScreen()), (Route<dynamic> route)=>false);
//                },
//              ),
//              new FlatButton(
//                child: new Text("no"),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          );
//        },
//      );
//    }
//
//    return Scaffold(
//        appBar:new AppBar(
//          iconTheme: IconThemeData(
//            color: Colors.white,
//          ),
//          title: Text('CONTEST DETAILS',style: TextStyle(fontSize: 16.0,color: Colors.white),),
//          actions: <Widget>[
//            new IconButton(
//              icon: Icon(
//                Icons.account_balance_wallet,
//                color: Colors.white,
//              ),
//              onPressed: () {
//                Navigator.push(context,SlideLeftRoute(widget: Wallet()));
//              },
//            ),
//            new PopupMenuButton<int>(
//              icon: Icon(Icons.menu,color: Colors.white,),
//              itemBuilder: (context)=>[PopupMenuItem<int>(
//                value:1,
//                child: new Text('My Profile'),),
//                PopupMenuItem<int>(
//                  value: 2,
//                  child: new Text('Logout'),
//                ),
//              ],
//              onSelected: (value)async{
//                if(value == 2){
//                  _showLogoutDialog('Warning','You sure you want to logout?');
//                }
//                else if(value == 1){
//                  Navigator.push(context,SlideLeftRoute(widget: Profile()));
//                }
//              } ,
//            )
//          ],
//        )
//    );
//  }
//}
//
//class JoinedContestDetailView extends StatefulWidget {
//  @override
//  _JoinedContestDetailViewState createState() => _JoinedContestDetailViewState();
//}
//
//class _JoinedContestDetailViewState extends State<JoinedContestDetailView> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Column(
//        children: <Widget>[
//          new Container(
//            height: 80.0,
//            child: new Row(
//              children: <Widget>[
//                new Text("Team Name"),
//                new Text("Expired"),
//                new Text("Team Name")
//              ],
//            ),
//          ),
//          FutureBuilder(
//            future: ,
//            builder: (context,snapshot) {
//              return new ListView.builder(
//                  itemCount: 2,
//                  itemBuilder: (context, index) {
//                    return new Card();
//                  });
//            })
//        ],
//      ),
//    );
//  }
//}
//
