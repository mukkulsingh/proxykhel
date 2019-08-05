import 'package:flutter/material.dart';
import 'profile.view.dart';
import './../Views/wallet.view.dart';
import './bottomnavbar.view.dart';
import './../Constants/slideTransitions.dart';
import './createteam.view.dart';
import './../Views/tabBarMega.view.dart';
import './../Model/logout.model.dart';
import './../Model/contestdetail.model.dart';
import './../Views/login.view.dart';

class ContestDetail extends StatefulWidget {


  @override
  _ContestDetailState createState() => _ContestDetailState();
}

class _ContestDetailState extends State<ContestDetail> {
  ContestData contestData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 65.0,
              color: Color(0XFFc4301e),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text('IND vs NZ',style: TextStyle(color: Colors.white),),
                  new Text(ContestDetailModel.instance.getContestDuration(),style: TextStyle(color: Colors.white),),
                  new Text('(ODI)',style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
            new Container(
              height: 110,
              child: Card(
                child: new Column(
                  children: <Widget>[
                    new LinearProgressIndicator(
                      value: 0.3,
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
                                          new Icon(Icons.arrow_drop_down),
                                        ],
                                      )
                                  ),
                                  new Text('Rs. 0'),
                                ],
                              ),
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text('Winners',style: TextStyle(fontSize: 12.0),),
                                new Text('3',style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: new Text('5/100 Joined',style: TextStyle(fontSize: 12.0),),
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment  .center,
                              children: <Widget>[
                                new Text('Entry'),
                                Container(
                                  height: 30.0,
                                  width: 85,
                                  margin: EdgeInsets.all(8.0),
                                  child: new FlatButton(onPressed: (){
                                    Navigator.push(context, SlideLeftRoute(widget:CreateTeam()));
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
            new Container(
              margin: EdgeInsets.all(12.0),
              child: new Text('OR JOIN THE SAVE TEAM'),
            ),
            new Container(
              height: 60,
              child: new Card(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: new Text('abhishek798#1',style: TextStyle(color: Colors.grey,fontSize: 16.0),),
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              height: 80.0,
              child: new Card(
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
                                child: new Text('Rishab Pant',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
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
                              new Text('2',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text('ALLR',style:TextStyle(fontSize: 10),),
                              new Text('3',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text('BAT',style:TextStyle(fontSize: 10),),
                              new Text('3',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Container(
                            height: 30.0,
                            width: 60.0,
                            child: new FlatButton(onPressed: (){}, child: new Text('JOINED',style: TextStyle(color:Colors.white,fontSize: 8.0),),
                              color: Colors.deepOrange[200],
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
                            child: new Text('Mitchell Santner',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(Icons.edit),
                              SizedBox(
                                height: 3.0,
                              ),
                              new Text('EDIT',style: TextStyle(fontSize: 12.0),)
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(Icons.remove_red_eye),
                              SizedBox(
                                height: 3.0,
                              ),
                              new Text('VIEW',style: TextStyle(fontSize: 12.0),)
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(Icons.content_copy),
                              SizedBox(
                                height: 3.0,
                              ),
                              new Text('COPY',style: TextStyle(fontSize: 12.0),)
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],

        ),
        bottomNavigationBar: BottomNavBar(),
      );
  }
}
