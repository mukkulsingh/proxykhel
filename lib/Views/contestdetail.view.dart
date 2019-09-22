import 'package:flutter/material.dart';
import 'CreateTeamTemp.view.dart';
import 'MyProfile.view.dart';
import './../Views/wallet.view.dart';
import './bottomnavbar.view.dart';
import './../Constants/slideTransitions.dart';
import './createteam.view.dart';
import './../Model/logout.model.dart';
import './../Model/contestdetail.model.dart';
import './../Views/login.view.dart';
import './../Constants/contestdata.dart';
import './../Model/getalluserteam.model.dart';
import 'package:http/http.dart' as http;
import './../Model/savedpref.model.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
class ContestDetail extends StatefulWidget {
  @override
  _ContestDetailState createState() => _ContestDetailState();
}

class _ContestDetailState extends State<ContestDetail> {
  final GoogleSignIn googleSignIn = GoogleSignIn();


  ContestData contestData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    contestData = ContestDetailModel.instance.getContestData();

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


    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("WINNINGS BREAKDOWN"),
            content: new Text("Loading..."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Got it !"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    String _buttonText = 'JOIN';

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
                  Navigator.push(context,SlideLeftRoute(widget: MyProfile()));
                }
              } ,
            )
          ],
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex:1,
              child: Container(
                height: 65.0,
                color: Color(0XFFc4301e),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(ContestDetailModel.instance.getTeam1Name(),style: TextStyle(color: Colors.white)),
                          new Text(' vs ',style: TextStyle(color: Colors.white),),
                          new Text(ContestDetailModel.instance.getTeam2Name(),style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    new Text(ContestDetailModel.instance.getContestDuration(),style: TextStyle(color: Colors.white),),
                    new Text(ContestDetailModel.instance.getMatchType(),style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
            Expanded(
              flex:2,
              child: new Container(
                height: 110,
                child: Card(
                  child: new Column(
                    children: <Widget>[
                      new LinearProgressIndicator(
                        value: (int.parse(contestData.totlaJoin) / int.parse(contestData.maxTeam)),
                        backgroundColor: Colors.grey[300],
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Colors.deepOrange,
                                      child: new Text('M',style: TextStyle(color:Colors.white,fontSize: 10),),
                                    ),
                                    new InkWell(
                                        onTap: _showDialog,
                                        child:new Row(
                                          children: <Widget>[
                                            new Text('Winning',style: TextStyle(fontSize: 12.0),),
                                            new Icon(Icons.arrow_drop_down,color: Colors.black,),
                                          ],
                                        )
                                    ),
                                   new Row(
                                     children: <Widget>[
                                       new Text('₹'),
                                       new Text(contestData.entryfee),
                                     ],
                                   )
                                  ],
                                ),
                              ),
                              new Column(
                                children: <Widget>[
                                  new Text(''),
                                  new Text('Winners',style: TextStyle(fontSize: 12.0),),
                                  new Text(contestData.winner??'0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),),
                                  new Text(''),
                                  new Text(contestData.totlaJoin+'/'+contestData.maxTeam+' Joined',style: TextStyle(fontSize: 12.0),),
                                  new Text(''),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment  .center,
                                children: <Widget>[
                                  new Text('Entry ₹ ${contestData.entryfee} '),
                                  Container(
                                    height: 30.0,
                                    width: 85,
                                    margin: EdgeInsets.all(8.0),
                                    child: new FlatButton(onPressed: (){
                                      Navigator.push(context, SlideLeftRoute(widget:CreateTeamTemp()));
                                    },
                                      color: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32.0)
                                      ),
                                      child: Text('CREATE TEAM',style: TextStyle(color: Colors.white,fontSize: 8.0),),

                                    ),
                                  ),
                                ],
                              ),

                            ],
                          )
                        ],
                      ),

                    ],

                  ),
                ),
              ),
            ),
            Expanded(
              flex:1,
              child: new Container(
                margin: EdgeInsets.only(top: 8.0),
                child: new Column(
                  children: <Widget>[
                    new Text('OR JOIN WITH SAVED TEAM',textAlign: TextAlign.start,style: TextStyle(color: Colors.deepOrange),),
                    Divider(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: new FutureBuilder(
                  future: GetAllUserTeamModel.instance.getAllUserTeam(),
                  builder: (context,snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                        return new Stack(
                          children: <Widget>[
                            new Center(child: new CircularProgressIndicator(),),
                          ],
                        );
                        break;
                      case ConnectionState.active:
                        return new Stack(
                          children: <Widget>[
                            new Center(child: new CircularProgressIndicator(),),
                          ],
                        );
                        break;
                      case ConnectionState.waiting:
                        return new Stack(
                          children: <Widget>[
                            new Center(child: new CircularProgressIndicator(),),
                          ],
                        );
                        break;
                      case ConnectionState.done:
                        if(snapshot.hasData){
                          return MediaQuery.removePadding(
                            context: context,
                            removeBottom: true,
                            removeTop: true,
                            child: new ListView.builder(
                              padding: EdgeInsets.zero,

                                itemCount: snapshot.data.data.length,
                                itemBuilder: (BuildContext context, int index){
                                bool _isJoined = false;
                                Color _buttonColor = Colors.deepOrange;

//                                  if(snapshot.data.data[index].joined == 1){
//                                    _isJoined = true;
//                                    _buttonText = "JOINED";
//                                    _buttonColor = Colors.deepOrange[200];
//                                  }
//                                  else{
//                                    _isJoined = false;
//                                    _buttonText = "JOIN";
//                                    _buttonColor = Colors.deepOrange;
//                                  }

                                  return MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: Padding(
                                      padding: EdgeInsets.zero,
                                      child: new Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            height:40,
                                            child: new Card(
                                              margin: EdgeInsets.zero,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top:12.0,left: 12.0),
                                                child: new Text('${snapshot.data.data[index].teamname}',style: TextStyle(fontSize: 18.0),),
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            height: 80.0,
                                            child: new Card(
                                              margin: EdgeInsets.zero,
                                              child:new Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex:1,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        new Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Container(padding:EdgeInsets.only(left:18.0),child: new Text('Star Player',style: TextStyle(color: Colors.grey,fontSize:16.0),)),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left:18.0),
                                                              child: new Text('${snapshot.data.data[index].starplayer}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: new Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: <Widget>[
                                                        new Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            new Text('WK',style: TextStyle(fontSize: 10),),
                                                            new Text('1',style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ],
                                                        ),
                                                        new Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            new Text('BWL',style:TextStyle(fontSize: 10),),
                                                            new Text('${snapshot.data.data[index].bowlcount}',style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ],
                                                        ),
                                                        new Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            new Text('ALLR',style:TextStyle(fontSize: 10),),
                                                            new Text('${snapshot.data.data[index].allcount}',style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ],
                                                        ),
                                                        new Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            new Text('BAT',style:TextStyle(fontSize: 10),),
                                                            new Text('${snapshot.data.data[index].batcount}',style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 30.0,
                                                          width: 60.0,
                                                          child: new FlatButton(onPressed: () async {
                                                            if(snapshot.data.data[index].joined == 1){
                                                              SnackBar snackbar = new SnackBar(content: Text("Already joined witht this team"),duration: Duration(seconds: 1),);
                                                              Scaffold.of(context).showSnackBar(snackbar);
                                                            }else{
                                                              String userId = await SavedPref.instance.getUserId();
                                                              http.Response response  = await http.post("https://www.proxykhel.com/android/contest.php",body:{
                                                                "type":"joinUserTeam",
                                                              "matchId":ContestDetailModel.instance.getMatchId(),
                                                                "contestId":ContestDetailModel.instance.getContestId(),
                                                                "userId":userId,
                                                                "squadId":snapshot.data.data[index].id,
                                                                "contestAmt":contestData.entryfee,
                                                                "team_1_name":ContestDetailModel.instance.getTeam1Name(),
                                                                "team_2_name":ContestDetailModel.instance.getTeam2Name(),
                                                                "matchType":ContestDetailModel.instance.getMatchType(),
                                                                "matchtime":ContestDetailModel.instance.getContestDuration(),
                                                              });
                                                              if(response.statusCode == 200){

                                                                final res = json.decode(response.body);
                                                                if(res['data'] == 1){
                                                                  SnackBar snackbar = new SnackBar(content: Text("Contest joined"),duration: Duration(seconds: 1),);
                                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                                  setState(() {

                                                                  });
                                                                }
                                                                else if(res['data'] == 'not enough money'){
                                                                  SnackBar snackbar = new SnackBar(content: Text("Insufficient wallet amount"),duration: Duration(seconds: 1),);
                                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                                }
                                                                else if(res['data'] == 'swap'){
                                                                  SnackBar snackbar = new SnackBar(content: Text("Team swapped"),duration: Duration(seconds: 1),);
                                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                                }else{
                                                                  SnackBar snackbar = new SnackBar(content: Text("Error joining team"),duration: Duration(seconds: 1),);
                                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                                }
                                                                Future.delayed(Duration(seconds: 1),(){

                                                                });
                                                              }
                                                              else{
                                                                SnackBar snackbar = new SnackBar(content: Text("Error joining team"));
                                                                Scaffold.of(context).showSnackBar(snackbar);
                                                              }
                                                            }
                                                          }, child: new Text("JOIN",style: TextStyle(color:Colors.white,fontSize: 8.0),),
                                                            color: Colors.deepOrange,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(32.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            height: 60.0,
                                            child: new Card(
                                              margin: EdgeInsets.zero,
                                              child: new Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        new Text('X Player',style: TextStyle(color: Colors.grey,fontSize:16.0),),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:18.0),
                                                          child: new Text('${snapshot.data.data[index].xplayer}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

//                                            Container(
//                                              child: Row(
//                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                children: <Widget>[
//                                                  new Column(
//                                                    mainAxisAlignment: MainAxisAlignment.center,
//                                                    children: <Widget>[
//                                                      new Icon(Icons.edit),
//                                                      SizedBox(
//                                                        height: 3.0,
//                                                      ),
//                                                      new Text('EDIT',style: TextStyle(fontSize: 12.0),)
//                                                    ],
//                                                  ),
//                                                  SizedBox(
//                                                    width: 10.0,
//                                                  ),
//                                                  new Column(
//                                                    mainAxisAlignment: MainAxisAlignment.center,
//                                                    children: <Widget>[
//                                                      new Icon(Icons.remove_red_eye),
//                                                      SizedBox(
//                                                        height: 3.0,
//                                                      ),
//                                                      new Text('VIEW',style: TextStyle(fontSize: 12.0),)
//                                                    ],
//                                                  ),
//                                                  SizedBox(
//                                                    width: 10.0,
//                                                  ),
//                                                  new Column(
//                                                    mainAxisAlignment: MainAxisAlignment.center,
//                                                    children: <Widget>[
//                                                      new Icon(Icons.content_copy),
//                                                      SizedBox(
//                                                        height: 3.0,
//                                                      ),
//                                                      new Text('COPY',style: TextStyle(fontSize: 12.0),)
//                                                    ],
//                                                  ),
//                                                  SizedBox(
//                                                    width: 10.0,
//                                                  ),
//                                                ],
//                                              ),
//                                            ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                  );

                                }
                            ),
                          );
                        }
                        else if(snapshot.hasError){
                          return new Stack(
                            children: <Widget>[
                              new Center(child: new Text("Create new team"),),
                            ],
                          );
                        }
                        else{
                          return new Stack(
                            children: <Widget>[
                              new Center(child: new CircularProgressIndicator(),),
                            ],
                          );
                        }
                        break;

                    }
                    return new Container();
                  }


                  ),
            ),

          ],

        ),
        bottomNavigationBar: BottomNavBar(),
      );
  }
}
