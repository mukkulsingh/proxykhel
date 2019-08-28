import 'package:flutter/material.dart';
import './../Constants/slideTransitions.dart';
import './wallet.view.dart';
import './../Model/logout.model.dart';
import './login.view.dart';
import './profile.view.dart';
import './../Model/JoinedContestListModel.model.dart';

class JoinedContestList extends StatefulWidget {
  @override
  _JoinedContestListState createState() => _JoinedContestListState();
}

class _JoinedContestListState extends State<JoinedContestList> {

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


    return Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text('CONTEST DETAILS',style: TextStyle(fontSize: 16.0,color: Colors.white),),
          actions: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,SlideLeftRoute(widget: Wallet()));
              },
            ),
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
                }
                else if(value == 1){
                  Navigator.push(context,SlideLeftRoute(widget: Profile()));
                }
              } ,
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            new Expanded(
                flex:1,
                child: Container(
                  height: 65.0,
                  color: Color(0XFFc4301e),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      new Text('${JoinedContestListModel.instance.getTeam1}  VS  ${JoinedContestListModel.instance.getTeam2}',style: TextStyle(color: Colors.white),),
                      new Text('EXPIRED',style: TextStyle(color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: new Text('${JoinedContestListModel.instance.getMatchType??''}',style: TextStyle(color: Colors.white),)),
                      )
                    ],
                  )
                )
            ),
            new Expanded(
              flex:1,
              child: new Card(
                  child:ListTile(
                    title: Text("Player",style: TextStyle(color: Colors.deepOrange),),
                    trailing: new Icon(Icons.chevron_right,color: Colors.deepOrange,),
                    onTap: (){
                    },
                  )
                ),

            ),
            new Expanded(
                flex:7,
                child: new FutureBuilder(
                    future:JoinedContestListModel.instance.getJoinedContest(),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return new Center(child: new CircularProgressIndicator(),);
                          break;
                        case ConnectionState.done:
                          if(snapshot.hasError){
                            return new Center(child: new Text("Error fetching contests"),);
                          }else if(!snapshot.hasData){
                            return new Center(child: new Text("0 contests joined"),);
                          }else if(snapshot.hasData){
                            print(snapshot.data.data.length);
                            return new ListView.builder(
                                itemCount: snapshot.data.data.length,
                                itemBuilder: (context,index){
                                  return new Container(
                                    height: 100,
                                    child: new Card(
                                      child:new Column(
                                        children: <Widget>[
                                          LinearProgressIndicator(
                                            value:(int.parse(snapshot.data.data[index].totlaJoin) / int.parse(snapshot.data.data[index].maxTeam)),
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
                                                        new CircleAvatar(
                                                          radius: 10.0,
                                                          backgroundColor: Colors.deepOrange,
                                                          child: new Text('M',style: TextStyle(color:Colors.white,fontSize: 10),),
                                                        ),
                                                        new InkWell(
                                                            onTap: (){},
                                                            child:new Row(
                                                              children: <Widget>[
                                                                new Text('Winning'),
                                                                new Icon(Icons.arrow_drop_down),
                                                              ],
                                                            )
                                                        ),
                                                        new Text('Rs. '+snapshot.data.data[index].winnersAmt),
                                                      ],
                                                    ),
                                                  ),
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      new Text('Winners'),
                                                      new Text(snapshot.data.data[index].winner,style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top:18.0),
                                                        child: new Text(snapshot.data.data[index].totlaJoin+'/'+snapshot.data.data[index].maxTeam+' Joined',style: TextStyle(fontSize: 12.0),),
                                                      ),

                                                    ],
                                                  ),
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(margin: EdgeInsets.only(top: 10.0), child: new Text('Entry')),
                                                      Container(
                                                        margin: EdgeInsets.only(top :20.0,right: 8.0),
                                                        child: new Text(snapshot.data.data[index].entryfee),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),
                                          new Column(
                                            children: <Widget>[
                                              new Row(
                                                children: <Widget>[

                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ),
                                  );

                                });
                          }else{
                            new Center(child: Column(
                              children: <Widget>[
                                new Text("Something went wrong retry"),
                                new RaisedButton(onPressed: (){
                                  setState(() {

                                  });
                                },
                                  child: new Text("Retry",style: TextStyle(color: Colors.white),),
                                  color: Colors.deepOrange,

                                ),
                              ],
                            ),);
                          }
                      }

                    })),
          ],
        ),
    );
  }
}
