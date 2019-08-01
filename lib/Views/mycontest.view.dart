import 'package:flutter/material.dart';
import './../Constants/theme.dart' as Theme;
import './../main.dart';
import './bottomnavbar.view.dart';

class MyContest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.ProxykhelThemeData,
      home: DefaultTabController(length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: new Text('MY CONTEST',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            actions: <Widget>[
              new IconButton(
                  icon: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  )),
              new IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) => Logins()));
                  })
            ],
              bottom: TabBar(
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.5,
                ),
                tabs: [
                  Tab(
                    text: 'CRICKET',
                  ),
                  Tab(text: 'FOOTBALL'),
                  Tab(text: 'KABADDI'),
                  Tab(text: 'HOCKEY'),
                ],
              ),
          ),
          body: TabBarView(children: [
            new Container(
              margin: EdgeInsets.all(10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new FlatButton(onPressed: (){},
                    child: new Text('LIVE',style: TextStyle(color: Colors.white),),
                    color: Colors.deepOrange,
                  ),
                  new FlatButton(onPressed: (){},
                    highlightColor: Colors.deepOrange,
                    child: new Text('UPCOMING'),
                  ),
                  new FlatButton(onPressed: (){},
                    highlightColor: Colors.deepOrange,
                    child: new Text('FINISHED'),
                  ),
                  
                ],
              ),
            ),
            new Container(
              child: new Text('foo'),
            ),
            new Container(
              child: new Text('foo'),
            ),
            new Container(
              child: new Text('foo'),
            ),
          ]),

            bottomNavigationBar:BottomNavBar()

          )

      ),
    );
  }
}
