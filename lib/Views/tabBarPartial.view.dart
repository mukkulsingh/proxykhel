import 'package:flutter/material.dart';
import 'package:proxykhel/Model/GetContestDetail.model.dart';
import 'package:proxykhel/Model/GetContestTypePartial.model.dart';
import './../Constants/slideTransitions.dart';
import './../Views/contestdetail.view.dart';
import './../Model/contestdetail.model.dart';
import './../Constants/contestdata.dart';

class TabBarPartial extends StatefulWidget {
  String matchId;
  TabBarPartial({@required this.matchId});
  @override
  _TabBarPartialState createState() => _TabBarPartialState();
}

class _TabBarPartialState extends State<TabBarPartial> {

  static String _contestFees='';

  static String _contestCancel = '';
  static String _multipleEntry = '';
  static String _singleEntry = '';
  static String _opponent = '';
  static String _amountVaries = '';


  static String matchId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matchId = widget.matchId;
  }
  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: ()async{
        setState(() {

        });
      },
      child: FutureBuilder(
        future: GetContestTypePartialModel.instance.getContestPartial(matchId),
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return new Center(child: new CircularProgressIndicator(),);
          }
          else if(!snapshot.hasData){
            return new Center(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('No Contests found'),
                new SizedBox(height: 10.0,),
                InkWell(
                  onTap: (){
                    setState(() {
                    });
                  },
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text("Retry",style: TextStyle(color: Colors.deepOrange,fontSize: 18.0),),
                      new SizedBox(width: 5.0,),
                      new Icon(Icons.refresh,color: Colors.deepOrange,),
                    ],
                  ),
                )
              ],
            ));
          }else{
            return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index){
                  if(snapshot.data.data[index].entryfee == "0"){
                    _contestFees = "free";
                  }
                  else{
                    _contestFees ='₹ ${snapshot.data.data[index].entryfee}';
                  }
                  if(snapshot.data.data[index].multiEntry == "2"){_multipleEntry = "M";}else{_multipleEntry = null;}

                  if(snapshot.data.data[index].contestCancel == "4"){_contestCancel = "U";}else{_contestCancel = null;}

                  if(snapshot.data.data[index].singleEntry == "1"){ _singleEntry = "S";}else{_singleEntry = null;}

                  if(snapshot.data.data[index].opponent == "5"){_opponent = "P";}else{_opponent = null;}

                  if(snapshot.data.data[index].winingAmtVary == "3"){_amountVaries = "C";}else{_amountVaries = null;}

                  double t = (int.parse(snapshot.data.data[index].totlaJoin) / int.parse(snapshot.data.data[index].maxTeam));
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                    height: 120,
                    child: InkWell(
                      child: new Card(
                        child: new Column(
                          children: <Widget>[
                            LinearProgressIndicator(
                              value:t,
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

                                                showDialog(context: context,
                                                    builder: (context)=>AlertDialog(
                                                        title: new Text("Winning Breakdown"),
                                                        content: ListView(
                                                          shrinkWrap: true,
                                                          children: <Widget>[
                                                            new ListView.builder(
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemCount: singleDistribution,
                                                                itemBuilder: (context, index2){
                                                                  return new Container(
                                                                    margin: EdgeInsets.only(top:10.0),
                                                                    child: new Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: <Widget>[
                                                                        new Text(
                                                                            "Rank ${snapshot.data.data[index].singleDistrubution[index2]['rank']}"
                                                                        ),
                                                                        Text(
                                                                            "₹ ${snapshot.data.data[index].singleDistrubution[index2]['winamt']}"
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
//                                                         return ListTile(title: new Text(
//                                                           "Rank ${snapshot.data.data[index].singleDistrubution[index2]['rank']}"
//                                                         ),
//                                                           subtitle: Text(
//                                                               "₹ ${snapshot.data.data[index].singleDistrubution[index2]['winamt']}"
//                                                           ),
//                                                         );
                                                                }),
                                                            new ListView.builder(
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemCount: rangeDistribution,
                                                                itemBuilder: (context, index3){
                                                                  double winper = ((double.tryParse(snapshot.data.data[index].rangeDistrubution[index3]['winamt'])) / ((double.parse(snapshot.data.data[index].rangeDistrubution[index3]['lastrange']) + 1 ) - double.parse(snapshot.data.data[index].rangeDistrubution[index3]['firstrange'])));
                                                                  return new Container(
                                                                    margin: EdgeInsets.only(top:10.0),
                                                                    child: new Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: <Widget>[
                                                                        new Text(
                                                                            "Rank ${snapshot.data.data[index].rangeDistrubution[index3]['firstrange']} - ${snapshot.data.data[index].rangeDistrubution[index3]['lastrange'] }"
                                                                        ),
                                                                        Text("₹ ${winper.toString()}"
//                                                                   "₹ ${snapshot.data.data[index].rangeDistrubution[index3]['winper']}"
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );

                                                                })

                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          new OutlineButton(
                                                            color:Colors.deepOrange,
                                                            borderSide: BorderSide(
                                                                color: Colors.deepOrange
                                                            ),
                                                            child: new Text("Got It!"),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ]
                                                    )
                                                );
                                              },
                                              child:new Row(
                                                children: <Widget>[
                                                  new Text('Winning'),
                                                  new Icon(Icons.arrow_drop_down,color: Colors.black,),
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
                                          child: new FlatButton(onPressed: (){
                                            final contestData = ContestData(
                                                id: snapshot.data.data[index].id,
                                                matchId: snapshot.data.data[index].matchId,
                                                winingAmtVary: snapshot.data.data[index].winnersAmt,
                                                contestCancel: snapshot.data.data[index].contestCancel,
                                                maxTeam: snapshot.data.data[index].maxTeam,
                                                winnersAmt: snapshot.data.data[index].winnersAmt,
                                                proxyPercentage: snapshot.data.data[index].proxyPercentage,
                                                totlaJoin: snapshot.data.data[index].totlaJoin,
                                                singleEntry: snapshot.data.data[index].singleEntry,
                                                multiEntry: snapshot.data.data[index].multiEntry,
                                                entryfee: snapshot.data.data[index].entryfee,
                                                opponent: snapshot.data.data[index].opponent
                                            );
                                            ContestDetailModel.instance.setContestId(snapshot.data.data[index].id);
                                            ContestDetailModel.instance.setContestDetail(contestData);
                                            GetContestDetailModel.instance.setContestId(snapshot.data.data[index].id);
                                            Navigator.push(context, SlideLeftRoute(widget:ContestDetail()));
                                          },
                                            color: Colors.deepOrange,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(32.0)
                                            ),
                                            child: Text(_contestFees,style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}

