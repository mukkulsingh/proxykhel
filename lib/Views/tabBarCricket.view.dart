import 'package:flutter/material.dart';
import './../Views/createcontest.view.dart';
import './../Model/upcomingmatches.model.dart';
import './../Constants/slideTransitions.dart';
import './../Model/contestdetail.model.dart';

class TabBarCricket extends StatefulWidget {

  @override
  _TabBarCricketState createState() => _TabBarCricketState();
}

class _TabBarCricketState extends State<TabBarCricket> {

  String timeRemaining = '';

  MatchData matchData = null;

  //  final RefreshController _matchController  = RefreshController();
//  Future _loadData() async {
//    // perform fetching data delay
//    await new Future.delayed(new Duration(seconds: 1));
//    matchData = await UpcomingMatchModel.instance.fetchUpcomingMatch();
//    // update data and loading status
//    setState(() {
//
//    });
//  }

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
            return new Center(child: Container(margin:EdgeInsets.only(top:
            100.0),child: new Text('No match')));
          }
          else
            return ListView.builder(
              itemCount: snapshot.data.matchData.length,
              itemBuilder: (BuildContext context,int index){
                String matchDateTime = snapshot.data.matchData[index].matchDateTime;
                String formattedMatchDateTime = matchDateTime.replaceAll('/', '-');
                convertDateFromString(formattedMatchDateTime);
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 120,
                  child: InkWell(
                    onTap: () {
                      if(snapshot.data.matchData[index].visibility == '1'){
                        String matchDateTime = snapshot.data.matchData[index].matchDateTime;
                        String formattedMatchDateTime = matchDateTime.replaceAll('/', '-');
                        ContestDetailModel.instance.setContestDuration(convertDateFromString(formattedMatchDateTime)
                        );
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
                    child: new Card(
                      elevation: 4,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Column(
                                  children: <Widget>[
                                    new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.matchData[index].team1Image),height: 80,width: 80,),
                                    new Text(snapshot.data.matchData[index].team1Name),
                                  ],
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(timeRemaining,style: TextStyle(fontSize: 12.0,color: Colors.deepOrange,fontWeight: FontWeight.w900),),
                                  ],
                                ),
                                new Column(
                                  children: <Widget>[
                                    new Image(image: NetworkImage('https://www.proxykhel.com/public/teamLogo/'+snapshot.data.matchData[index].team2Image),height: 80,width: 80,),
                                    new Text(snapshot.data.matchData[index].team2Name),
                                  ],
                                ),
                              ]
                          ),
                        ],
                      ),
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
