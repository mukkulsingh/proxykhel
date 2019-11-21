import 'package:flutter/material.dart';
import './../Model/joinedContestDetail.model.dart';
import './../Model/JoinedContestListModel.model.dart';
import './../Constants/slideTransitions.dart';
import './JoinedContestList.view.dart';

class MyContestCricketTab extends StatefulWidget {
  @override
  _MyContestCricketTabState createState() => _MyContestCricketTabState();
}

class _MyContestCricketTabState extends State<MyContestCricketTab> {

  String timeRemaining = '';
  static int _currentScreen;

  static bool _isLiveButtonSelected;
  static bool _isUpcomingButtonSelected;
  static bool _isFinishedButtonSelected;

  static String _contestFees='';
  static String _contestCancel = '';
  static String _multipleEntry = '';
  static String _singleEntry = '';
  static String _opponent = '';
  static String _amountVaries = '';

  String convertDateFromString(Duration difference){

    String d = difference.toString();

    String d1 = d.replaceFirst(':', ' h ');
//    String d2  = d1.replaceFirst(':', "Min ");
    List l1 = d1.split(':');
    String d2 = l1[0].toString();
    String finalDuration = d2+" m left";
    timeRemaining = finalDuration;
    return timeRemaining;
  }

  @override
  void initState() {
    super.initState();
    _currentScreen = 0;
  }

