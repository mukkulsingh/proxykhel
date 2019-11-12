import 'package:flutter/material.dart';
import 'package:proxykhel/Model/LeaderBoard.model.dart';
import 'package:proxykhel/Model/PlayerPointModel.model.dart';
import './../Constants/slideTransitions.dart';
import './wallet.view.dart';
import './../Model/logout.model.dart';
import './login.view.dart';
import './profile.view.dart';
import './../Model/JoinedContestListModel.model.dart';
import 'GeneralPoints.view.dart';
import 'LeaderBoard.view.dart';

class JoinedContestList extends StatefulWidget {
  @override
  _JoinedContestListState createState() => _JoinedContestListState();
}

class _JoinedContestListState extends State<JoinedContestList> {

  static String _contestFees='';
  static String _contestCancel = '';
  static String _multipleEntry = '';
  static String _singleEntry = '';
  static String _opponent = '';
  static String _amountVaries = '';

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

            new Container(
              width: double.infinity,
              height: 45.0,
              child: InkWell(
                onTap: (){
                  PlayerPointModel.instance.setMatchId(JoinedContestListModel.instance.getMatchId);
                  Navigator.push(context,SlideLeftRoute(widget: new GeneralPoints()));
                },
                child: new Card(
                  child: Container(margin:EdgeInsets.only(top: 6.0),child: Text("   View Player Point",style:TextStyle(color:Colors.deepOrange))),
                ),
              ),
            ),
            new Expanded(
                flex:7,
                child: new FutureBuilder(
                    future:JoinedContestListModel.instance.getJoinedContest(),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return new Center(child: new CircularProgressIndicator(),);
                          break;
                        case ConnectionState.done:
                          if(snapshot.hasError){
                            return new Center(child: new Text("Error fetching contests"),);
                          }else if(!snapshot.hasData){
                            return new Center(child: new Text("0 contests joined"),);
                          }else if(snapshot.hasData){
                            return new ListView.builder(
                                itemCount: snapshot.data.data.length,
                                itemBuilder: (context,index){
                                  if(snapshot.data.data[index].multiEntry == "2"){_multipleEntry = "M";}else{_multipleEntry = null;}

                                  if(snapshot.data.data[index].contestCancel == "4"){_contestCancel = "U";}else{_contestCancel = null;}

                                  if(snapshot.data.data[index].singleEntry == "1"){ _singleEntry = "S";}else{_singleEntry = null;}

                                  if(snapshot.data.data[index].opponent == "5"){_opponent = "P";}else{_opponent = null;}

                                  if(snapshot.data.data[index].winingAmtVary == "3"){_amountVaries = "C";}else{_amountVaries = null;}
                                  return new Container(
                                    height: 100,
                                    child: InkWell(
                                      onTap: (){
                                        if(JoinedContestListModel.instance.getIsClickable){
                                        LeaderBoardModel.instance.setContestId(snapshot.data.data[index].id);
                                        LeaderBoardModel.instance.setMatchId(snapshot.data.data[index].matchId);
                                        Navigator.push(context, SlideLeftRoute(widget:LeaderBoard()));
                                        }else{}
                                      },
                                      child: new Card(
                                        child:new Column(
                                          children: <Widget>[
                                            LinearProgressIndicator(
                                              value:(int.parse(snapshot.data.data[index].totlaJoin) / int.parse(snapshot.data.data[index].maxTeam)),
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
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          new Row(
                                                            mainAxisSize:MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Builder(builder: (context){
                                                                if(_singleEntry != null){
                                                                  return new Container(
                                                                    child: InkWell(
                                                                      onTap: (){
                                                                        showDialog(context: context,
                                                                            builder: (context){
                                                                              return AlertDialog(
                                                                                title: new Text("S",style: TextStyle(color: Colors.deepOrange),),
                                                                                content: new Text("You can join only one team"),
                                                                                actions: <Widget>[
                                                                                  new OutlineButton(onPressed: (){
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                    child: new Text("OK",style:TextStyle(color: Colors.deepOrange)),
                                                                                    borderSide: BorderSide(
                                                                                      color: Colors.deepOrange,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child: new CircleAvatar(
                                                                        backgroundColor: Colors.deepOrange,
                                                                        child: new Text(_singleEntry,style: TextStyle(color: Colors.white,fontSize: 12.0)),
                                                                        radius: 8.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }else
                                                                  return new Container();
                                                              }),
                                                              SizedBox(width: 2.0,),
                                                              Builder(builder: (context){
                                                                if(_multipleEntry != null){
                                                                  return new Container(
                                                                    child: InkWell(
                                                                      onTap: (){
                                                                        showDialog(context: context,
                                                                            builder: (context){
                                                                              return AlertDialog(
                                                                                title: new Text("M",style: TextStyle(color: Colors.deepOrange),),
                                                                                content: new Text("You can join more than 4 teams"),
                                                                                actions: <Widget>[
                                                                                  new OutlineButton(onPressed: (){
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                    child: new Text("OK",style:TextStyle(color: Colors.deepOrange)),
                                                                                    borderSide: BorderSide(
                                                                                      color: Colors.deepOrange,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child: new CircleAvatar(
                                                                        backgroundColor: Colors.deepOrange,
                                                                        child: new Text(_multipleEntry,style: TextStyle(color: Colors.white,fontSize: 12.0),),
                                                                        radius: 8.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }else
                                                                  return new Container();
                                                              }),
                                                              SizedBox(width: 2.0,),
                                                              Builder(builder: (context){
                                                                if(_opponent != null){
                                                                  return new Container(
                                                                    child: InkWell(
                                                                      onTap: (){
                                                                        showDialog(context: context,
                                                                            builder: (context){
                                                                              return AlertDialog(
                                                                                title: new Text("P",style: TextStyle(color: Colors.deepOrange),),
                                                                                content: new Text("Contest will be deemed cancelled if opponent is not joined"),
                                                                                actions: <Widget>[
                                                                                  new OutlineButton(onPressed: (){
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                    child: new Text("OK",style:TextStyle(color: Colors.deepOrange)),
                                                                                    borderSide: BorderSide(
                                                                                      color: Colors.deepOrange,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child: new CircleAvatar(
                                                                        backgroundColor: Colors.deepOrange,
                                                                        child: new Text(_opponent,style: TextStyle(color: Colors.white,fontSize: 12.0)),
                                                                        radius: 8.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }else
                                                                  return new Container();
                                                              }),
                                                              SizedBox(width: 2.0,),
                                                              Builder(builder: (context){
                                                                if(_contestCancel != null){
                                                                  return new Container(
                                                                    child: InkWell(
                                                                      onTap: (){
                                                                        showDialog(context: context,
                                                                            builder: (context){
                                                                              return AlertDialog(
                                                                                title: new Text("U",style: TextStyle(color: Colors.deepOrange),),
                                                                                content: new Text("Contest will be deemed cancelled if not full"),
                                                                                actions: <Widget>[
                                                                                  new OutlineButton(onPressed: (){
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                    child: new Text("OK",style:TextStyle(color: Colors.deepOrange)),
                                                                                    borderSide: BorderSide(
                                                                                      color: Colors.deepOrange,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child: new CircleAvatar(
                                                                        backgroundColor: Colors.deepOrange,
                                                                        child: new Text(_contestCancel,style: TextStyle(color: Colors.white,fontSize: 12.0)),
                                                                        radius: 8.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }else
                                                                  return new Container();
                                                              }),
                                                              SizedBox(width: 2.0,),
                                                              Builder(builder: (context){
                                                                if(_amountVaries != null){
                                                                  return new Container(
                                                                    child: InkWell(
                                                                      onTap: (){
                                                                        showDialog(context: context,
                                                                            builder: (context){
                                                                              return AlertDialog(
                                                                                title: new Text("C",style: TextStyle(color: Colors.deepOrange),),
                                                                                content: new Text("Winning prize will varies on the basis of joined"),
                                                                                actions: <Widget>[
                                                                                  new OutlineButton(onPressed: (){
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                    child: new Text("OK",style:TextStyle(color: Colors.deepOrange)),
                                                                                    borderSide: BorderSide(
                                                                                      color: Colors.deepOrange,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child: new CircleAvatar(
                                                                        backgroundColor: Colors.deepOrange,
                                                                        child: new Text(_amountVaries,style: TextStyle(color: Colors.white,fontSize: 12.0)),
                                                                        radius: 8.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }else
                                                                  return new Container();
                                                              }),
                                                            ],
                                                          ),
                                                          new InkWell(
                                                            splashColor: Colors.white,
//                                              onTap: _showDialogWinningBreakdown,
                                                              onTap: (){
                                                                List tileList =[];
                                                                int itemCount=0,singleDistribution=0, rangeDistribution=0;
                                                                if(snapshot.data.data[index].singleDistrubution != false){
                                                                  singleDistribution = snapshot.data.data[index].singleDistrubution.length;
//                                              singleDistribution = 1;
                                                                  tileList.add({"name":"Single Distribution"});
                                                                }
                                                                if(snapshot.data.data[index].rangeDistrubution != false){
                                                                  rangeDistribution = snapshot.data.data[index].rangeDistrubution.length;
//                                                rangeDistribution =1;
                                                                  tileList.add({"name":"Range Distribution"});
                                                                }
                                                                itemCount = singleDistribution + rangeDistribution;

//                                                                showDialog(context: context,
//                                                                    builder: (context)=>AlertDialog(
//                                                                        title: new Text("Winning Breakdown"),
//                                                                        content: ListView(
//                                                                          shrinkWrap: true,
//                                                                          children: <Widget>[
//                                                                            new ListView.builder(
//                                                                                shrinkWrap: true,
//                                                                                physics: const NeverScrollableScrollPhysics(),
//                                                                                itemCount: singleDistribution,
//                                                                                itemBuilder: (context, index2){
//                                                                                  return new Container(
//                                                                                    margin: EdgeInsets.only(top:10.0),
//                                                                                    child: new Row(
//                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                      children: <Widget>[
//                                                                                        new Text(
//                                                                                            "Rank ${snapshot.data.data[index].singleDistrubution[index2]['rank']}"
//                                                                                        ),
//                                                                                        Text(
//                                                                                            "₹ ${snapshot.data.data[index].singleDistrubution[index2]['winamt']}"
//                                                                                        ),
//                                                                                      ],
//                                                                                    ),
//                                                                                  );
////                                                         return ListTile(title: new Text(
////                                                           "Rank ${snapshot.data.data[index].singleDistrubution[index2]['rank']}"
////                                                         ),
////                                                           subtitle: Text(
////                                                               "₹ ${snapshot.data.data[index].singleDistrubution[index2]['winamt']}"
////                                                           ),
////                                                         );
//                                                                                }),
//                                                                            new ListView.builder(
//                                                                                shrinkWrap: true,
//                                                                                physics: const NeverScrollableScrollPhysics(),
//                                                                                itemCount: rangeDistribution,
//                                                                                itemBuilder: (context, index3){
//                                                                                  double winper = ((double.tryParse(snapshot.data.data[index].rangeDistrubution[index3]['winamt'])) / ((double.parse(snapshot.data.data[index].rangeDistrubution[index3]['lastrange']) + 1 ) - double.parse(snapshot.data.data[index].rangeDistrubution[index3]['firstrange'])));
//                                                                                  return new Container(
//                                                                                    margin: EdgeInsets.only(top:10.0),
//                                                                                    child: new Row(
//                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                      children: <Widget>[
//                                                                                        new Text(
//                                                                                            "Rank ${snapshot.data.data[index].rangeDistrubution[index3]['firstrange']} - ${snapshot.data.data[index].rangeDistrubution[index3]['lastrange'] }"
//                                                                                        ),
//                                                                                        Text("₹ ${winper.toString()}"
////                                                                   "₹ ${snapshot.data.data[index].rangeDistrubution[index3]['winper']}"
//                                                                                        ),
//                                                                                      ],
//                                                                                    ),
//                                                                                  );
//
//                                                                                })
//
//                                                                          ],
//                                                                        ),
//                                                                        actions: <Widget>[
//                                                                          new OutlineButton(
//                                                                            color:Colors.deepOrange,
//                                                                            borderSide: BorderSide(
//                                                                                color: Colors.deepOrange
//                                                                            ),
//                                                                            child: new Text("Got It!"),
//                                                                            onPressed: () {
//                                                                              Navigator.of(context).pop();
//                                                                            },
//                                                                          ),
//                                                                        ]
//                                                                    )
//                                                                );
                                                              },
                                                              child:new Row(
                                                                children: <Widget>[
                                                                  new Text(''),
                                                                  new Icon(Icons.arrow_drop_down,color: Colors.white,),
                                                                ],
                                                              )
                                                          ),
                                                          new Text('Rs. '+snapshot.data.data[index].winnersAmt),
                                                        ],
                                                      ),
                                                    ),
                                                    new Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        new Text('Winners'),
                                                        new Text(snapshot.data.data[index].winner,style: TextStyle(fontWeight: FontWeight.bold),),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top:18.0),
                                                          child: new Text(snapshot.data.data[index].totlaJoin+'/'+snapshot.data.data[index].maxTeam+' Joined',style: TextStyle(fontSize: 12.0),),
                                                        ),

                                                      ],
                                                    ),
                                                    new Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Container(margin: EdgeInsets.only(top: 10.0), child: new Text('Entry')),
                                                        Container(
                                                          margin: EdgeInsets.only(top :20.0,right: 8.0),
                                                          child: new Text(snapshot.data.data[index].entryfee),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            new Column(
                                              children: <Widget>[
                                                new Row(
                                                  children: <Widget>[

                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ),
                                    ),
                                  );

                                });
                          }else{
                            new Center(child: Column(
                              children: <Widget>[
                                new Text("Something went wrong retry"),
                                new RaisedButton(onPressed: (){
                                  setState(() {

                                  });
                                },
                                  child: new Text("Retry",style: TextStyle(color: Colors.white),),
                                  color: Colors.deepOrange,

                                ),
                              ],
                            ),);
                          }
                      }
                      return new Container();
                    })),
          ],
        ),
    );
  }
}
