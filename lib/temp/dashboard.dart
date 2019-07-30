import 'package:flutter/material.dart';

import './../includes/bottomNavBar.dart';
import './../main.dart';
import './../includes/theme.dart' as Theme;
import 'createContest.dart';
import 'package:proxykhel/Views/mycontest.view.dart';
import 'BottomNavContest.dart';
import 'tabBarBody.dart';


void main() => runApp(Dashboard());

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _onTap(int index) {
      print(index);
      if (index == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContestNav()));
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.ProxykhelThemeData,
        home: DefaultTabController(
          length: 4,
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text(
                'CONTEST MATCH',
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
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => Logins()));
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
              TabBarBodyCricket(),
              TabBarBodyFootBall(),
              TabBarBodyKabaddi(),
              TabBarBodyHockey()
            ]),
            bottomNavigationBar: BottomNavBar(),
          ),
        ));
  }
}
