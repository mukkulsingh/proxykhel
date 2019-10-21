import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proxykhel/Model/Transactions.model.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:new Text("All transactions",style: TextStyle(color: Colors.white,fontSize: 16.0),),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.orange[200],
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(flex:1,child: new Text("Date",textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)),
                  Expanded(flex:1,child: new Text("Transaction ID",textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold))),
                  Expanded(flex:1,child: new Text("Amount",textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),
          Expanded(
            flex:10,
            child: FutureBuilder(
              future: TransactionsModel.instance.getTransactions(),
              builder: (context,snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                    return new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Text("Please check your internet connection"),
                        InkWell(
                          onTap: (){
                            setState(() {

                            });
                          },
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Retry",style: TextStyle(color: Colors.deepOrange,fontSize: 12.0),),
                              new Icon(Icons.refresh)
                            ],
                          ),
                        )
                      ],);
                    break;
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return new Center(child: new CircularProgressIndicator(),);
                  case ConnectionState.done:
                    if(snapshot.hasError){
                      return new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text("Error fetching transactions"),
                          InkWell(
                            onTap: (){
                              setState(() {

                              });
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("Retry",style: TextStyle(color: Colors.deepOrange,fontSize: 12.0),),
                                new Icon(Icons.refresh)
                              ],
                            ),
                          )
                        ],);
                    }else if(!snapshot.hasData){
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text("Zero transactions"),
                          InkWell(
                            onTap: (){
                              setState(() {

                              });
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("Retry",style: TextStyle(color: Colors.deepOrange,fontSize: 12.0),),
                                new Icon(Icons.refresh)
                              ],
                            ),
                          )
                        ],);
                    }else if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context,index){
                            Color color = Color(0xffb7e897);
                            if(snapshot.data.data[index].action == "pending"){
                              color = Color(0xffd98f8f);
                            }
                            return Container(
                              height: 50.0,
                              color: color,
                              margin: EdgeInsets.only(top: 0.0),
                              child: Column(
                                children: <Widget>[
                                  new Container(
                                    margin:EdgeInsets.only(top:5.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex:1,
                                          child: Column(
                                            children: <Widget>[
                                            new Text("${snapshot.data.data[index].created.day}-${snapshot.data.data[index].created.month}-${snapshot.data.data[index].created.year}")
                                          ],),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              new Text("Txn#${snapshot.data.data[index].id}"),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Column(
                                            children: <Widget>[
                                              new Text("₹ ${snapshot.data.data[index].transaction}"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                }
                return new Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
