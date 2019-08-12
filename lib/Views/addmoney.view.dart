import 'package:flutter/material.dart';
import './../Model/wallet.model.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {


  static int _amountToAdd;
  static bool _isLowBalance;

  TextEditingController _amountController;
  static bool _amountToAddError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _amountToAdd=0;
    _amountController = TextEditingController();
    _amountToAddError = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amountController.dispose();
  }

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
        new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(margin:EdgeInsets.only(left: 20.0),child: new Text('Current balance',style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 18.0,),)),
                Container(margin:EdgeInsets.only(right: 10.0),child: new Text(WalletModel.instance.getBalance(),style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 16.0),)),
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
                border: OutlineInputBorder(),
              errorText: _amountToAddError ? "Invalid Amount":null,
            ),
            onChanged: (value){
              if(value != '') {
                _amountToAdd = int.parse(value);
                setState(() {
                  _amountToAddError = false;
                });
              }
              else
              setState(() {
                _amountToAddError = true;
              });
            },
            keyboardType: TextInputType.number,
          ),
        ),

            new Container(
              height: 45.0,
              margin: EdgeInsets.symmetric(horizontal: 100.0),
              child: new RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                color: Colors.deepOrange,
                onPressed: (){
                  if(_amountToAdd == 0 || _amountToAdd == null || _amountToAdd == ''){
                    setState(() {
                      _amountToAddError = true;
                    });
                  }else{
                    WalletModel.instance.startPayment(_amountToAdd);
                  }
                },
                child: new Text('ADD MONEY',style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
