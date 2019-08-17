import 'package:flutter/material.dart';
import 'profile.view.dart';
import './../Constants/slideTransitions.dart';
import './../Model/logout.model.dart';
import './../Views/login.view.dart';
import './../Views/wallet.view.dart';
import './../Model/createteam.model.dart';
import './../Model/contest.model.dart';
import './../Model/contestdetail.model.dart';

class CreateTeam extends StatefulWidget {
  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  static String batsmanGroup = "Batsman";
  static String bowlerGroup = "Bowler";
  static String wkGroup = "Wicket Keeper";
  static String arGroup = "All Rounder";
  static String starPlayerGroup = "Star Player";
  static String xPlayerGroup = "X Player";
  static String superFiveGroup = "Super Five";

  static int _playerType;
  static bool _isBatsman = false;
  static bool _isBowler = false;
  static bool _isWicketee = false;
  static bool _isAllrounder = false;
  static bool _isStarplayer = false;
  static bool _isXpplayer = false;
  static bool _isSupefive = false;
  static bool _isChoosenplayer = false;

  List<Widget> _loadCategoriesBatsman(List playerType) {
    List<Widget> categoryCells = [];
    List categories = playerType;

    Color color = Colors.white;
    for (int i = 0; i < batsMan.length; i++) {
      int num = getPlayerColor(batsMan[i], batsmanGroup);
      if (num == 0) {
        color = Colors.white;
      } else if (num == 1) {
        color = Colors.deepOrangeAccent[100];
      } else {
        color = Colors.deepOrange;
      }
      categoryCells.add(Container(
        margin: EdgeInsets.all(2.0),
        child: InkWell(
          highlightColor: Colors.deepOrange,
          splashColor: Colors.deepOrange,
          onTap: () {
            selectPlayer(batsMan, batsMan[i], batsmanGroup, 1);
          },
          child: Card(
            color: color,
            child: Column(
              verticalDirection: VerticalDirection.down,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: new CircleAvatar(
//                child: Image(image: NetworkImage("https://www.proxykhel.com/public/player/${categories[i].imageUrl}")),
                    radius: 22.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://www.proxykhel.com/public/player/${allPlayers[batsMan[i]].imageUrl}"),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        allPlayers[batsMan[i]].playerName,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.8,
                        style: TextStyle(
                            color: categories[i].isSelected
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
                Expanded(flex: 1, child: Divider()),
                Expanded(
                    flex: 2,
                    child: new Text(
                      'Cr.${allPlayers[batsMan[i]].credit}',
                    ))
              ],
            ),
          ),
        ),

      ));
    }

    return categoryCells;
  }

  List<Widget> _loadCategoriesBowler(List playerType) {
    List<Widget> categoryCells = [];
    List categories = playerType;
    Color color = Colors.white;
    for (int i = 0; i < bowler.length; i++) {
      int num = getPlayerColor(bowler[i], bowlerGroup);
      if (num == 0) {
        color = Colors.white;
      } else if (num == 1) {
        color = Colors.deepOrangeAccent[100];
      } else {
        color = Colors.deepOrange;
      }
      categoryCells.add(Container(
        child: InkWell(
          highlightColor: Colors.deepOrange,
          splashColor: Colors.deepOrange,
          onTap: () {
            selectPlayer(bowler, bowler[i], bowlerGroup, 1);
          },
          child: Card(
            color: color,
            child: Column(
              verticalDirection: VerticalDirection.down,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: new CircleAvatar(
//                child: Image(image: NetworkImage("https://www.proxykhel.com/public/player/${categories[i].imageUrl}")),
                    radius: 22.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://www.proxykhel.com/public/player/${allPlayers[bowler[i]].imageUrl}"),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        allPlayers[bowler[i]].playerName,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.8,
                        style: TextStyle(
                            color: categories[i].isSelected
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
                Expanded(flex: 1, child: Divider()),
                Expanded(
                    flex: 2,
                    child: new Text(
                      'Cr.${categories[i].credit}',
                      style: TextStyle(
                          color: categories[i].isSelected
                              ? Colors.white
                              : Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ));
    }

    return categoryCells;
  }

  List<Widget> _loadCategoriesWicketKeeper(List playerType) {
    List<Widget> categoryCells = [];
    List categories = playerType;
    Color color = Colors.white;
    for (int i = 0; i < wicketKeeper.length; i++) {
      int num = getPlayerColor(wicketKeeper[i], wkGroup);
      if (num == 0) {
        color = Colors.white;
      } else if (num == 1) {
        color = Colors.deepOrangeAccent[100];
      } else {
        color = Colors.deepOrange;
      }
      categoryCells.add(Container(
        child: InkWell(
          onTap: () {
            selectPlayer(wicketKeeper, wicketKeeper[i], wkGroup, 1);
          },
          child: Card(
            color: color,
            child: Column(
              verticalDirection: VerticalDirection.down,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: new CircleAvatar(
//                child: Image(image: NetworkImage("https://www.proxykhel.com/public/player/${categories[i].imageUrl}")),
                    radius: 22.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://www.proxykhel.com/public/player/${allPlayers[wicketKeeper[i]].imageUrl}"),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        allPlayers[wicketKeeper[i]].playerName,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.8,
                        style: TextStyle(
                            color: categories[i].isSelected
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
                Expanded(flex: 1, child: Divider()),
                Expanded(
                    flex: 2,
                    child: new Text(
                      'Cr.${categories[i].credit}',
                      style: TextStyle(
                          color: allPlayers[wicketKeeper[i]].isSelected
                              ? Colors.white
                              : Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ));
    }

    return categoryCells;
  }

  List<Widget> _loadCategoriesAllRounder(List playerType) {
    List<Widget> categoryCells = [];
    List categories = playerType;
    Color color = Colors.white;
    for (int i = 0; i < allRounder.length; i++) {
      int num = getPlayerColor(allRounder[i], arGroup);
      if (num == 0) {
        color = Colors.white;
      } else if (num == 1) {
        color = Colors.deepOrangeAccent[100];
      } else {
        color = Colors.deepOrange;
      }
      categoryCells.add(Container(
        child: InkWell(
          onTap: () {
            selectPlayer(allRounder, allRounder[i], arGroup, 1);
          },
          child: Card(
            color: color,
            child: Column(
              verticalDirection: VerticalDirection.down,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: new CircleAvatar(
//                child: Image(image: NetworkImage("https://www.proxykhel.com/public/player/${categories[i].imageUrl}")),
                    radius: 22.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://www.proxykhel.com/public/player/${allPlayers[allRounder[i]].imageUrl}"),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        allPlayers[allRounder[i]].playerName,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.8,
                        style: TextStyle(
                            color: categories[i].isSelected
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
                Expanded(flex: 1, child: Divider()),
                Expanded(
                    flex: 2,
                    child: new Text(
                      'Cr.${allPlayers[allRounder[i]].credit}',
                      style: TextStyle(
                          color: categories[i].isSelected
                              ? Colors.white
                              : Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ));
    }

    return categoryCells;
  }

  List<Widget> _loadCategoriesStartPlayer(List playerType) {
    List<Widget> categoryCells = [];
    List categories = playerType;
    Color color = Colors.white;
    for (int i = 0; i < starPlayer.length; i++) {
      int num = getPlayerColor(starPlayer[i], starPlayerGroup);
      if (num == 0) {
        color = Colors.white;
      } else if (num == 1) {
        color = Colors.deepOrangeAccent[100];
      } else {
        color = Colors.deepOrange;
      }
      categoryCells.add(Container(
        child: InkWell(
          onTap: () {
            selectPlayer(starPlayer, starPlayer[i], starPlayerGroup, 1);
          },
          child: Card(
            color: color,
            child: Column(
              verticalDirection: VerticalDirection.down,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: new CircleAvatar(
//                child: Image(image: NetworkImage("https://www.proxykhel.com/public/player/${categories[i].imageUrl}")),
                    radius: 22.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://www.proxykhel.com/public/player/${allPlayers[starPlayer[i]].imageUrl}"),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        allPlayers[starPlayer[i]].playerName,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.8,
                        style: TextStyle(
                            color: categories[i].isSelected
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
                Expanded(flex: 1, child: Divider()),
                Expanded(
                    flex: 2,
                    child: new Text(
                      'Cr.${allPlayers[starPlayer[i]].credit}',
                      style: TextStyle(
                          color: categories[i].isSelected
                              ? Colors.white
                              : Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ));
    }

    return categoryCells;
  }

  List<Widget> _loadCategoriesXPlayer(List playerType) {
    List<Widget> categoryCells = [];
    List categories = playerType;
    Color color = Colors.white;
    for (int i = 0; i < xPlayer.length; i++) {
      int num = getPlayerColor(xPlayer[i], xPlayerGroup);
      if (num == 0) {
        color = Colors.white;
      } else if (num == 1) {
        color = Colors.deepOrangeAccent[100];
      } else {
        color = Colors.deepOrange;
      }
      categoryCells.add(Container(
        child: InkWell(
          onTap: () {
            selectPlayer(xPlayer, xPlayer[i], xPlayerGroup, 1);
          },
          child: Card(
            color: color,
            child: Column(
              verticalDirection: VerticalDirection.down,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: new CircleAvatar(
//                child: Image(image: NetworkImage("https://www.proxykhel.com/public/player/${categories[i].imageUrl}")),
                    radius: 22.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://www.proxykhel.com/public/player/${allPlayers[xPlayer[i]].imageUrl}"),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        allPlayers[xPlayer[i]].playerName,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.8,
                        style: TextStyle(
                            color: categories[i].isSelected
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
                Expanded(flex: 1, child: Divider()),
                Expanded(
                    flex: 2,
                    child: new Text(
                      'Cr.${allPlayers[xPlayer[i]].credit}',
                      style: TextStyle(
                          color: categories[i].isSelected
                              ? Colors.white
                              : Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ));
    }

    return categoryCells;
  }

  List<Widget> _loadCategoriesAll(List<dynamic> playerList) {
    List<Widget> categoryCells = [];
    List categories = playerList;
    Color color = Colors.white;
    for (int i = 0; i < superFive.length; i++) {
      int num = getPlayerColor(superFive[i], superFiveGroup);
      if (num == 0) {
        color = Colors.white;
      } else if (num == 1) {
        color = Colors.deepOrangeAccent[100];
      } else {
        color = Colors.deepOrange;
      }
      categoryCells.add(Container(
        child: InkWell(
          onTap: () {
            selectPlayer(superFive, superFive[i], superFiveGroup, 5);
          },
          child: Card(
            color: color,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: new CircleAvatar(
//                child: Image(image: NetworkImage("https://www.proxykhel.com/public/player/${categories[i].imageUrl}")),
                    radius: 22.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://www.proxykhel.com/public/player/${allPlayers[xPlayer[i]].imageUrl}"),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: new Text(
                      allPlayers[xPlayer[i]].playerName,
                      textAlign: TextAlign.center,
                      textScaleFactor: 0.8,
                      style: TextStyle(
                          color: categories[i].isSelected
                              ? Colors.white
                              : Colors.black),
                    )),
                Expanded(flex: 1, child: Divider()),
                Expanded(
                    flex: 2,
                    child: new Text(
                      'Cr.${allPlayers[xPlayer[i]].credit}',
                      style: TextStyle(
                          color: categories[i].isSelected
                              ? Colors.white
                              : Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ));
    }

    return categoryCells;
  }

  List<Widget> _loadCategoriesChoosenPlayer(List<dynamic> playerList) {
    List<Widget> categoryCells = [];
    if (chosenPlayer == []) {
      new Center(child: new Text('Please select 11 players'));
    }
    Color color = Colors.deepOrangeAccent;
    for (int i = 0; i < chosenPlayer.length; i++) {
      categoryCells.add(Container(
        child: Card(
          elevation: 4,
          color: color,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: new CircleAvatar(
//                child: Image(image: NetworkImage("https://www.proxykhel.com/public/player/${categories[i].imageUrl}")),
                  radius: 22.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      "https://www.proxykhel.com/public/player/${allPlayers[int.parse(chosenPlayer[i]['playerIndex'])].imageUrl}"),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: new Text(
                    allPlayers[int.parse(chosenPlayer[i]['playerIndex'])]
                        .playerName,
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.8,
                  )),
              Expanded(flex: 1, child: Divider()),
              Expanded(
                  flex: 2,
                  child: new Text(
                      'Cr.${allPlayers[int.parse(chosenPlayer[i]['playerIndex'])].credit}'))
            ],
          ),
        ),
      ));
    }

    return categoryCells;
  }

  List allPlayers;
  List batsMan;
  List bowler;
  List allRounder;
  List wicketKeeper;
  List starPlayer;
  List xPlayer;
  List superFive;
  List chosenPlayer;

  int getPlayerColor(int playerIndex, String groupName) {
    for (int i = 0; i < chosenPlayer.length; i++) {
      if (int.parse(chosenPlayer[i]['playerIndex']) == playerIndex &&
          chosenPlayer[i]['groupName'] == groupName)
        return 2;
      else if (int.parse(chosenPlayer[i]['playerIndex']) == playerIndex)
        return 1;
    }
    return 0;
  }

  int getPlayerCount(String groupName) {
    int count = 0;
    for (int i = 0; i < chosenPlayer.length; i++)
      if (chosenPlayer[i]['groupName'] == groupName) count++;
    return count;
  }

  double getTotalCreditOfTeam() {
    double credit = 0;
    for (int i = 0; i < chosenPlayer.length; i++)
      credit += double.parse(
          allPlayers[int.parse(chosenPlayer[i]['playerIndex'])].credit);
    return credit;
  }

  void selectPlayer(List playerList, int playerIndex, String groupName,
      int allowedSelection) {
    int colorCode = getPlayerColor(playerIndex, groupName);

    if (colorCode == 2) {
      for (int i = 0; i < chosenPlayer.length; i++) {
        if (playerIndex == int.parse(chosenPlayer[i]['playerIndex'])) {
          chosenPlayer.removeAt(i);
        }
      }
      setState(() {});
    } else if (colorCode == 1) {
      SnackBar snackBar =
          new SnackBar(content: Text('Player already selected'),duration: const Duration(seconds: 1),);
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      if (allowedSelection == getPlayerCount(groupName)) {
        // show("that this many batsman already selected");
        SnackBar snackBar = new SnackBar(
            content: Text('you can pick only $allowedSelection $groupName'),duration: const Duration(seconds: 1));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else if (getTotalCreditOfTeam() +
              double.parse(allPlayers[playerIndex].credit) >
          100) {
        //show('credit limit exeed');
        SnackBar snackBar = new SnackBar(content: Text('low credit'),duration: const Duration(seconds: 1));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        //show('select that player and add it into chosenPlayer');
        Map playerMap = new Map();
        playerMap['playerId'] = allPlayers[playerIndex].id;
        playerMap['playerIndex'] = playerIndex.toString();
        playerMap['groupName'] = groupName;
        chosenPlayer.add(playerMap);
        setState(() {});
      }
    }
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
    _isAllrounder = false;
    _isBowler = false;
    _isChoosenplayer = false;
    _isStarplayer = false;
    _isSupefive = false;
    _isWicketee = false;
    _isXpplayer = false;
    _playerType = 1;
    chosenPlayer = [];
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

    return Builder(
      builder: (context) => Scaffold(
        key: _scaffoldKey,
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
                    _showLogoutDialog(
                        'Warning', 'You sure you want to logout?');
                  } else if (value == 1) {
                    Navigator.push(context, SlideLeftRoute(widget: Profile()));
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
                                    _playerType = 1;
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
                                    _playerType = 2;
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
                                    _playerType = 3;
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
                                    _playerType = 4;
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
                                        _playerType = 5;
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
                                        _playerType = 6;
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
                                        _playerType = 7;
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
                                        _playerType = 8;
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
                  future: CreateTeamModel.instance.getMatchTeam(
                      "https://www.proxykhel.com/android/Createteam.php",
                      ContestDetailModel.instance.getMatchId(),
                      ContestDetailModel.instance.getTeam1Name(),
                      ContestDetailModel.instance.getTeam2Name()),
                  builder: (context, snapshot) {
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
                        else {
                          allPlayers = snapshot.data.data.supperSticker;
                          batsMan = [];
                          bowler = [];
                          allRounder = [];
                          wicketKeeper = [];
                          starPlayer = [];
                          xPlayer = [];
                          superFive = [];
                          for (int i = 0;
                              i < snapshot.data.data.batsman.length;
                              i++) {
                            for (int j = 0; j < allPlayers.length; j++) {
                              if (snapshot.data.data.batsman[i].id ==
                                  allPlayers[j].id) {
                                batsMan.add(j);
                              }
                            }
                          }

                          for (int i = 0;
                              i < snapshot.data.data.bowler.length;
                              i++) {
                            for (int j = 0; j < allPlayers.length; j++) {
                              if (snapshot.data.data.bowler[i].id ==
                                  allPlayers[j].id) {
                                bowler.add(j);
                              }
                            }
                          }

                          for (int i = 0;
                              i < snapshot.data.data.allRounder.length;
                              i++) {
                            for (int j = 0; j < allPlayers.length; j++) {
                              if (snapshot.data.data.allRounder[i].id ==
                                  allPlayers[j].id) {
                                allRounder.add(j);
                              }
                            }
                          }

                          for (int i = 0;
                              i < snapshot.data.data.wicketKeeper.length;
                              i++) {
                            for (int j = 0; j < allPlayers.length; j++) {
                              if (snapshot.data.data.wicketKeeper[i].id ==
                                  allPlayers[j].id) {
                                wicketKeeper.add(j);
                              }
                            }
                          }

                          for (int i = 0;
                              i < snapshot.data.data.supperSticker.length;
                              i++) {
                            for (int j = 0; j < allPlayers.length; j++) {
                              if (snapshot.data.data.supperSticker[i].id ==
                                  allPlayers[j].id) {
                                starPlayer.add(j);
                              }
                            }
                          }

                          for (int i = 0;
                              i < snapshot.data.data.supperSticker.length;
                              i++) {
                            for (int j = 0; j < allPlayers.length; j++) {
                              if (snapshot.data.data.supperSticker[i].id ==
                                  allPlayers[j].id) {
                                xPlayer.add(j);
                              }
                            }
                          }

                          int counter = 0;
                          for (int i = 0; i < allPlayers.length; i++) {
                            if (wicketKeeper.length >
                                counter) if (wicketKeeper[counter] == i) {
                              counter++;
                            } else {
                              superFive.add(i);
                            }
                            else
                              superFive.add(i);
                          }

                          switch (_playerType) {
                            case 1:
                              return GridView.count(
                                crossAxisCount: 3,
                                children: _loadCategoriesBatsman(
                                    snapshot.data.data.batsman),
                              );
                              break;
                            case 2:
                              return GridView.count(
                                crossAxisCount: 3,
                                children: _loadCategoriesBowler(
                                    snapshot.data.data.bowler),
                              );
                              break;
                            case 3:
                              return GridView.count(
                                crossAxisCount: 3,
                                children: _loadCategoriesWicketKeeper(
                                    snapshot.data.data.wicketKeeper),
                              );
                              break;
                            case 4:
                              return GridView.count(
                                crossAxisCount: 3,
                                children: _loadCategoriesAllRounder(
                                    snapshot.data.data.allRounder),
                              );
                              break;
                            case 5:
                              return GridView.count(
                                crossAxisCount: 3,
                                children: _loadCategoriesStartPlayer(
                                    snapshot.data.data.supperSticker),
                              );
                              break;
                            case 6:
                              return GridView.count(
                                crossAxisCount: 3,
                                children: _loadCategoriesXPlayer(
                                    snapshot.data.data.supperSticker),
                              );
                              break;
                            case 7:
                              List playerList = snapshot.data.data.bowler;
                              for (int i = 0;
                                  i < snapshot.data.data.batsman.length;
                                  i++) {
                                playerList.add(snapshot.data.data.batsman[i]);
                              }
                              for (int i = 0;
                                  i < snapshot.data.data.allRounder.length;
                                  i++) {
                                playerList
                                    .add(snapshot.data.data.allRounder[i]);
                              }
                              return GridView.count(
                                crossAxisCount: 3,
                                children: _loadCategoriesAll(playerList),
                              );
                              break;
                            case 8:
                              return GridView.count(
                                crossAxisCount: 3,
                                children: _loadCategoriesChoosenPlayer(
                                    snapshot.data.data.supperSticker),
                              );
                              break;

                            default:
                              new Container();
                              break;
                          }
                        }
                    }
                  }),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new OutlineButton(
                onPressed: () async {
                  if(chosenPlayer.length != 11){
                    SnackBar snackbar = new SnackBar(content: Text('Please choose 11 players'),duration: const Duration(seconds: 1));
                   _scaffoldKey.currentState.showSnackBar(snackbar);
                  }else{
                    List superFive = [];
                    for(int i=0;i<chosenPlayer.length;i++){
                      if(chosenPlayer[i]['groupName'] == 'Batsman'){
                        CreateTeamModel.instance.setBatsman(int.parse(chosenPlayer[i]['playerId']));
                      }
                      else if(chosenPlayer[i]['groupName'] == 'Bowler'){
                        CreateTeamModel.instance.setBowler(int.parse(chosenPlayer[i]['playerId']));

                      }
                      else if(chosenPlayer[i]['groupName'] == 'Wicket Keeper'){
                        CreateTeamModel.instance.setWicketKeeper(int.parse(chosenPlayer[i]['playerId']));

                      }
                      else if(chosenPlayer[i]['groupName'] == 'All Rounder'){
                        CreateTeamModel.instance.setAllRounder(int.parse(chosenPlayer[i]['playerId']));

                      }
                      else if(chosenPlayer[i]['groupName'] == 'Star Player'){
                        CreateTeamModel.instance.setStarPlayer(int.parse(chosenPlayer[i]['playerId']));

                      }
                      else if(chosenPlayer[i]['groupName'] == 'X Player'){
                        CreateTeamModel.instance.setXPlayer(int.parse(chosenPlayer[i]['playerId']));

                      }
                      else if(chosenPlayer[i]['groupName'] == 'Super Five'){
                        superFive.add(int.parse(chosenPlayer[i]['playerId']));
                        CreateTeamModel.instance.setSuperFive(superFive);
                      }
                    }
                    String matchId = ContestDetailModel.instance.getMatchId();
                    String contestId = ContestDetailModel.instance.getContestId();
                    bool check = await CreateTeamModel.instance.saveTeam(
                      matchId,
                      contestId,
                      getTotalCreditOfTeam().toString(),
                      ContestModel.instance.getTeamOneName(),
                      ContestModel.instance.getTeamTwoName()
                    );
                  }

                },
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
                    child: new Text((100 - getTotalCreditOfTeam()).toString() +
                        ' Credit left'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
