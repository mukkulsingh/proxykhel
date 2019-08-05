import 'package:flutter/material.dart';

import './../Constants/slideTransitions.dart';
import './../Model/logout.model.dart';
import './../Views/login.view.dart';
import './../Views/wallet.view.dart';
import './../Model/createteam.model.dart';
import './../Model/contestdetail.model.dart';

class CreateTeam extends StatefulWidget {
  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  static bool _isBatsman = false;
  static bool _isBowler = false;
  static bool _isWicketee = false;
  static bool _isAllrounder = false;
  static bool _isStarplayer = false;
  static bool _isXpplayer = false;
  static bool _isSupefive = false;
  static bool _isChoosenplayer = false;

  Card getStructuredGridCell(String a) {
    return new Card(
      elevation: 2.0,
      color: Colors.white,
      child: new InkWell(
        highlightColor: Colors.white.withAlpha(30),
        splashColor: Colors.white.withAlpha(20),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              new Center(
                child: new Text(a),
              )
            ]),
        onTap: () {
//          _tappedCategoryCell(item.routeName);
        },
      ),
    );
  }

  List<Widget> _loadCategories() {
    List<Widget> categoryCells = [];
    List<dynamic> categories = [
      "abhishek",
      "vivek",
      "abhishek",
      "vivie",
      "vivek",
      "abhishek",
      "vivie",
      "vivek",
      "abhishek",
      "vivie",
      "vivek",
      "abhishek",
      "vivie",
      "vivek",
      "abhishek",
      "vivie",
    ];
    for (int i = 0; i < categories.length; i++) {
      categoryCells.add(getStructuredGridCell(categories[i]));
    }

    return categoryCells;
  }

  void resetAll() {
    _isBatsman = false;
    _isBowler = false;
    _isWicketee = false;
    _isAllrounder = false;
    _isStarplayer = false;
    _isXpplayer = false;
    _isSupefive = false;
    _isChoosenplayer = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isBatsman = true;
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
                  await LogoutModel.instance.logoutRequest();
                  Navigator.of(context).pushAndRemoveUntil(
                      SlideRightRoute(widget: LoginScreen()),
                      (Route<dynamic> route) => false);
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

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'CREATE TEAM',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.maybePop(context);
              }),
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
                  _showLogoutDialog('Warning', 'You sure you want to logout?');
