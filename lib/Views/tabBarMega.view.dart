import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proxykhel/Model/GetContestTypeMega.model.dart';
import './../Constants/slideTransitions.dart';
import './../Views/contestdetail.view.dart';
import './../Model/contestdetail.model.dart';
import './contestdetail.view.dart';
import './../Constants/contestdata.dart';

class TabBarMega extends StatefulWidget {
  String matchId;
  TabBarMega({@required this.matchId});
  @override
  _TabBarMegaState createState() => _TabBarMegaState();
}

class _TabBarMegaState extends State<TabBarMega> {

  //single_entry=1 (s)
  //multi_entry = 2 (m)
  //winingAmtVary = 3 (c)
  //contest_Cancel = 4(u)
  //opponent = 5(p)


  static String _contestFees='';
  static String _contestCancel = '';
  static String _multipleEntry = '';
  static String _singleEntry = '';
  static String _opponent = '';
  static String _amountVaries = '';

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
      child: FutureBuilder<GetContestTypeMega>(
        future: GetContestTypeMegaModel.instance.getContestMega(matchId),
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
          }else {
            return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index){
                  if(snapshot.data.data[index].entryfee == "0"){ _contestFees = "free"; }
                  else{ _contestFees = '₹ ${snapshot.data.data[index].entryfee}'; }

                  if(snapshot.data.data[index].multiEntry == "2"){_multipleEntry = "M";}else{_multipleEntry = null;}

                  if(snapshot.data.data[index].contestCancel == "4"){_contestCancel = "U";}else{_contestCancel = null;}

                  if(snapshot.data.data[index].singleEntry == "1"){ _singleEntry = "S";}else{_singleEntry = null;}

                  if(snapshot.data.data[index].opponent == "5"){_opponent = "P";}else{_opponent = null;}

                  if(snapshot.data.data[index].winingAmtVary == "3"){_amountVaries = "C";}else{_amountVaries = null;}


                  double t = (int.parse(snapshot.data.data[index].totlaJoin) / int.parse(snapshot.data.data[index].maxTeam));
                  return new Container(
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
                                                    child: new CircleAvatar(
                                                      backgroundColor: Colors.deepOrange,
                                                      child: new Text(_singleEntry,style: TextStyle(color: Colors.white,fontSize: 12.0)),
                                                      radius: 8.0,
                                                    ),
                                                  );
                                                }else
                                                  return new Container();
                                              }),
                                              SizedBox(width: 2.0,),
                                              Builder(builder: (context){
                                                if(_multipleEntry != null){
                                                  return new Container(
                                                    child: new CircleAvatar(
                                                      backgroundColor: Colors.deepOrange,
                                                      child: new Text(_multipleEntry,style: TextStyle(color: Colors.white,fontSize: 12.0),),
                                                      radius: 8.0,
                                                    ),
                                                  );
                                                }else
                                                  return new Container();
                                              }),
                                              SizedBox(width: 2.0,),
                                              Builder(builder: (context){
                                                if(_opponent != null){
                                                  return new Container(
                                                    child: new CircleAvatar(
                                                      backgroundColor: Colors.deepOrange,
                                                      child: new Text(_opponent,style: TextStyle(color: Colors.white,fontSize: 12.0)),
                                                      radius: 8.0,
                                                    ),
                                                  );
                                                }else
                                                  return new Container();
                                              }),
                                              SizedBox(width: 2.0,),
                                              Builder(builder: (context){
                                                if(_contestCancel != null){
                                                  return new Container(
                                                    child: new CircleAvatar(
                                                      backgroundColor: Colors.deepOrange,
                                                      child: new Text(_contestCancel,style: TextStyle(color: Colors.white,fontSize: 12.0)),
                                                      radius: 8.0,
                                                    ),
                                                  );
                                                }else
                                                  return new Container();
                                              }),
                                              SizedBox(width: 2.0,),
                                              Builder(builder: (context){
                                                if(_amountVaries != null){
                                                  return new Container(
                                                    child: new CircleAvatar(
                                                      backgroundColor: Colors.deepOrange,
                                                      child: new Text(_amountVaries,style: TextStyle(color: Colors.white,fontSize: 12.0)),
                                                      radius: 8.0,
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
                                            showDialog(context){
                                              return AlertDialog(

                                              );
                                            }
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