import 'package:flutter/material.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import 'package:proxykhel/Model/PlayerPointModel.model.dart';
import 'PlayerPoint.view.dart';

class GeneralPoints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('General Point',style: TextStyle(fontSize: 16.0,color: Colors.white),),
      ),
      body: GeneralPointsView(),
    );
  }
}

class GeneralPointsView extends StatefulWidget {
  @override
  _GeneralPointsViewState createState() => _GeneralPointsViewState();
}

class _GeneralPointsViewState extends State<GeneralPointsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView (
        children: <Widget>[
          Container(
              margin:EdgeInsets.only(top:10,bottom: 10.0,left:5.0),
              child: new Text("General Points",style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,

              ),)),
          Container(
            color: Colors.grey[200],
            height: 45.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Player",
                    style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),
                ),
                new Text("Points",
                    style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold)
                )
              ],
            ),
          ),
          new FutureBuilder(
          future: PlayerPointModel.instance.getPlayerPoint(),
            builder: (context,snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator(),);
              case ConnectionState.done:
                if(snapshot.hasError){
                  return new Center(
                    child: new Column(
                      children: <Widget>[
                        new Text("Error fetching data${snapshot.error}"),
                        new OutlineButton(onPressed: (){
                          setState(() {

                          });
                        },
                          child: new Text("Retry",style: TextStyle(color: Colors.deepOrange),),
                          borderSide: BorderSide(
                            color: Colors.deepOrange
                          ),
                        )
                      ],
                    ),
                  );
                }
                if(!snapshot.hasData){
                  return new Center(
                    child: new Column(
                      children: <Widget>[
                        new Text("Data not found"),
                        new OutlineButton(onPressed: (){
                          setState(() {

                          });
                        },
                          child: new Text("Retry",style: TextStyle(color: Colors.deepOrange),),
                          borderSide: BorderSide(
                              color: Colors.deepOrange
                          ),
                        )
                      ],
                    ),
                  );

                }
                if(snapshot.hasData){
                  if(snapshot.data == null){
                    return new Center(
                      child: new Column(
                        children: <Widget>[
                          new Text("Data not found"),
                          new OutlineButton(onPressed: (){
                            setState(() {

                            });
                          },
                            child: new Text("Retry",style: TextStyle(color: Colors.deepOrange),),
                            borderSide: BorderSide(
                                color: Colors.deepOrange
                            ),
                          )
                        ],
                      ),
                    );

                  }else{
                    return new ListView.builder(
                      shrinkWrap: true,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              PlayerPointModel.instance.setName(snapshot.data.data[index].name);
                              PlayerPointModel.instance.setPlayerPoint(snapshot.data.data[index].playerpoint);
                              PlayerPointModel.instance.setPerRun(snapshot.data.data[index].perRun);
                              PlayerPointModel.instance.setPerSix(snapshot.data.data[index].perSix);
                              PlayerPointModel.instance.setPerWicket(snapshot.data.data[index].perWicket);
                              PlayerPointModel.instance.setPerDotBall(snapshot.data.data[index].perDotBall);
                              Navigator.push(context,SlideLeftRoute(widget: PlayerPoint()));
                            },
                            child: new Container(
//                              margin: EdgeInsets.symmetric(horizontal: 24.0),
                              height: 40.0,
                              child: new Card(
                                child:new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text("                  ${snapshot.data.data[index].name}",style: TextStyle(fontSize: 12.0),textAlign: TextAlign.start,),
                                    new Text("${snapshot.data.data[index].playerpoint}                     ",textAlign: TextAlign.start),

                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }

                }
            }
              return new Container();
            },
      ),
        ],
      ),
    );
  }
}