//
                }
              },
            ),
          ]),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Container(
              height: 230,
              color: Colors.red[900],
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                padding: _isBatsman
                                    ? const EdgeInsets.all(3.0)
                                    : const EdgeInsets.all(0.0),
                                child: new CircleAvatar(
                                  child: Image(
                                      image: NetworkImage(
                                          "https://www.proxykhel.com/assets/image/icons/Batsman.png")),
                                  backgroundColor: Colors.white,
                                  radius: 24.0,
                                ),
                              ),
                              onTap: () {
                                resetAll();
                                setState(() {
                                  _isBatsman = true;
                                });
                              },
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4.0),
                                child: new Text(
                                  'BatsMan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                padding: _isBowler
                                    ? const EdgeInsets.all(3.0)
                                    : const EdgeInsets.all(0.0),
                                child: new CircleAvatar(
                                  child: Image(
                                      image: NetworkImage(
                                          "https://www.proxykhel.com/assets/image/icons/Bowler.png")),
                                  backgroundColor: Colors.white,
                                  radius: 24.0,
                                ),
                              ),
                              onTap: () {
                                resetAll();
                                setState(() {
                                  _isBowler = true;
                                });
                              },
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4.0),
                                child: new Text(
                                  'Bowler',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                padding: _isWicketee
                                    ? const EdgeInsets.all(3.0)
                                    : const EdgeInsets.all(0.0),
                                child: new CircleAvatar(
                                  child: Image(
                                      image: NetworkImage(
                                          "https://www.proxykhel.com/assets/image/icons/Wicket-Keeper.png")),
                                  backgroundColor: Colors.white,
                                  radius: 24.0,
                                ),
                              ),
                              onTap: () {
                                resetAll();
                                setState(() {
                                  _isWicketee = true;
                                });
                              },
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4.0),
                                child: new Text(
                                  'Wicket Kepper',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                padding: _isAllrounder
                                    ? const EdgeInsets.all(3.0)
                                    : const EdgeInsets.all(0.0),
                                child: new CircleAvatar(
                                  child: Image(
                                      image: NetworkImage(
                                          "https://www.proxykhel.com/assets/image/icons/All-Rounder.png")),
                                  backgroundColor: Colors.white,
                                  radius: 24.0,
                                ),
                              ),
                              onTap: () {
                                resetAll();
                                setState(() {
                                  _isAllrounder = true;
                                });
                              },
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4.0),
                                child: new Text(
                                  'All Rounder',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    padding: _isStarplayer
                                        ? const EdgeInsets.all(3.0)
                                        : const EdgeInsets.all(0.0),
                                    child: new CircleAvatar(
                                      child: Image(
                                          image: NetworkImage(
                                              "https://www.proxykhel.com/assets/image/icons/Man-of-the-Match.png")),
                                      backgroundColor: Colors.white,
                                      radius: 24.0,
                                    ),
                                  ),
                                  onTap: () {
                                    resetAll();
                                    setState(() {
                                      _isStarplayer = true;
                                    });
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 4.0),
                                    child: new Text(
                                      'Star Player',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    padding: _isXpplayer
                                        ? const EdgeInsets.all(3.0)
                                        : const EdgeInsets.all(0.0),
                                    child: new CircleAvatar(
                                      child: Image(
                                          image: NetworkImage(
                                              "https://www.proxykhel.com/assets/image/icons/Super-Striker.png")),
                                      backgroundColor: Colors.white,
                                      radius: 24.0,
                                    ),
                                  ),
                                  onTap: () {
                                    resetAll();
                                    setState(() {
                                      _isXpplayer = true;
                                    });
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 4.0),
                                    child: new Text(
                                      'X Player',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    padding: _isSupefive
                                        ? const EdgeInsets.all(3.0)
                                        : const EdgeInsets.all(0.0),
                                    child: new CircleAvatar(
                                      child: Image(
                                          image: NetworkImage(
                                              "https://www.proxykhel.com/assets/image/icons/fwp.png")),
                                      backgroundColor: Colors.white,
                                      radius: 24.0,
                                    ),
                                  ),
                                  onTap: () {
                                    resetAll();
                                    setState(() {
                                      _isSupefive = true;
                                    });
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 4.0),
                                    child: new Text(
                                      'Super five',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    padding: _isChoosenplayer
                                        ? const EdgeInsets.all(3.0)
                                        : const EdgeInsets.all(0.0),
                                    child: new CircleAvatar(
                                      child: Image(
                                          image: NetworkImage(
                                              "https://www.proxykhel.com/assets/image/icons/Choosen-Players.png")),
                                      backgroundColor: Colors.white,
                                      radius: 24.0,
                                    ),
                                  ),
                                  onTap: () {
                                    resetAll();
                                    setState(() {
                                      _isChoosenplayer = true;
                                    });
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 4.0),
                                    child: new Text(
                                      'Choosen player',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder(
                future: CreateTeamModel.instance.getMatchTeam("https://www.proxykhel.com/android/Createteam.php",
                  ContestDetailModel.instance.getMatchId(),
                  ContestDetailModel.instance.getTeam1Name(),
                  ContestDetailModel.instance.getTeam2Name()
                ),
                builder: (context,snapshot) {
                  print(snapshot.data);
                  switch (snapshot.connectionState) {

                    case ConnectionState.none:
                      return Stack(
                        children: <Widget>[
                          Center(child: CircularProgressIndicator())
                        ],
                      );
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Stack(
                        children: <Widget>[
                          Center(child: CircularProgressIndicator())
                        ],
                      );
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      return GridView.count(
                        crossAxisCount: 2,
                        children: _loadCategories(),
                      );
                  }
                }
                ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new OutlineButton(
              onPressed: () {},
              child: Text("Save Team"),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(32.0),
              ),
              borderSide: BorderSide(
                color: Colors.green,
                style: BorderStyle.solid,
                width: 0.8,
              ),
              color: Colors.green,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: new Text('100 Creadit left'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
