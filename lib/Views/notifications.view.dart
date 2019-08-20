import 'package:flutter/material.dart';
import './../Constants//theme.dart' as Theme;
import './../main.dart';
import './bottomnavbar.view.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.ProxykhelThemeData,
      home: Scaffold(
          appBar: AppBar(
            title: new Text('Notifications',
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

          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: new Card(
                      child: new Center(child: new Text('0 Contest joined',style: TextStyle(color: Colors.deepOrange),)),
                    ),
                  )
                ],
              ),
            ],
          ),

          bottomNavigationBar:BottomNavBar()

      ),
    );
  }
}
