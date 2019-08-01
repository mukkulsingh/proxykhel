import 'package:flutter/material.dart';
import './../Constants/theme.dart' as Theme;
import './bottomnavbar.view.dart';
import './tabBarCricket.view.dart';
import './tabBarFootball.view.dart';
import './tabBarKabaddi.view.dart';
import './tabBarHockey.view.dart';
import './../Model/logout.model.dart';
import './../Constants/slideTransitions.dart';
import './../Views/login.view.dart';
void main() => runApp(Dashboard());

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {


    _onTap(int index) {
      print(index);
      if (index == 1) {
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => ContestNav()));
      }
    }



    void _showLogoutDialog(String title, String content) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () async {
                  await LogoutModel.instance.logoutRequest();
                  Navigator.of(context).pushAndRemoveUntil(SlideRightRoute(widget: LoginScreen()), (Route<dynamic> route)=>false);
                },
              ),
              new FlatButton(
                child: new Text("no"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
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
          new PopupMenuButton<int>(
            icon: Icon(Icons.menu,color: Colors.white,),
            itemBuilder: (context)=>[PopupMenuItem<int>(
              value:1,
              child: new Text('My Profile'),),
              PopupMenuItem<int>(
                value: 2,
                child: new Text('Logout'),
              ),
            ],
            onSelected: (value)async{
              if(value == 2){
                _showLogoutDialog('Warning','You sure you want to logout?');
//
              }
            } ,
          ),

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
              TabBarCricket(),
              TabBarFootball(),
              TabBarKabaddi(),
              TabBarHockey()
            ]),
            bottomNavigationBar: BottomNavBar(),
          ),
        ));
  }
}
