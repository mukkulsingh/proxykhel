import 'package:flutter/material.dart';
import 'package:proxykhel/Model/ViewTeam.model.dart';

class ViewTeamPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TEAM PREVIEW",style: TextStyle(fontSize: 16.0, color: Colors.white)),  iconTheme: IconThemeData(
        color: Colors.white,
      ),),
      body:ViewteamPoint(),
    );
  }
}

class ViewteamPoint extends StatefulWidget {
  @override
  _ViewteamPointState createState() => _ViewteamPointState();
}

class _ViewteamPointState extends State<ViewteamPoint> {

  static bool _isPageLoading;
  static bool _dataFound;
  ViewTeamDetails viewTeamDetails;

  Future loadViewTeamData()async{
    viewTeamDetails = await ViewTeamModel.instance.getViewTeam();
    if(viewTeamDetails != null){
      setState(() {
        _isPageLoading = false;
        _dataFound = true;
      });
    }else{
      setState(() {
        _isPageLoading = false;
        _dataFound = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isPageLoading = true;
    _dataFound = false;
    loadViewTeamData();
  }

  @override
  Widget build(BuildContext context) {

    if(_isPageLoading == true){
      return new Center(child: new CircularProgressIndicator(),);
    }
    else if(_isPageLoading == false && _dataFound == false){
      return new Center(child: new Column(
        children: <Widget>[
          new Text("Data not found"),
          new FlatButton(onPressed: ()async{loadViewTeamData();}, child: new Row(children: <Widget>[
            new Text("Retry"),
            new Icon(Icons.refresh),

          ],))
        ],
      ),);
    }

    else if(_isPageLoading == false && _dataFound == true){
      return Stack(
        children: <Widget>[

          new CustomPaint(
            painter: BackGround(),
            willChange: false,
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            child: new Container(),
          ),
          Align(
            child: Container(
              height:  MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 0.0),
                borderRadius: new BorderRadius.all(Radius.elliptical(150, 150)),
              ),
              child: Text('     '),
            ),
          ),
          new Center(
            child: new Container(
              child: CustomPaint(
                painter: Pitch(),
                willChange: false,
                size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                child: new Container(),
              ),
            ),
          ),
          new ListView(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  new Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text("Wicket Keeper"),
                        new CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          child: new Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Wicket-keepar.png"),),
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 2.0),
                          child: new Text("${viewTeamDetails.data.wk.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 2.0),
                          child: new Text("0.0",style: TextStyle(color: Colors.white),),
                        )

                      ],
                    ),
                  )
                ],
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new SizedBox(height: 30.0,),
                          new Text("Star Player"),
                          new CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            child: new Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Star-Player.png"),),
                          ),
                          new Container(
                            child: new Text("${viewTeamDetails.data.sp.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                          ),
                          new Container(
                            child: new Text("0.0",style: TextStyle(color: Colors.white),),
                          )

                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text("Batsman"),
                          new CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            child: new Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Batsman.png"),),
                          ),
                          new Container(
                            child: new Text("${viewTeamDetails.data.bt.playerName}",style: TextStyle(backgroundColor: Colors.white)),
                          ),
                          new Container(
                            child: new Text("0.0",style: TextStyle(color: Colors.white),),
                          ),

                        ],
                      ),
                    ),

                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new SizedBox(height: 30.0,),
                          new Text("X- Player"),
                          new CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            child: new Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/X-Player.png"),),
                          ),
                          new Container(
                            child: new Text("${viewTeamDetails.data.ss.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                          ),
                          new Container(
                            child: new Text("0.0",style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ),
                    )

                  ]
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Fantasy-Five.png"),),
                        ),
                        new Container(
                          child: new Text("${viewTeamDetails.data.p1.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                        ),
                        new Container(
                          child: new Text("0.0",style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new SizedBox(height: 30.0,),
                        new Text("Super Five"),
                        new CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Fantasy-Five.png"),),
                        ),
                        new Container(
                          child: new Text("${viewTeamDetails.data.p2.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                        ),
                        new Container(
                          child: new Text("0.0",style: TextStyle(color: Colors.white),),
                        )

                      ],
                    ),
                  ),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Fantasy-Five.png"),),
                        ),
                        new Container(
                          child: new Text("${viewTeamDetails.data.p3.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                        ),
                        new Container(
                          child: new Text("0.0",style: TextStyle(color: Colors.white),),
                        )

                      ],
                    ),
                  )

                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Fantasy-Five.png"),),
                        ),
                        new Container(
                          child: new Text("${viewTeamDetails.data.p4.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                        ),
                        new Container(
                          child: new Text("0.0",style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Fantasy-Five.png"),),
                        ),
                        new Container(
                          child: new Text("${viewTeamDetails.data.p5.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                        ),
                        new Container(
                          child: new Text("0.0",style: TextStyle(color: Colors.white),),
                        )

                      ],
                    ),
                  ),

                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new SizedBox(height: 30.0,),
                        new Text("Bowler"),
                        new CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/Bawler.png"),),
                        ),
                        new Container(
                          child: new Text("${viewTeamDetails.data.bw.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                        ),
                        new Container(
                          child: new Text("0.0",style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new SizedBox(height: 30.0,),
                        new Text("All Rounder"),
                        new CircleAvatar(

                          backgroundColor: Colors.deepOrange,
                          child: Image(image: NetworkImage("https://www.proxykhel.com/assets/image/icons-ground/All%20Rounder.png"),),
                        ),
                        new Container(
                          child: new Text("${viewTeamDetails.data.ar.playerName}",style: TextStyle(backgroundColor: Colors.white),),
                        ),
                        new Container(
                          child: new Text("0.0",style: TextStyle(color: Colors.white),),
                        )

                      ],
                    ),
                  ),

                ],
              )
            ],
          ),

        ],
      );

    }
    else{
      return new Center(child: new Column(
        children: <Widget>[
          new Text("Data not found"),
          new FlatButton(onPressed: ()async{loadViewTeamData();}, child: new Row(children: <Widget>[
            new Text("Retry"),
            new Icon(Icons.refresh),

          ],))
        ],
      ),);
    }

  }
}

class BackGround extends CustomPainter{
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.green;
    paint.strokeWidth = 80;
    paint.isAntiAlias = true;

    Paint paint2 = new Paint();
    paint2.color = Colors.lightGreen;
    paint2.strokeWidth = 80;
    paint2.isAntiAlias = true;

    canvas.drawLine(Offset(-40, 00), Offset(-40,size.height), paint2);
    canvas.drawLine(Offset(40, 00), Offset(40,size.height), paint);
    canvas.drawLine(Offset(120, 00), Offset(120,size.height), paint2);
    canvas.drawLine(Offset(200, 00), Offset(200,size.height), paint);
    canvas.drawLine(Offset(280, 00), Offset(280,size.height), paint2);
    canvas.drawLine(Offset(360, 00), Offset(360,size.height), paint);
    canvas.drawLine(Offset(440, 00), Offset(440,size.height), paint2);
    canvas.drawLine(Offset(520, 00), Offset(520,size.height), paint);
    canvas.drawLine(Offset(600, 00), Offset(600,size.height), paint2);
    canvas.drawLine(Offset(680, 00), Offset(680,size.height), paint);

  }
}

class Pitch extends CustomPainter{
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.brown[300];
    paint.strokeWidth = 60;
    paint.isAntiAlias = true;


    canvas.drawLine(Offset((size.width/2), (size.height/3.2)), Offset((size.width/2),(size.height/1.5)), paint);

  }
}
