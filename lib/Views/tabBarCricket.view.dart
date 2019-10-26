import 'package:flutter/material.dart';
import './../Views/createcontest.view.dart';
import './../Model/upcomingmatches.model.dart';
import './../Constants/slideTransitions.dart';
import './../Model/contestdetail.model.dart';
import './../Model/contest.model.dart';

class TabBarCricket extends StatefulWidget {

  @override
  _TabBarCricketState createState() => _TabBarCricketState();
}

class _TabBarCricketState extends State<TabBarCricket> {

  String timeRemaining = '';

  MatchData matchData = null;

  static bool _isNotVisible;
  static double _elevation;


  String convertDateFromString(String matchDate){
    final matchDatee = DateTime.parse(matchDate);
    Duration difference = matchDatee.difference(DateTime.now());
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
    _isNotVisible=false;
    _elevation = 4;
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: ()async{
        setState(() {

        });
      },
      child: FutureBuilder<MatchData>(
        future: UpcomingMatchModel.instance.fetchUpcomingMatch(),
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return new Center(child: new CircularProgressIndicator(),);
          }

          else if(!snapshot.hasData)  {
            return new Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(child: new Text('Please check your internet connection!')),
                SizedBox(height: 10.0,),
                InkWell(
                  onTap: (){
                    setState(() {

                    });
                  },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text("Retry",style: TextStyle(color: Colors.deepOrange),),
                      SizedBox(width: 5.0,),
                      new Icon(Icons.refresh,color: Colors.deepOrange,)
                    ],
                  ),
                )
              ],
            ));
          }
          else
            return ListView.builder(
              itemCount: snapshot.data.matchData.length,
              itemBuilder: (BuildContext context,int index){
                String matchDateTime = snapshot.data.matchData[index].matchDateTime;
                print(matchDateTime);
                String formattedMatchDateTime = matchDateTime.replaceAll('/', '-');
                convertDateFromString(formattedMatchDateTime);
                if(snapshot.data.matchData[index].visibility == '0'){
                  _isNotVisible = true;
                  _elevation = 0;
                }
                else{
                  _isNotVisible=false;
                  _elevation = 4;
                }
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 120,
                  child: InkWell(
                    onTap: () {
                      if(snapshot.data.matchData[index].visibility == '1'){
                        String matchDateTime = snapshot.data.matchData[index].matchDateTime;
                        String formattedMatchDateTime = matchDateTime.replaceAll('/', '-');
                        ContestDetailModel.instance.setContestDuration(convertDateFromString(formattedMatchDateTime));
                        ContestDetailModel.instance.setMatchId(snapshot.data.matchData[index].id);
                        ContestDetailModel.instance.setTeam1Name(snapshot.data.matchData[index].team1Name);
                        ContestDetailModel.instance.setTeam2Name(snapshot.data.matchData[index].team2Name);
                        ContestModel.instance.setTeamName(snapshot.data.matchData[index].team1Name
                            , snapshot.data.matchData[index].team2Name);
                        ContestDetailModel.instance.setMatchType(snapshot.data.matchData[index].matchType);
                        Navigator.push(
                            context,
                            SlideLeftRoute(
                                widget: CreateContest(matchId: snapshot.data.matchData[index].id,)));
                      }
                      else{
                        final snackbar = new SnackBar(content: Text('Match inactive'));
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Stack(
                      children: <Widget>[

                          new Card(
                          elevation: _elevation,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Column(
                                      children: <Widget>[
                                        new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.matchData[index].team1Image),height: 50,width: 50,),
                                        new Text(snapshot.data.matchData[index].team1Name,style: TextStyle(fontWeight: FontWeight.bold),),
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
                                              child: new Text(snapshot.data.matchData[index].matchType,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                                            ),
                                          ),
                                        ),
                                        new SizedBox(
                                          height: 20.0,
                                        ),
                                        new Text(timeRemaining,style: TextStyle(fontSize: 12.0,color: Colors.deepOrange,fontWeight: FontWeight.w900),),
                                      ],
                                    ),
                                    new Column(
                                      children: <Widget>[
                                        new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.matchData[index].team2Image),height: 50,width: 50,),
                                        new Text(snapshot.data.matchData[index].team2Name,style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ]
                              ),
                            ],
                          ),
                        ),
                        _isNotVisible?new Container(
                          decoration: BoxDecoration(
                            color: Colors.white54
                          ),
                        ):new Container()
                      ],
                    ),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}
