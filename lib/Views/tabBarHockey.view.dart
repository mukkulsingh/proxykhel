import 'package:flutter/material.dart';
import './../temp/createContest.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './../Model/upcomingmatches.model.dart';

class TabBarHockey extends StatefulWidget {

  @override
  _TabBarHockeyState createState() => _TabBarHockeyState();
}

class _TabBarHockeyState extends State<TabBarHockey> {



  MatchData matchData = null;
  final RefreshController _matchController  = RefreshController();
  Future _loadData() async {
    // perform fetching data delay
    await new Future.delayed(new Duration(seconds: 1));
    matchData = await UpcomingMatchModel.instance.fetchUpcomingMatch();
    // update data and loading status
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _matchController,
      header: defaultHeader,
      onRefresh: ()async{
        await Future.delayed(Duration(milliseconds: 10),_loadData);
        _matchController.refreshCompleted();
        _matchController.loadComplete();
      },
      enablePullDown: true,
      child: FutureBuilder<MatchData>(
        future: UpcomingMatchModel.instance.fetchUpcomingMatch(),
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return new Center(child: new CircularProgressIndicator(),);
          }

          else if(!snapshot.hasData)  {
            return new Center(child: Container(margin:EdgeInsets.only(top:
            200.0),child: new Text('No match')));
          }
          else
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.matchData.length,
              itemBuilder: (BuildContext contex,int index){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 100,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateContest()));
                    },
                    child: new Card(
                      elevation: 4,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Image.asset(
                                'assets/images/odi-logo.png',
                                height: 55.0,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Image.asset(
                                'assets/images/eng.png',
                                width: 55.0,
                                height: 55.0,
                              ),
                              new Text('ENG')
                            ],
                          ),
                          new SizedBox(
                            width: 10.0,
                          ),
                          new Text(
                            '2h 11m 7s',
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                          new SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Image.asset(
                                'assets/images/ind.png',
                                width: 55.0,
                                height: 55.0,
                              ),
                              new Text('IND')
                            ],
                          ),
                          new SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text('Contest'),
                              new Text(
                                '20+',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
//                          new Text('Context 20+'),
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