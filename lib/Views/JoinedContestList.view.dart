import 'package:flutter/material.dart';
import './../Constants/slideTransitions.dart';
import './wallet.view.dart';
import './../Model/logout.model.dart';
import './login.view.dart';
import './profile.view.dart';
import './../Model/JoinedContestListModel.model.dart';

class JoinedContestList extends StatefulWidget {
  @override
  _JoinedContestListState createState() => _JoinedContestListState();
}

class _JoinedContestListState extends State<JoinedContestList> {

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


    return Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text('CONTEST DETAILS',style: TextStyle(fontSize: 16.0,color: Colors.white),),
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
        body: Column(
          children: <Widget>[
            new Expanded(
                flex:1,
                child: Container(
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
                )
            ),
            new Expanded(
              flex:1,
              child: new Card(
                  child:ListTile(
                    title: Text("Player",style: TextStyle(color: Colors.deepOrange),),
                    trailing: new Icon(Icons.chevron_right,color: Colors.deepOrange,),
                    onTap: (){
                    },
                  )
                ),

            ),
            new Expanded(flex:7,child: ListView(
              children: <Widget>[
                new FutureBuilder(
                    future:JoinedContestListModel.instance.getJoinedContest(),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return new Center(child: new CircularProgressIndicator(),);
                          break;
                        case ConnectionState.done:
                          return new ListView.builder(
                              itemBuilder: (context,index){

                              });
                      }

                }),
              ],
            ))
          ],
        ),
    );
  }
}
