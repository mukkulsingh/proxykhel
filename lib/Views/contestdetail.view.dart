import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:proxykhel/Model/CreateTeam.model.dart';
import 'package:proxykhel/Model/GetContestDetail.model.dart';
import 'package:proxykhel/Model/ViewTeam.model.dart';
import 'CreateTeamTemp.view.dart';
import 'MyProfile.view.dart';
import './../Views/wallet.view.dart';
import './bottomnavbar.view.dart';
import './../Constants/slideTransitions.dart';
import './../Model/logout.model.dart';
import './../Model/contestdetail.model.dart';
import './../Views/login.view.dart';
import './../Model/getalluserteam.model.dart';
import 'package:http/http.dart' as http;
import './../Model/savedpref.model.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'ViewTeam.view.dart';

class ContestDetail extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();

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
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'CONTEST DETAILS',
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
                child: new Text('Refer And Earn'),
              ),

              PopupMenuItem<int>(
                value: 2,
                child: new Text('Logout'),
              ),
            ],
            onSelected: (value) async {
              if (value == 2) {
                _showLogoutDialog('Warning', 'You sure you want to logout?');
              } else if (value == 1) {
                Navigator.push(context, SlideLeftRoute(widget: MyProfile()));
              }
              else if(value == 1){
                Navigator.push(context,SlideLeftRoute(widget: MyProfile()));
              }
            },
          )
        ],
      ),
      body: Contestdetail(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class Contestdetail extends StatefulWidget {
  @override
  _ContestdetailState createState() => _ContestdetailState();
}

class _ContestdetailState extends State<Contestdetail> {
  GetContestDetail _getContestDetail;
  GetAllUserTeamDetail _allUserTeamDetail;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();


  static bool _isPageLoading;
  static bool _joined;
  static bool _teamFound;
  static double _t;
  static String _contestFees;
  static String _contestCancel = '';
  static String _multipleEntry = '';
  static String _singleEntry = '';
  static String _opponent = '';
  static String _amountVaries = '';

  Future loadContestDetails() async {
    bool check = await getContestDetail();
    if(check){
      bool teamCheck = await getUserTeam();
      if(teamCheck){
        setState(() {
          _isPageLoading = false;
        });
      }else{
        _isPageLoading = true;
      }
    }
  }

  Future getContestDetail() async {
    _getContestDetail = await GetContestDetailModel.instance.getContestDetail();
    if (_getContestDetail != null) {
      if (_getContestDetail.data[0].entryfee == "0") {
        _contestFees = "free";
      } else {
        _contestFees = '₹ ${_getContestDetail.data[0].entryfee}';
      }

      if (_getContestDetail.data[0].multiEntry == "2") {
        _multipleEntry = "M";
      } else {
        _multipleEntry = null;
      }

      if (_getContestDetail.data[0].contestCancel == "4") {
        _contestCancel = "U";
      } else {
        _contestCancel = null;
      }

      if (_getContestDetail.data[0].singleEntry == "1") {
        _singleEntry = "S";
      } else {
        _singleEntry = null;
      }

      if (_getContestDetail.data[0].opponent == "5") {
        _opponent = "P";
      } else {
        _opponent = null;
      }

      if (_getContestDetail.data[0].winingAmtVary == "3") {
        _amountVaries = "C";
      } else {
        _amountVaries = null;
      }

      _t = (int.parse(_getContestDetail.data[0].totlaJoin) /
          int.parse(_getContestDetail.data[0].maxTeam));
      return true;
    }else return false;
  }

  Future getUserTeam() async {
    _allUserTeamDetail = await GetAllUserTeamModel.instance.getAllUserTeam();
    if (_allUserTeamDetail != null) {
      if (_allUserTeamDetail != false) {
        _teamFound = true;
        return true;
      } else if(_allUserTeamDetail == false){
        _teamFound = false;
        return true;
      }
    }else if(_allUserTeamDetail == null){
      _teamFound = false;
      return true;
    }
  }


  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
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
    await flutterLocalNotificationsPlugin.show(0, "Contest joined", "You have successfully joined contest", platformChannelSpecific);
  }


  @override
  void initState() {
    super.initState();
    _teamFound = false;
    _isPageLoading = true;
    _joined = false;
    loadContestDetails();
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


    if (_isPageLoading == true) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else if (_isPageLoading == false) {
      return RefreshIndicator(
        onRefresh: ()async{
          setState(() {
          });
        },
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 65.0,
                color: Color(0XFFc4301e),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(ContestDetailModel.instance.getTeam1Name(),
                              style: TextStyle(color: Colors.white)),
                          new Text(
                            ' vs ',
                            style: TextStyle(color: Colors.white),
                          ),
                          new Text(ContestDetailModel.instance.getTeam2Name(),
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    new Text(
                      ContestDetailModel.instance.getContestDuration(),
                      style: TextStyle(color: Colors.white),
                    ),
                    new Text(
                      ContestDetailModel.instance.getMatchType(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
//          Expanded(
//            flex:3,
//            child: new Container(
//              child: Card(
//                child: new Column(
//                  children: <Widget>[
//                    new LinearProgressIndicator(
//                      value: (int.parse(_getContestDetail.data[0].totlaJoin) / int.parse(_getContestDetail.data[0].maxTeam)),
//                      backgroundColor: Colors.grey[300],
//                    ),
//                    new Column(
//                      crossAxisAlignment: CrossAxisAlignment.stretch,
//                      children: <Widget>[
//                        new Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: new Column(
//                                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                children: <Widget>[
//                                  new CircleAvatar(
//                                    radius: 10.0,
//                                    backgroundColor: Colors.deepOrange,
//                                    child: new Text('M',style: TextStyle(color:Colors.white,fontSize: 10),),
//                                  ),
//                                  new InkWell(
////                                      onTap: _showDialog,
//                                      child:new Row(
//                                        children: <Widget>[
//                                          new Text('Winning',style: TextStyle(fontSize: 12.0),),
//                                          new Icon(Icons.arrow_drop_down,color: Colors.black,),
//                                        ],
//                                      )
//                                  ),
//                                  new Row(
//                                    children: <Widget>[
//                                      new Text('₹'),
//                                      new Text(contestData.entryfee),
//                                    ],
//                                  )
//                                ],
//                              ),
//                            ),
//                            new Column(
//                              children: <Widget>[
//                                new Text(''),
//                                new Text('Winners',style: TextStyle(fontSize: 12.0),),
//                                new Text(contestData.winner??'0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),),
//                                new Text(''),
//                                new Text(contestData.totlaJoin+'/'+contestData.maxTeam+' Joined',style: TextStyle(fontSize: 12.0),),
//                                new Text(''),
//                              ],
//                            ),
//                            new Column(
//                              mainAxisAlignment: MainAxisAlignment  .center,
//                              children: <Widget>[
//                                new Text('Entry ₹ ${contestData.entryfee} '),
//                                Container(
//                                  height: 30.0,
//                                  width: 85,
//                                  margin: EdgeInsets.all(8.0),
//                                  child: new FlatButton(onPressed: (){
//                                    CreateTeamModel.instance.setActionType(1);
//                                    Navigator.push(context, SlideLeftRoute(widget:CreateTeamTemp()));
//                                  },
//                                    color: Colors.deepOrange,
//                                    shape: RoundedRectangleBorder(
//                                        borderRadius: BorderRadius.circular(32.0)
//                                    ),
//                                    child: Text('CREATE TEAM',style: TextStyle(color: Colors.white,fontSize: 8.0),),
//
//                                  ),
//                                ),
//                              ],
//                            ),
//
//                          ],
//                        )
//                      ],
//                    ),
//
//                  ],
//
//                ),
//              ),
//            ),
//          ),
            Expanded(
              flex: 4,
              child: new Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: InkWell(
                  child: new Card(
                    child: new Column(
                      children: <Widget>[
                        LinearProgressIndicator(
                          value: _t,
                          backgroundColor: Colors.grey[300],
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Builder(builder: (context) {
                                            if (_singleEntry != null) {
                                              return new Container(
                                                child: new CircleAvatar(
                                                  backgroundColor:
                                                      Colors.deepOrange,
                                                  child: new Text(_singleEntry,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0)),
                                                  radius: 8.0,
                                                ),
                                              );
                                            } else
                                              return new Container();
                                          }),
                                          SizedBox(
                                            width: 2.0,
                                          ),
                                          Builder(builder: (context) {
                                            if (_multipleEntry != null) {
                                              return new Container(
                                                child: new CircleAvatar(
                                                  backgroundColor:
                                                      Colors.deepOrange,
                                                  child: new Text(
                                                    _multipleEntry,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0),
                                                  ),
                                                  radius: 8.0,
                                                ),
                                              );
                                            } else
                                              return new Container();
                                          }),
                                          SizedBox(
                                            width: 2.0,
                                          ),
                                          Builder(builder: (context) {
                                            if (_opponent != null) {
                                              return new Container(
                                                child: new CircleAvatar(
                                                  backgroundColor:
                                                      Colors.deepOrange,
                                                  child: new Text(_opponent,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0)),
                                                  radius: 8.0,
                                                ),
                                              );
                                            } else
                                              return new Container();
                                          }),
                                          SizedBox(
                                            width: 2.0,
                                          ),
                                          Builder(builder: (context) {
                                            if (_contestCancel != null) {
                                              return new Container(
                                                child: new CircleAvatar(
                                                  backgroundColor:
                                                      Colors.deepOrange,
                                                  child: new Text(_contestCancel,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0)),
                                                  radius: 8.0,
                                                ),
                                              );
                                            } else
                                              return new Container();
                                          }),
                                          SizedBox(
                                            width: 2.0,
                                          ),
                                          Builder(builder: (context) {
                                            if (_amountVaries != null) {
                                              return new Container(
                                                child: new CircleAvatar(
                                                  backgroundColor:
                                                      Colors.deepOrange,
                                                  child: new Text(_amountVaries,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0)),
                                                  radius: 8.0,
                                                ),
                                              );
                                            } else
                                              return new Container();
                                          }),
                                        ],
                                      ),
                                      new InkWell(
//                                              onTap: _showDialogWinningBreakdown,
                                          onTap: () {
                                            List tileList = [];
                                            int itemCount = 0,
                                                singleDistribution = 0,
                                                rangeDistribution = 0;
                                            if (_getContestDetail
                                                    .data[0].singleDistrubution !=
                                                false) {
                                              singleDistribution =
                                                  _getContestDetail.data[0]
                                                      .singleDistrubution.length;
//                                              singleDistribution = 1;
                                              tileList.add({
                                                "name": "Single Distribution"
                                              });
                                            }
                                            if (_getContestDetail
                                                    .data[0].rangeDistrubution !=
                                                false) {
                                              rangeDistribution =
                                                  _getContestDetail.data[0]
                                                      .rangeDistrubution.length;
//                                                rangeDistribution =1;
                                              tileList.add(
                                                  {"name": "Range Distribution"});
                                            }
                                            itemCount = singleDistribution +
                                                rangeDistribution;

                                            showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                        title: new Text(
                                                            "Winning Breakdown"),
                                                        content: ListView(
                                                          shrinkWrap: true,
                                                          children: <Widget>[
                                                            new ListView.builder(
                                                                shrinkWrap: true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    singleDistribution,
                                                                itemBuilder:
                                                                    (context,
                                                                        index2) {
                                                                  return new Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                10.0),
                                                                    child:
                                                                        new Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        new Text(
                                                                            "Rank ${_getContestDetail.data[0].singleDistrubution[index2]['rank']}"),
                                                                        Text(
                                                                            "₹ ${_getContestDetail.data[0].singleDistrubution[index2]['winamt']}"),
                                                                      ],
                                                                    ),
                                                                  );
//
                                                                }),
                                                            new ListView.builder(
                                                                shrinkWrap: true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    rangeDistribution,
                                                                itemBuilder:
                                                                    (context,
                                                                        index3) {
                                                                  double winper = ((double.tryParse(_getContestDetail
                                                                              .data[0]
                                                                              .rangeDistrubution[index3]
                                                                          [
                                                                          'winamt'])) /
                                                                      ((double.parse(_getContestDetail.data[0].rangeDistrubution[index3]['lastrange']) +
                                                                              1) -
                                                                          double.parse(_getContestDetail
                                                                              .data[0]
                                                                              .rangeDistrubution[index3]['firstrange'])));
                                                                  return new Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                10.0),
                                                                    child:
                                                                        new Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        new Text(
                                                                            "Rank ${_getContestDetail.data[0].rangeDistrubution[index3]['firstrange']} - ${_getContestDetail.data[0].rangeDistrubution[index3]['lastrange']}"),
                                                                        Text(
                                                                            "₹ ${winper.toString()}"
//                                                                   "₹ ${snapshot.data.data[index].rangeDistrubution[index3]['winper']}"
                                                                            ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                })
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          new OutlineButton(
                                                            color:
                                                                Colors.deepOrange,
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .deepOrange),
                                                            child: new Text(
                                                                "Got It!"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ]));
                                          },
                                          child: new Row(
                                            children: <Widget>[
                                              new Text('Winning'),
                                              new Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
                                            ],
                                          )),
                                      new Text('Rs. ' +
                                          _getContestDetail.data[0].winnersAmt),
                                    ],
                                  ),
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('Winners'),
                                    new Text(
                                      _getContestDetail.data[0].winner,
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18.0),
                                      child: new Text(
                                        _getContestDetail.data[0].totlaJoin +
                                            '/' +
                                            _getContestDetail.data[0].maxTeam +
                                            ' Joined',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
//                                  Container(
//                                      margin: EdgeInsets.only(top: 10.0),
//                                      child: new Text('Entry')),
                                    Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: new Text(_contestFees)),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20.0, right: 8.0),
                                      child: new FlatButton(
                                        onPressed: () {
                                          CreateTeamModel.instance.setActionType(1);
                                          Navigator.push(context, SlideLeftRoute(widget:CreateTeamTemp()));
                                        },
                                        color: Colors.deepOrange,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        child: Text(
                                          "Create team",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex:2,
              child: new Container(
                margin: EdgeInsets.only(top: 5.0),
                child: new Column(
                  children: <Widget>[
                    new Text('OR JOIN WITH SAVED TEAM',textAlign: TextAlign.start,style: TextStyle(fontSize:12.0,color: Colors.deepOrange),),
                    Divider(),
                  ],
                ),
              ),
            ),
            Expanded(
                    flex: 11,
                    child: _teamFound?ListView.builder(
                        itemCount: _allUserTeamDetail.data.length,
                        itemBuilder: (context,index){
                      return new Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height:40,
                            child: new Card(
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.only(top:12.0,left: 12.0),
                                child: new Text('${_allUserTeamDetail.data[index].teamname}',style: TextStyle(fontSize: 18.0),),
                              ),
                            ),
                          ),
                          new Container(
                            height: 80.0,
                            child: new Card(
                              margin: EdgeInsets.zero,
                              child:new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex:1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(padding:EdgeInsets.only(left:18.0),child: new Text('X Player',style: TextStyle(color: Colors.grey,fontSize:16.0),)),
                                            Padding(
                                              padding: const EdgeInsets.only(left:18.0),
                                              child: new Text('${_allUserTeamDetail.data[index].starplayer}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Text('WK',style: TextStyle(fontSize: 10),),
                                            new Text('1',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Text('BWL',style:TextStyle(fontSize: 10),),
                                            new Text('${_allUserTeamDetail.data[index].bowlcount}',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Text('ALLR',style:TextStyle(fontSize: 10),),
                                            new Text('${_allUserTeamDetail.data[index].allcount}',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Text('BAT',style:TextStyle(fontSize: 10),),
                                            new Text('${_allUserTeamDetail.data[index].batcount}',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        Container(
                                          height: 30.0,
                                          width: 60.0,
                                          child: new FlatButton(onPressed: () async {
                                            if(_allUserTeamDetail.data[index].joined == 1){
                                              SnackBar snackbar = new SnackBar(content: Text("Already joined witht this team"),duration: Duration(seconds: 1),);
                                              Scaffold.of(context).showSnackBar(snackbar);
                                            }else{
                                              String userId = await SavedPref.instance.getUserId();
                                              http.Response response  = await http.post("https://www.proxykhel.com/android/contest.php",body:{
                                                "type":"joinUserTeam",
                                                "matchId":ContestDetailModel.instance.getMatchId(),
                                                "contestId":ContestDetailModel.instance.getContestId(),
                                                "userId":userId,
                                                "squadId":_allUserTeamDetail.data[index].id,
                                                "contestAmt":_contestFees,
                                                "team_1_name":ContestDetailModel.instance.getTeam1Name(),
                                                "team_2_name":ContestDetailModel.instance.getTeam2Name(),
                                                "matchType":ContestDetailModel.instance.getMatchType(),
                                                "matchtime":ContestDetailModel.instance.getContestDuration(),
                                              });
                                              if(response.statusCode == 200){

                                                final res = json.decode(response.body);
                                                if(res['data'] == 1){
                                                  SnackBar snackbar = new SnackBar(content: Text("Contest joined"),duration: Duration(seconds: 1),);
                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                  setState(() {
                                                    loadContestDetails();
                                                    _showNotificaitonWithDefault();
                                                  });
                                                }
                                                else if(res['data'] == 'not enough money'){
                                                  SnackBar snackbar = new SnackBar(content: Text("Insufficient wallet amount"),duration: Duration(seconds: 1),);
                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                }
                                                else if(res['data'] == 'swap'){
                                                  SnackBar snackbar = new SnackBar(content: Text("Team swapped"),duration: Duration(seconds: 1),);
                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                }else{
                                                  SnackBar snackbar = new SnackBar(content: Text("Already joined"),duration: Duration(seconds: 1),);
                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                }
                                                Future.delayed(Duration(seconds: 1),(){

                                                });
                                              }
                                              else{
                                                SnackBar snackbar = new SnackBar(content: Text("Already joined"));
                                                Scaffold.of(context).showSnackBar(snackbar);
                                              }
                                            }
                                          }, child: _allUserTeamDetail.data[index].joined?new Text("Joined",style: TextStyle(color:Colors.white,fontSize: 8.0),):new Text("Join",style: TextStyle(color:Colors.white,fontSize: 8.0),),
                                            color: _allUserTeamDetail.data[index].joined?Colors.deepOrangeAccent[100]:Colors.deepOrange,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(32.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Container(
                            height: 60.0,
                            child: new Card(
                              margin: EdgeInsets.zero,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('Star Player',style: TextStyle(color: Colors.grey,fontSize:16.0),),
                                        Padding(
                                          padding: const EdgeInsets.only(left:18.0),
                                          child: new Text('${_allUserTeamDetail.data[index].xplayer}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[

                                        InkWell(
                                          onTap:(){
                                            CreateTeamModel.instance.setActionType(3);
                                            CreateTeamModel.instance.setTeamId(_allUserTeamDetail.data[index].id);
                                            Navigator.push(context, SlideLeftRoute(widget:CreateTeamTemp()));
                                          },
                                          child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Icon(Icons.edit,color: Colors.black,),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              new Text('EDIT',style: TextStyle(fontSize: 12.0),)
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        InkWell(
                                          onTap:(){
                                            CreateTeamModel.instance.setActionType(2);
                                            CreateTeamModel.instance.setTeamId(_allUserTeamDetail.data[index].id);
                                            Navigator.push(context, SlideLeftRoute(widget:CreateTeamTemp()));
                                          },
                                          child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Icon(Icons.content_copy,color: Colors.black,),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              new Text('CLONE',style: TextStyle(fontSize: 12.0),)
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        InkWell(
                                          onTap:(){
                                            ViewTeamModel.instance.setTeamId(_allUserTeamDetail.data[index].id);
                                            Navigator.push(context,SlideLeftRoute(widget: ViewTeam()));
                                          },
                                          child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Icon(Icons.remove_red_eye,color: Colors.black,),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              new Text('VIEW',style: TextStyle(fontSize: 12.0),)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
//
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    }):new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Text("Please create a team"),
                        new SizedBox(height: 2.0),
//                      InkWell(
//                        onTap: () {
//                          setState(() {});
//                        },
//                        child: new Row(
//                          mainAxisSize: MainAxisSize.min,
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            new Text("Retry",
//                                style: TextStyle(
//                                    color: Colors.deepOrange, fontSize: 16.0)),
//                            SizedBox(width: 5.0),
//                            Icon(
//                              Icons.refresh,
//                              color: Colors.deepOrange,
//                            )
//                          ],
//                        ),
//                      )
                      ],
                    ),
                  ),
          ],
        ),
      );
    }
  }
}
