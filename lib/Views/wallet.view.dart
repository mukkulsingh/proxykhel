import 'package:flutter/material.dart';
import './../Constants/slideTransitions.dart';
import './../Views/addmoney.view.dart';
import './../Model/wallet.model.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            return new Text("Something went wrong${snapshot.error.toString()}");
                          else if(!snapshot.hasData)
                            return new Text('Error fetching balance');
                          else {
                            WalletModel.instance.setBalance(
                                snapshot.data.walletAmount);
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
                    new Text('-'),
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
                  onPressed: (){},
                  child: new Text('WITHDRAW',style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
