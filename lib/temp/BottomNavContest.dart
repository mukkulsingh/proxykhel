import 'package:flutter/material.dart';
import './../includes/theme.dart' as Theme;
import './../main.dart';
import 'tabBarBody.dart';
import './../includes/bottomNavBar.dart';
class ContestNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.ProxykhelThemeData,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(
                'MY CONTEST',
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
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
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.games,
                  color: Colors.black,
                ),
                title: Text(
                  'Games',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.input,
                  color: Colors.grey,
                ),
                title: Text(
                  'My contest',
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_active,
                  color: Colors.grey,
                ),
                title: Text(
                  'Notification',
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
