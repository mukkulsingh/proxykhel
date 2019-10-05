import 'package:flutter/material.dart';
import 'package:proxykhel/Model/GetContestTypeHtoH.model.dart';
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
      child: FutureBuilder(
        future: GetContestTypeHtoHModel.instance.getContestPartial(matchId),
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
                    _contestFees = '₹ ${snapshot.data.data[index].entryfee}';
                  }
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
                                          new CircleAvatar(
                                            radius: 10.0,
                                            backgroundColor: Colors.deepOrange,
                                            child: new Text('M',style: TextStyle(color:Colors.white,fontSize: 10),),
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
                }
            );
          }
        },
      ),
    );
  }
}
