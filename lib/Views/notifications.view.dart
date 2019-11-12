import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proxykhel/Model/logout.model.dart';
import 'package:proxykhel/Views/wallet.view.dart';
import './../Constants//theme.dart' as Theme;
import './../Model/Notification.model.dart';
import './bottomnavbar.view.dart';
import './../Constants/slideTransitions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'MyProfile.view.dart';
import 'login.view.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with WidgetsBindingObserver {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Completer<Null> completer;
  bool foreground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    foreground = (state == AppLifecycleState.resumed);
    if (foreground && completer != null) {
      completer.complete();
      completer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  await googleSignIn.signOut();
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
      home: Scaffold(
          appBar: AppBar(
            title: new Text(
              'Notifications',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            actions: <Widget>[
              new IconButton(
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, SlideLeftRoute(widget: Wallet()));
                },
              ),
              new PopupMenuButton<int>(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 1,
                    child: new Text('My Profile'),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: new Text('Logout'),
                  ),
                ],
                onSelected: (value) async {
                  if (value == 2) {
                    _showLogoutDialog(
                        'Warning', 'You sure you want to logout?');
                  } else if (value == 1) {
                    Navigator.push(
                        context, SlideLeftRoute(widget: MyProfile()));
                  }
                },
              )
            ],
          ),
          body: new RefreshIndicator(
            onRefresh: () {
              return NotificationModel.instance.getNotifications();
            },
            child: new FutureBuilder(
                future: NotificationModel.instance.getNotifications(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return new Center(
                        child: new CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return new Center(
                          child: new Text("Error fetching notification"),
                        );
                      } else if (!snapshot.hasData) {
                        return new Center(
                          child: new Text("0 Notifications"),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.notif.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  new Container(
                                    height: 100.0,
                                    width: double.infinity,
                                    child: new Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 2.0),
                                                height: double.infinity,
                                                width: double.infinity,
                                                color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 18.0),
                                                  child: new Text(
                                                    snapshot.data.notif[index]
                                                        .title,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 28.0),
                                            child: new Text(snapshot
                                                .data.notif[index].description),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              );
                            });
                      }
                  }
                  return new Container();
                }),
          ),
          bottomNavigationBar: BottomNavBar()),
    );
  }
}
