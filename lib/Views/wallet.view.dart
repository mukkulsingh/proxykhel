import 'package:flutter/material.dart';
import 'package:proxykhel/Views/Transactions.view.dart';
import './../Constants/slideTransitions.dart';
import './../Views/addmoney.view.dart';
import './../Model/wallet.model.dart';
import 'AddMoney.view.dart';
import 'Withdraw.view.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  final GlobalKey<ScaffoldState> _scadffoldKey = new GlobalKey<ScaffoldState>();
  static String bonus="0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scadffoldKey,
      appBar: new AppBar(
        title: Text('Wallet',style: TextStyle(fontSize: 16.0,color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin:EdgeInsets.only(top: 20.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FutureBuilder(
                    future: WalletModel.instance.getWalletBalance(),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                          return new Stack(children: <Widget>[new Center(child: new CircularProgressIndicator(),)],);
                          break;
                        case ConnectionState.active:
                          return new Stack(children: <Widget>[new Center(child: new CircularProgressIndicator(),)],);
                          break;
                        case ConnectionState.waiting:
                          return new Stack(children: <Widget>[new Center(child: new CircularProgressIndicator(),)],);
                          break;
                        case ConnectionState.done:
                          if(snapshot.hasError)
                            return new Text("No internet");
                          else if(!snapshot.hasData)
                            return new Text('Error fetching balance');
                          else {
                            WalletModel.instance.setBalance(
                                snapshot.data.walletAmount);
                            WalletModel.instance.setBonusAmount(snapshot.data.bonus);
                            return new RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: "Total ",
                                        style: TextStyle(color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0)),
                                    TextSpan(text: snapshot.data.walletAmount,
                                        style: TextStyle(color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0))
                                  ]
                              ),
                            );
                          }
                      }
                      return new Container();
                    },
                  ),
                  new RaisedButton(
                    color: Colors.deepOrange,
                      onPressed: (){
                      Navigator.push(context,SlideLeftRoute(widget: AddMoney()));
                      },
                      child: new Text('ADD MONEY',style: TextStyle(color: Colors.white),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                  ),
                ],
              ),
            ),
            Divider(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text('Winnings'),
                    new Text('-'),
                  ],
                ),
                new Column(
                  children: <Widget>[
                    new Text('Deposited'),
                    new Text('-'),
                  ],
                ),
                new Column(
                  children: <Widget>[
                    new Text('Bonus'),
                    FutureBuilder(
                      future: WalletModel.instance.getWalletBalance(),
                      builder: (context, snapshot){
                      if(snapshot.connectionState != ConnectionState.done){
                        return new Center(child: Container(height:10.0,width:10.0,child: new CircularProgressIndicator()),);
                      }else
                        return new Text("${snapshot.data.bonus}");
                      },
                    ),
                  ],
                ),
              ],

            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 100.0),
              child: SizedBox(
                width: 100,
                child: new RaisedButton(
                  color: Colors.deepOrange,
                  onPressed: (){
                    Navigator.push(context, SlideLeftRoute(widget: Withdraw()));
                  },
                  child: new Text('WITHDRAW',style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              child: OutlineButton(
                child: Text("Show transactions",style: TextStyle(color: Colors.deepOrange),),
                onPressed: (){
                  Navigator.push(context, SlideLeftRoute(widget: Transactions()));
                },
                borderSide: BorderSide(
                  color: Colors.deepOrange,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
