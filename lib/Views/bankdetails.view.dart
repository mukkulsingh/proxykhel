import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BankDetails extends StatefulWidget {
  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {

  static String _holderName;
  static String _ifsc;
  static String _accountNo;

  static bool _isLoading;
  static bool _holderNameError;
  static bool _ifscError;
  static bool _accountNoError;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _holderNameError = false;
    _ifscError = false;
    _accountNoError = false;
  }

  @override
  Widget build(BuildContext context) {

    final holderName = new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Account holder name",
          errorText: _holderNameError ? "Invalid name":"",
        ),
        onChanged: (value){
          _holderName = value;
          setState(() {
            _holderNameError = false;
          });
        },
      ),
    );


    final ifscCode = new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "IFSC Code",
          errorText: _ifscError?"Invalid input":"",
        ),
        onChanged: (value){
          _ifsc = value;
          setState(() {
            _ifscError = false;
          });
        },
      ),
    );

    final accountNum = new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Account No.",
          errorText: _accountNoError?"Invalid account":"",
        ),
        onChanged: (value){
          _accountNo = value;
          setState(() {
            _accountNoError = false;
          });
        },
      ),
    );

    final submitButton = new Container(
      height: 45.0,
      margin: EdgeInsets.symmetric(horizontal: 60.0),
      child: new RaisedButton(
        onPressed: ()async{
          if(_holderName == '' || _holderName == null){
            setState(() {
              _holderNameError = true;
            });
          }
          else if(_accountNo == '' || _accountNo == null){
            setState(() {
              _accountNoError = true;
            });
          }
          else if(_ifsc == '' || _ifsc == null ){
            _ifscError = true;
          }
          else{
            setState(() {
              _isLoading = true;
            });

            http.Response response = await http.post("",body: {
              "type":"updateBankAccount",
              "holderName":_holderName,
              "accountNo":_accountNo,
              "ifsc":_ifsc
            });
            if(response.statusCode == 200){
              final res = json.decode(response.body);
                  if(res['success']==true){
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop(true);
                          });
                          return AlertDialog(
                            title: Text('Success',style: TextStyle(color: Colors.green,fontSize: 22.0),),
                            content: Row(
                              children: <Widget>[
                                Text('Account details updated',style: TextStyle(fontSize: 18.0),),
                                Icon(Icons.check_circle,color:Colors.green,size: 16.0,)
                              ],
                            ),
                          );
                        });
                  }
            else{
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop(true);
                          });
                          return AlertDialog(
                            title: Text('Error',style: TextStyle(color: Colors.red,fontSize: 22.0),),
                            content: Row(
                              children: <Widget>[
                                Text('Error updating account detail.Try again.',style: TextStyle(fontSize: 18.0),),
                                Icon(Icons.error,color:Colors.red,size: 24.0,)
                              ],
                            ),
                          );
                        });
                  }
            }
            else{
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      title: Text('Error',style: TextStyle(color: Colors.red,fontSize: 22.0),),
                      content: Row(
                        children: <Widget>[
                          Text('Error updating account detail.Try again.',style: TextStyle(fontSize: 18.0),),
                          Icon(Icons.error,color:Colors.red,size: 24.0,)
                        ],
                      ),
                    );
                  });
            }
          }
        },
        child: new Text("SUBMIT",style: TextStyle(color: Colors.white),),
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text('Bank Details',style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: <Widget>[
          new SizedBox(
            height: 20.0,
          ),
          holderName,
          new SizedBox(height: 20.0,),
          accountNum,
          new SizedBox(height: 20.0,),
          ifscCode,
          new SizedBox(height: 20.0,),
          new Stack(
            children: <Widget>[
              _isLoading ? new Center(child: new CircularProgressIndicator(),):submitButton
            ],
          ),
        ],
      ),
    );
  }
}
