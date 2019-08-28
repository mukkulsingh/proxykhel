import 'package:flutter/material.dart';
import './../Constants//theme.dart' as Theme;
import './../Model/Notification.model.dart';
import './bottomnavbar.view.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
          body: new RefreshIndicator(
              onRefresh:(){
                setState(() {

                });
              },
            child: new FutureBuilder(
                future: NotificationModel.instance.getNotifications(),
                builder: (context,snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return new Center(child: new CircularProgressIndicator(),);
                      break;
                    case ConnectionState.done:
                      if(snapshot.hasError){
                        return new Center(child: new Text("Error fetching notification"),);
                      }
                      else if(!snapshot.hasData){
                        return new Center(child: new Text("0 Notifications"),);
                      }else if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data.notif.length,
                            itemBuilder: (context, index){
                              return Column(
                                children: <Widget>[
                                  SizedBox(height: 10.0,),
                                  new Container(
                                    height: 100.0,
                                    width: double.infinity,
                                    child: new Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                            child: Container(
                                              margin: EdgeInsets.only(left: 2.0),
                                              height: double.infinity,
                                                width: double.infinity,
                                                color:Colors.red,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top:18.0),
                                                  child: new Text(snapshot.data.notif[index].title,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                                )),
                                          ),
                                        ),

                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:28.0),
                                            child: new Text(snapshot.data.notif[index].description),
                                          ),
                                        ),

                                      ],
                                    ),

                                  ),
                                  Divider(),
                                  SizedBox(height: 10.0,),
                                ],
                              );

                            });
                      }
                  }
                }),
          ),

          bottomNavigationBar:BottomNavBar()

      ),
    );
  }
}
