import 'package:flutter/material.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Add Money',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              margin:EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
              child:
              new Text('LOW BALANCE',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),),
            ),
            Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(margin:EdgeInsets.only(left: 20.0),child: new Text('Current balance',style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 18.0,),)),
                    Container(margin:EdgeInsets.only(right: 10.0),child: new Text('0 Rs.',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 16.0),)),
                  ],
                ),
              ],
            ),
            Divider(),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: 'Amount To Add',
                border: OutlineInputBorder()
            ),
            keyboardType: TextInputType.number,
          ),
        ),

            new Container(
              margin: EdgeInsets.symmetric(horizontal: 100.0),
              child: new RaisedButton(
                color: Colors.deepOrange,
                onPressed: (){},
                child: new Text('ADD MONEY',style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
