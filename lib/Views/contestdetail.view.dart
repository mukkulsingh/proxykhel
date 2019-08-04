import 'package:flutter/material.dart';
import './../main.dart';
import './../Constants/theme.dart' as Theme;
import './bottomnavbar.view.dart';
import './../Constants/slideTransitions.dart';
import './createteam.view.dart';
import './../Views/tabBarMega.view.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.ProxykhelThemeData,
      home: Scaffold(
        appBar: new AppBar(
          title: Text('CONTEST DETAILS',style: TextStyle(fontSize: 16.0,color: Colors.white),),
          actions: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            new IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                })
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
                  new Text('19h 32m 42s',style: TextStyle(color: Colors.white),),
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
      ),
    );
  }
}
