import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import 'package:proxykhel/Model/CreateTeam.model.dart';
import 'package:proxykhel/Model/contest.model.dart';
import 'package:proxykhel/Views/contestdetail.view.dart';
import '../Model/contestdetail.model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CreateTeamTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("CREATE TEAM",style: TextStyle(fontSize: 16.0, color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: CreateTeamtemp(),
    );
  }
}
class CreateTeamtemp extends StatefulWidget {
  @override
  _CreateTeamtempState createState() => _CreateTeamtempState();
}

class _CreateTeamtempState extends State<CreateTeamtemp> {

  CreateTeamDetails createTeamDetails;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  static bool _isPageLoading;



  void getMatchDetails() async {
    createTeamDetails = await CreateTeamModel.instance.getMatchTeam(  ContestDetailModel.instance.getMatchId(),
        ContestDetailModel.instance.getTeam1Name(),
        ContestDetailModel.instance.getTeam2Name());

    if(createTeamDetails != null){
      setState(() {
        _isPageLoading = false;
      });
    }


  }
  Future onSelectNotification(String payload) async {
    if (payload != null) {
    }
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ContestDetail()),
    );
  }

  Future _showNotificaitonWithDefault() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails("notification_channel_id", "Channel Name", "channelDescription",
      importance: Importance.Max,
      priority: Priority.High
    );
    var iosPlatformChannelSpecifics = new IOSNotificationDetails();
     var platformChannelSpecific = new NotificationDetails(androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);
     await flutterLocalNotificationsPlugin.show(0, "New team created", "You have successfully created a new team", platformChannelSpecific);
  }
  @override
  void initState() {
    super.initState();
    _isPageLoading = true;
    CreateTeamModel.instance.resetAll();
    CreateTeamModel.instance.setPlayerType(1);
      CreateTeamModel.instance.setBatsman(true);
    getMatchDetails();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {


    if(_isPageLoading){
      return new Center(child: new CircularProgressIndicator(),);
    }else

    Future.delayed(Duration(milliseconds: 300),(){setState(() {});});

    return Column(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.deepOrange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new SizedBox(height: 5.0,),
                Expanded(
                  flex:1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[

                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  padding: CreateTeamModel.instance.getBatsman
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
                                  setState(() {
                                    CreateTeamModel.instance.resetAll();
                                    CreateTeamModel.instance.setBatsman(true);
                                    CreateTeamModel.instance.setPlayerType(1);
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 35.0),
                                height:16.0,
                                width:16.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                            child: new Text("${CreateTeamModel.instance.getPlayerCount("Batsman")}",textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 4.0),
                              child: new Text(
                                'BatsMan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  padding: CreateTeamModel.instance.getBowler
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
                                  setState(() {
                                    CreateTeamModel.instance.resetAll();
                                    CreateTeamModel.instance.setBowler(true);
                                    CreateTeamModel.instance.setPlayerType(2);
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 35.0),
                                height:16.0,
                                width:16.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: new Text("${CreateTeamModel.instance.getPlayerCount("Bowler")}",textAlign: TextAlign.center,),
                              ),


                            ],
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
                          Stack(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  padding: CreateTeamModel.instance.getWicketee
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
                                  setState(() {
                                    CreateTeamModel.instance.resetAll();
                                    CreateTeamModel.instance.setWicketee(true);
                                    CreateTeamModel.instance.setPlayerType(3);
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 35.0),
                                height:16.0,
                                width:16.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: new Text("${CreateTeamModel.instance.getPlayerCount("Wicket Keeper")}",textAlign: TextAlign.center,),
                              )

                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 4.0),
                              child: new Text(
                                'Wicket Keeper',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  padding: CreateTeamModel.instance.getAllRounder
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
                                  setState(() {
                                    CreateTeamModel.instance.resetAll();
                                    CreateTeamModel.instance.setAllRounder(true);
                                    CreateTeamModel.instance.setPlayerType(4);
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 35.0),
                                height:16.0,
                                width:16.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: new Text("${CreateTeamModel.instance.getPlayerCount("All Rounder")}",textAlign: TextAlign.center,),
                              )

                            ],
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
                      )
                    ],
                  ),
                ),

                Expanded(
                  flex:1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  padding: CreateTeamModel.instance.getStarPlayer
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
                                  setState(() {
                                    CreateTeamModel.instance.resetAll();
                                    CreateTeamModel.instance.setStarPlayer(true);
                                    CreateTeamModel.instance.setPlayerType(5);
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 35.0),
                                height:16.0,
                                width:16.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: new Text("${CreateTeamModel.instance.getPlayerCount("Star Player")}",textAlign: TextAlign.center,),
                              )

                            ],
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
                          Stack(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  padding: CreateTeamModel.instance.getXPlayer
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
                                  setState(() {
                                    CreateTeamModel.instance.resetAll();
                                    CreateTeamModel.instance.setXPlayer(true);
                                    CreateTeamModel.instance.setPlayerType(6);
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 35.0),
                                height:16.0,
                                width:16.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: new Text("${CreateTeamModel.instance.getPlayerCount("X Player")}",textAlign: TextAlign.center,),
                              )

                            ],
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
                          Stack(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  padding: CreateTeamModel.instance.getSuperFive
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
                                  setState(() {
                                    CreateTeamModel.instance.resetAll();
                                    CreateTeamModel.instance.setSuperFive(true);
                                    CreateTeamModel.instance.setPlayerType(7);
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 35.0),
                                height:16.0,
                                width:16.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: new Text("${CreateTeamModel.instance.getPlayerCount("Super Five")}",textAlign: TextAlign.center,),
                              )

                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 4.0),
                              child: new Text(
                                'Super Five',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),

                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  padding: CreateTeamModel.instance.getChosenPlayer
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
                                  setState(() {
                                    CreateTeamModel.instance.resetAll();
                                    CreateTeamModel.instance.setChosenPlayer(true);
                                    CreateTeamModel.instance.setPlayerType(8);
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 35.0),
                                height:16.0,
                                width:16.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: new Text("${
                                    CreateTeamModel.instance.getPlayerCount("Bowler")
                                        +CreateTeamModel.instance.getPlayerCount("Wicket Keeper")
                                        +CreateTeamModel.instance.getPlayerCount("Batsman")
                                        +CreateTeamModel.instance.getPlayerCount("All Rounder")
                                        +CreateTeamModel.instance.getPlayerCount("Star Player")
                                        +CreateTeamModel.instance.getPlayerCount("X Player")
                                        +CreateTeamModel.instance.getPlayerCount("Super Five")
                                }",textAlign: TextAlign.center,),
                              )

                            ],
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
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),


        Expanded(
          flex:12,
          child: Builder(
            builder:(context){
              bool playingEleven=false;
              List currentPlayerList = [];
              List playerListWithIndices = [];
              String groupName = "";
              int playerCount;
              switch(CreateTeamModel.instance.getPlayerType){
                case 1:
                  currentPlayerList = createTeamDetails.data.batsman;
                  playerListWithIndices = CreateTeamModel.instance.getBatsmanList;
                  groupName = "Batsman";
                  playerCount=1;
                  break;
                case 2:
                  currentPlayerList = createTeamDetails.data.bowler;
                  playerListWithIndices = CreateTeamModel.instance.getBowlerList;
                  groupName = "Bowler";
                  playerCount=1;
                  break;
                case 3:
                  currentPlayerList = createTeamDetails.data.wicketKeeper;
                  playerListWithIndices = CreateTeamModel.instance.getWicketKeeperList;
                  groupName = "Wicket Keeper";
                  playerCount=1;
                  break;
                case 4:
                  currentPlayerList = createTeamDetails.data.allRounder;
                  playerListWithIndices = CreateTeamModel.instance.getAllRounderList;
                  groupName = "All Rounder";
                  playerCount=1;
                  break;
                case 5:
                  currentPlayerList = createTeamDetails.data.supperSticker;
                  playerListWithIndices = CreateTeamModel.instance.getStarPlayerList;
                  groupName = "Star Player";
                  playerCount=1;
                  break;
                case 6:
                  currentPlayerList = createTeamDetails.data.supperSticker;
                  playerListWithIndices = CreateTeamModel.instance.getXPlayerList;
                  groupName = "X Player";
                  playerCount=1;
                  break;
                case 7:
                  currentPlayerList = createTeamDetails.data.supperSticker;
                  playerListWithIndices = CreateTeamModel.instance.getSuperFiveList;
                  groupName = "Super Five";
                  playerCount=5;
                  break;
                case 8:
                  playingEleven=true;
                  if(CreateTeamModel.instance.getChosenPlayerList.length == 0){
                    return new Center(child: new Text("Please select 11 players"),);
                  }
                  return new GridView.builder(gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3
                  ),
                      itemCount: CreateTeamModel.instance.getChosenPlayerList.length,
                      itemBuilder: (context,index){
                    return new Card(
                      color: Colors.deepOrange[200],
                      elevation: 4,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: new CircleAvatar(
                              radius: 22.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                  "https://www.proxykhel.com/public/player/${CreateTeamModel.instance.allPlayers[int.parse(CreateTeamModel.instance.getChosenPlayerList[index]['playerIndex'])].imageUrl}"),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: new Text(
                                CreateTeamModel.instance.allPlayers[int.parse(CreateTeamModel.instance.getChosenPlayerList[index]['playerIndex'])]
                                    .playerName,
                                textAlign: TextAlign.center,
                                textScaleFactor: 0.8,
                              )),
                          Expanded(flex: 1, child: Divider()),
                          Expanded(

                              flex: 2,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  new Text(
                                    '${CreateTeamModel.instance.allPlayers[int.parse(CreateTeamModel.instance.getChosenPlayerList[index]['playerIndex'])].teamname}',
                                  ),
                                  new Text(
                                    'Cr:${CreateTeamModel.instance.allPlayers[int.parse(CreateTeamModel.instance.getChosenPlayerList[index]['playerIndex'])].credit}',
                                  )
                                ],
                              )

                          )
                        ],
                      ),
                    );
                  });
                  break;
              }
              return GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3
                ),
                itemCount: currentPlayerList.length,
                itemBuilder: (context,index){
                  Color color = Colors.white;
                  Color textColor = Colors.black;
                  int num = CreateTeamModel.instance.getPlayerColor(playerListWithIndices[index], groupName);
                  if (num == 0) {
                    color = Colors.white;
                    textColor = Colors.black;
                  } else if (num == 1) {
                    color = Colors.deepOrangeAccent[100];
                    textColor = Colors.black;
                  } else {
                    color = Colors.deepOrange;
                    textColor = Colors.white;
                  }
                  return InkWell(
                    onTap: (){
                      if(playingEleven){}else {
                      int num = CreateTeamModel.instance.selectPlayer(playerListWithIndices, playerListWithIndices[index], groupName, currentPlayerList[index].teamname,playerCount,7);
                        switch(num){
                          case 0:
                            setState(() {});
                            break;
                          case 1:
                            setState(() {});
                            break;
                          case 2:
                            SnackBar snackBar = new SnackBar(content: Text('you can pick only $playerCount player'),duration: const Duration(seconds: 1));
                            Scaffold.of(context).showSnackBar(snackBar);
                          break;
                          case 3:
                            SnackBar snackBar = new SnackBar(content: Text('Player already selected'),duration: const Duration(seconds: 1));
                            Scaffold.of(context).showSnackBar(snackBar);
                            break;
                          case 4:
                            SnackBar snackBar = new SnackBar(content: Text('Low credit'),duration: const Duration(seconds: 1));
                            Scaffold.of(context).showSnackBar(snackBar);
                            break;
                          case 5:
                            SnackBar snackBar = new SnackBar(content: Text('You can pick only 7 players from one team'),duration: const Duration(seconds: 1));
                            Scaffold.of(context).showSnackBar(snackBar);
                        }
                      }
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
                              radius: 22.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                  "https://www.proxykhel.com/public/player/${currentPlayerList[index].imageUrl}"),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: new Text(
                                  currentPlayerList[index].playerName,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                      color: textColor
                                  ),
                                ),
                              )),
                          Expanded(flex: 1, child: Divider()),
                          Expanded(
                              flex: 2,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  new Text(
                                    '${currentPlayerList[index].teamname}',
                                  ),
                                  new Text(
                                    'Cr:${currentPlayerList[index].credit}',
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          ),
        ),


        Expanded(
          flex:2,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

              Expanded(
                flex:1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text("${ContestDetailModel.instance.getTeam1Name()}"),
                        new Text("${CreateTeamModel.instance.getTeamPlayerCount(ContestDetailModel.instance.getTeam1Name())}")
                      ],
                    ),
                    new SizedBox(width: 5.0,),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text("${ContestDetailModel.instance.getTeam2Name()}"),
                        new Text("${CreateTeamModel.instance.getTeamPlayerCount(ContestDetailModel.instance.getTeam2Name())}")
                      ],
                    )
                  ],
                ),
              ),

              Builder(
                builder: (context){
                  if(CreateTeamModel.instance.getChosenPlayerList.length != 11){
                    return Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: new OutlineButton(onPressed: (){
                          SnackBar snackbar = new SnackBar(content: new Text("Please select 11 players"),duration: Duration(seconds: 1),);
                          Scaffold.of(context).showSnackBar(snackbar);
                        },
                          borderSide: BorderSide(
                            color: Colors.green
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: new Text("Save Team"),
                        ),
                      ),
                    );
                  }else{
                    return Expanded(
                      flex:1,
                      child: new Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: new RaisedButton(onPressed: () async {
                          if(CreateTeamModel.instance.getActionType == 1 || CreateTeamModel.instance.getActionType == 2){
                            if(await  CreateTeamModel.instance.saveTeam(ContestDetailModel.instance.getMatchId(), ContestDetailModel.instance.getContestId(), (CreateTeamModel.instance.getTotalCreditOfTeam()).toString(),ContestModel.instance.getTeamOneName(),ContestModel.instance.getTeamTwoName()))
                            {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(SlideRightRoute(widget: ContestDetail()));
                              _showNotificaitonWithDefault();
                            }else{
                              SnackBar snackbar = new SnackBar(content: Text('Something went wrong.Try again'),duration: const Duration(seconds: 1),);
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          }else if(CreateTeamModel.instance.getActionType == 3){
                            if(await  CreateTeamModel.instance.updateTeam(ContestDetailModel.instance.getMatchId(), ContestDetailModel.instance.getContestId(), (CreateTeamModel.instance.getTotalCreditOfTeam()).toString(),ContestModel.instance.getTeamOneName(),ContestModel.instance.getTeamTwoName()))
                            {
                              Navigator.of(context).pop();
                            }else{
                              SnackBar snackbar = new SnackBar(content: Text('Something went wrong.Try again'),duration: const Duration(seconds: 1),);
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          }

                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)
                          ),
                          color: Colors.green,
                          child: new Text("Save Team",style: TextStyle(color:Colors.white),),
                        ),
                      ),
                    );
                  }
                },
              ),
              Expanded(
                flex:1,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("CREADIT"),
                    new Text("${100-CreateTeamModel.instance.getTotalCreditOfTeam()}")
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