  @override
  Widget build(BuildContext context) {

    if(_currentScreen == 0){
      _isLiveButtonSelected = true;
      _isUpcomingButtonSelected = false;
      _isFinishedButtonSelected=false;

    }
    else if(_currentScreen == 1){
      _isUpcomingButtonSelected = true;
      _isLiveButtonSelected = false;
      _isFinishedButtonSelected=false;
    }
    else{
      _isFinishedButtonSelected = true;
      _isUpcomingButtonSelected = false;
      _isLiveButtonSelected = false;
    }

    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: new Container(
            margin: EdgeInsets.all(10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                new FlatButton(onPressed: (){
                  setState(() {
                    _currentScreen = 0;
                  });
                },
                  child: new Text('LIVE',style: TextStyle(color: _isLiveButtonSelected?Colors.white:Colors.black),),
                  color: _isLiveButtonSelected?Colors.deepOrange:Colors.white,
                ),



                new FlatButton(onPressed: (){
                  setState(() {
                    _currentScreen = 1;
                  });
                },
                  color: _isUpcomingButtonSelected?Colors.deepOrange:Colors.white,
                  child: new Text('UPCOMING',style: TextStyle(color:_isUpcomingButtonSelected?Colors.white:Colors.black,)),
                ),
                new FlatButton(onPressed: (){
                  setState(() {
                    _currentScreen = 2;
                  });
                },

                  color: _isFinishedButtonSelected?Colors.deepOrange:Colors.white,
                  child: new Text('FINISHED',style: TextStyle(color: _isFinishedButtonSelected?Colors.white:Colors.black),),
                ),

              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: FutureBuilder(
              future: JoinedContestModel.instance.getJoinedContestDetail(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return new Center(child: new CircularProgressIndicator(),);
                    break;
                  case ConnectionState.done:
                    if(snapshot.hasError){
                      return new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         new Text('Error Fetching data'),
                          new FlatButton(onPressed: (){
                            setState(() {

                            });
                          }, child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Try Again",style: TextStyle(color: Colors.deepOrange),),
                              new Icon(Icons.refresh,color: Colors.deepOrange,),
                            ],))
                        ],
                      );
                    }
                    else if(!snapshot.hasData){
                      return new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text("Zero contest joined"),
                          new FlatButton(onPressed: (){
                            setState(() {

                            });
                          }, child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Refresh",style: TextStyle(color: Colors.deepOrange),),
                              new Icon(Icons.refresh,color: Colors.deepOrange,),
                            ],))

                        ],
                      );
                    }
                    else if(snapshot.hasData){
                      return  RefreshIndicator(
                        onRefresh: ()async{
                          setState(() {

                          });
                        },
                        child: new ListView.builder(
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (BuildContext context, int index){
                              String dateTimeGmt  = snapshot.data.data[index].dateTimeGmt;
                              List d = dateTimeGmt.split('T');
                              String b = d[1];
                              List t = b.split('Z');
                              var dateTime = d[0] +' '+ t[0];
                              DateTime matchDateTime = DateTime.parse(dateTime);
                              Duration difference = (matchDateTime).difference(DateTime.now());
                              String _visibility =  snapshot.data.data[index].visibility;
                              if(_currentScreen == 0 && difference < Duration(hours:0,minutes: 0, seconds: 0) && difference > Duration(hours: -8)){
                                return new Container(
                                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    height: 120,
                                    child: InkWell(
                                      onTap: () {
                                        JoinedContestListModel.instance.setClicable(true);
                                        JoinedContestListModel.instance.setMatchId(snapshot.data.data[index].id);
                                        JoinedContestListModel.instance.setTeam1(snapshot.data.data[index].team1Name);
                                        JoinedContestListModel.instance.setTeam2(snapshot.data.data[index].team2Name);
                                        JoinedContestListModel.instance.setMatchType(snapshot.data.data[index].matchType);
                                        Navigator.push(context, SlideLeftRoute(widget: JoinedContestList()));
                                      },
                                      child: Stack(
                                        children: <Widget>[

                                          new Card(
                                            elevation:4,
                                            child: new Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      new Column(
                                                        children: <Widget>[
                                                          new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.data[index].team1Image),height: 80,width: 80,),
                                                          new Text(snapshot.data.data[index].team1Name,style: TextStyle(fontWeight: FontWeight.bold),),
                                                        ],
                                                      ),
                                                      new Column(
                                                        mainAxisAlignment: MainAxisAlignment.center
                                                        ,
                                                        children: <Widget>[
                                                          new SizedBox(
                                                            height: 30,
                                                            width: 80,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.deepOrange,
                                                                  borderRadius: BorderRadius.circular(32.0)
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top:8.0),
                                                                child: new Text(snapshot.data.data[index].matchType,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                                                              ),
                                                            ),
                                                          ),
                                                          new SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          new Text(convertDateFromString(difference),style: TextStyle(fontSize: 12.0,color: Colors.deepOrange,fontWeight: FontWeight.w900),),
                                                        ],
                                                      ),
                                                      new Column(
                                                        children: <Widget>[
                                                          new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.data[index].team2Image),height: 80,width: 80,),
                                                          new Text(snapshot.data.data[index].team2Name,style: TextStyle(fontWeight: FontWeight.bold),),
                                                        ],
                                                      ),
                                                    ]
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                              }else
                              if(_currentScreen == 1 && difference > Duration(hours: 0,minutes: 0,seconds: 0)){
                                return new Container(
                                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    height: 120,
                                    child: InkWell(
                                      onTap: () {
                                        JoinedContestListModel.instance.setClicable(false);
                                        JoinedContestListModel.instance.setMatchId(snapshot.data.data[index].id);
                                        JoinedContestListModel.instance.setTeam1(snapshot.data.data[index].team1Name);
                                        JoinedContestListModel.instance.setTeam2(snapshot.data.data[index].team2Name);
                                        JoinedContestListModel.instance.setMatchType(snapshot.data.data[index].matchType);
                                        Navigator.push(context, SlideLeftRoute(widget: JoinedContestList()));
                                      },
                                      child: Stack(
                                        children: <Widget>[

                                          new Card(
                                            elevation:4,
                                            child: new Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      new Column(
                                                        children: <Widget>[
                                                          new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.data[index].team1Image),height: 80,width: 80,),
                                                          new Text(snapshot.data.data[index].team1Name,style: TextStyle(fontWeight: FontWeight.bold),),
                                                        ],
                                                      ),
                                                      new Column(
                                                        mainAxisAlignment: MainAxisAlignment.center
                                                        ,
                                                        children: <Widget>[
                                                          new SizedBox(
                                                            height: 30,
                                                            width: 80,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.deepOrange,
                                                                  borderRadius: BorderRadius.circular(32.0)
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top:8.0),
                                                                child: new Text(snapshot.data.data[index].matchType,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                                                              ),
                                                            ),
                                                          ),
                                                          new SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          new Text(convertDateFromString(difference),style: TextStyle(fontSize: 12.0,color: Colors.deepOrange,fontWeight: FontWeight.w900),),
                                                        ],
                                                      ),
                                                      new Column(
                                                        children: <Widget>[
                                                          new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.data[index].team2Image),height: 80,width: 80,),
                                                          new Text(snapshot.data.data[index].team2Name,style: TextStyle(fontWeight: FontWeight.bold),),
                                                        ],
                                                      ),
                                                    ]
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );


                              }else
                              if( _currentScreen==2 ){
                                if(difference >= Duration(hours: -8))
                                  return new Container();
                                else
                                return new  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    height: 120,
                                    child: InkWell(
                                      onTap: () {
                                        JoinedContestListModel.instance.setClicable(true);
                                        JoinedContestListModel.instance.setMatchId(snapshot.data.data[index].id);
                                        JoinedContestListModel.instance.setTeam1(snapshot.data.data[index].team1Name);
                                        JoinedContestListModel.instance.setTeam2(snapshot.data.data[index].team2Name);
                                        JoinedContestListModel.instance.setMatchType(snapshot.data.data[index].matchType);
                                        Navigator.push(context, SlideLeftRoute(widget: JoinedContestList()));
                                      },
                                      child: Stack(
                                        children: <Widget>[

                                          new Card(
                                            elevation:4,
                                            child: new Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      new Column(
                                                        children: <Widget>[
                                                          new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.data[index].team1Image),height: 80,width: 80,),
                                                          new Text(snapshot.data.data[index].team1Name,style: TextStyle(fontWeight: FontWeight.bold),),
                                                        ],
                                                      ),
                                                      new Column(
                                                        mainAxisAlignment: MainAxisAlignment.center
                                                        ,
                                                        children: <Widget>[
                                                          new SizedBox(
                                                            height: 30,
                                                            width: 80,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.deepOrange,
                                                                  borderRadius: BorderRadius.circular(32.0)
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top:8.0),
                                                                child: new Text(snapshot.data.data[index].matchType,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                                                              ),
                                                            ),
                                                          ),
                                                          new SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          new Text("Finished",style: TextStyle(fontSize: 12.0,color: Colors.deepOrange,fontWeight: FontWeight.w900),),
                                                          new Text(snapshot.data.data[index].matchDate.day.toString()+'-'+snapshot.data.data[index].matchDate.month.toString()+'-'+snapshot.data.data[index].matchDate.year.toString(),
                                                            style: TextStyle(color: Colors.deepOrangeAccent[400],fontSize: 12.0),
                                                          )
                                                        ],
                                                      ),
                                                      new Column(
                                                        children: <Widget>[
                                                          new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.data[index].team2Image),height: 80,width: 80,),
                                                          new Text(snapshot.data.data[index].team2Name,style: TextStyle(fontWeight: FontWeight.bold),),
                                                        ],
                                                      ),
                                                    ]
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                }
                              return new Container();
                            }),
                      );
                    }
                    else{
                      return new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text("Something went wrong"),
                          new FlatButton(onPressed: (){
                            setState(() {

                            });
                          }, child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Retry",style: TextStyle(color: Colors.deepOrange),),
                              new Icon(Icons.refresh,color: Colors.deepOrange,),
                            ],))
                        ],
                      );
                    }
                }
                return new Container();
            }),
        )
      ],
    );
  }
}
