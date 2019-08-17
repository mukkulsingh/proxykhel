import 'package:flutter/material.dart';
import './../Model/contest.model.dart';
import './../Constants/slideTransitions.dart';
import './../Views/contestdetail.view.dart';
import './../Model/contestdetail.model.dart';
import './../Constants/contestdata.dart';

class TabBarHtoH extends StatefulWidget {
  String matchId;
  TabBarHtoH({@required this.matchId});
  @override
  _TabBarHtoHState createState() => _TabBarHtoHState();
}

class _TabBarHtoHState extends State<TabBarHtoH> {

  static String _contestFees='';


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
      child: FutureBuilder<ContestList>(
        future: ContestModel.instance.getContestList(matchId),
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return new Center(child: new CircularProgressIndicator(),);
          }
          else if(!snapshot.hasData){
            return new Center(child: Container(margin:EdgeInsets.only(top:
            100.0),child: new Text('No Contests found')));
          }else{
            return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index){
                  if(snapshot.data.data[index].entryfee == "0"){
                    _contestFees = "free";
                  }
                  else{
                    _contestFees = '₹ ${snapshot.data.data[index].entryfee}';
                  }
                  double t = (int.parse(snapshot.data.data[index].totlaJoin) / int.parse(snapshot.data.data[index].maxTeam));
                  if(snapshot.data.data[index].contestType == ContestType.WIN_LOST){
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
                                            new CircleAvatar(
                                              radius: 10.0,
                                              backgroundColor: Colors.deepOrange,
                                              child: new Text('M',style: TextStyle(color:Colors.white,fontSize: 10),),
                                            ),
                                            new InkWell(
                                                onTap: _showDialogWinningBreakdown,
                                                child:new Row(
                                                  children: <Widget>[
                                                    new Text('Winning'),
                                                    new Icon(Icons.arrow_drop_down),
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
//                                  Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.only(left:12.0),
//                                        child: new Text(snapshot.data.data[index].totlaJoin+'/'+snapshot.data.data[index].maxTeam+' Joined',style: TextStyle(fontSize: 12.0),),
//                                      ),
//                                    ],
//                                  ),
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

                  }else{
                    return Container();
                  }
                }
            );
          }
        },
      ),
    );
  }
}
