import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import 'package:proxykhel/Model/Withdraw.model.dart';
import 'package:proxykhel/Model/wallet.model.dart';

import 'MyProfile.view.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _amountController;
  static bool _invalidAmount;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _invalidAmount = false;
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final amount = TextField(
      onTap: (){
        setState(() {
          _invalidAmount = false;
        });
      },
      keyboardType: TextInputType.number,
      controller: _amountController,
      inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
      decoration: InputDecoration(
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: "Withdraw amount",
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: new Text("Withdraw",style: TextStyle(fontSize: 16.0,color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new SizedBox(height:20.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text("   Current balance",style: TextStyle(color: Colors.deepOrange,fontSize: 18.0),),
              FutureBuilder(
                future: WalletModel.instance.getWalletBalance(),
                builder: (context,snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                      return new Text("No internet");
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return new CircularProgressIndicator();
                    case ConnectionState.done:
                      if(snapshot.hasError){
                        return InkWell(
                          onTap: (){
                            setState(() {

                            });
                          },
                          child: Row(children: <Widget>[
                            Text("No internet  "),
                            Icon(Icons.refresh,color: Colors.deepOrange,),
                          ],),
                        );
                      }
                      else if(snapshot.hasData){
                        return new Text("₹ ${snapshot.data.walletAmount}   ",style: TextStyle(color: Colors.deepOrange,fontSize: 18.0));
                      }
                  }
//                  return new Text("₹ ${snapshot.data.walletAmount}   ",style: TextStyle(color: Colors.deepOrange,fontSize: 18.0));
                  return Text("No internet");
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:12.0),
            child: Divider(),
          ),
          SizedBox(height: 10.0,),
          Container(margin:EdgeInsets.symmetric(horizontal: 24.0),height:50.0,child: amount),
          _invalidAmount?new Container(margin: EdgeInsets.only(top: 2.0,left: 25.0),child: new Text("Invalid amount",style: TextStyle(fontSize: 12.0,color: Colors.red),),):new Container(),
          SizedBox(height: 10.0,),
          Container(
            margin:EdgeInsets.symmetric(horizontal: 24.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.deepOrange
                  ),
                  child: new Text("₹ 250",style: TextStyle(fontSize: 18.0,color: Colors.deepOrange),),
                  color: Colors.deepOrange,
                  onPressed: (){
                    _amountController.text = "250";

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                )
,
                OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.deepOrange
                  ),
                  child: new Text("₹ 500",style: TextStyle(fontSize: 18.0,color: Colors.deepOrange),),
                  color: Colors.deepOrange,
                  onPressed: (){
                    _amountController.text = "500";

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                )
,
                OutlineButton(
                  borderSide: BorderSide(
                    color: Colors.deepOrange
                  ),
                  child: new Text("₹ 1000",style: TextStyle(fontSize: 18.0,color: Colors.deepOrange),),
                  color: Colors.deepOrange,
                  onPressed: (){
                    _amountController.text = "1000";

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                )
              ],
            ),
          ),
          new SizedBox(height: 10.0,),
          new Center(
            child: Container(
              width: 120.0,
              child: new RaisedButton(
                onPressed: ()async{
                  if(_amountController.text == null || _amountController.text == ""){
                    setState(() {
                      _invalidAmount=true;
                    });
                  }
                  else if(int.parse(_amountController.text) < 250){
                    SnackBar snackbar = new SnackBar(content: Text("Amount should be greater than or eqaul to 250"));
                    _scaffoldKey.currentState.showSnackBar(snackbar);
                  }
                  else if(int.parse(_amountController.text) > double.parse(WalletModel.instance.getBalance())){
                    SnackBar snackbar = new SnackBar(content: Text("Amount should be greater than or eqaul to current balance"));
                    _scaffoldKey.currentState.showSnackBar(snackbar);
                  }
                  else if(await WithdrawModel.instance.chekcKyc()){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title:new Text("Withdraw Money"),
                            content: new Text("Amount will get transferred to your account within 2 days",style: TextStyle(fontSize:16.0,color: Colors.red),),
                            actions: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new FlatButton(
                                    onPressed: ()async{



                                      Navigator.pop(context);
                                      WithdrawModel.instance.setWithdrawAmount(_amountController.text);
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context){
                                            return SimpleDialog(
                                              children: <Widget>[
                                                new Row(
                                                  children: <Widget>[
                                                    new SizedBox(width:10.0),
                                                    new CircularProgressIndicator(),
                                                    new SizedBox(width:10.0),
                                                    new Text("Please wait..."),
                                                  ],
                                                )
                                              ],
                                            );
                                          }
                                      );
                                      if(await WithdrawModel.instance.withdraw()){
                                        showDialog(
                                            context: _scaffoldKey.currentContext,
                                            builder: (context){
                                              return AlertDialog(
                                                title: new Text("Transaction Successful",style: TextStyle(color: Colors.green),),
                                                content: new Text("Amount will get transeferred to your linked bank account withing 2 working days"),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: new Text("OK"))
                                                ],
                                              );
                                            }
                                        );

//                                        Future.delayed(Duration(seconds: 1),(){
//                                          Navigator.of(context).pop();
//                                          Navigator.of(context).pop();
//                                        });

                                      }else{
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return AlertDialog(
                                                title: new Text("Transaction Failed"),
                                                content: new Text(""),
                                              );
                                            }
                                        );
//                                        Future.delayed(Duration(seconds: 1),(){
//                                          Navigator.of(context).pop();
//                                          Navigator.of(context).pop();
//                                        });
                                      }
                                    },
                                    child: Text("Transfer Money to bank",style: TextStyle(color: Colors.white),),
                                    color: Colors.blueAccent,
                                  ),
                                  new SizedBox(width: 10.0,),
                                  new FlatButton(
                                      color:Colors.grey[400],
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel",style: TextStyle(color: Colors.white),)
                                  )

                                ],
                              )
                            ],
                          );
                        }
                    );
                  }
                  else{
                    SnackBar snackbar =new SnackBar(content: new Text("KYC not verified"),duration: Duration(seconds: 1),);
                    _scaffoldKey.currentState.showSnackBar(snackbar);
                    Future.delayed(Duration(seconds: 2),(){
                      Navigator.push(context, SlideLeftRoute(widget:MyProfile()));
                    });
                  }
                },
                child: new Text("Withdraw",style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),
                color: Colors.deepOrange,
              ),
            ),
          )
        ],
      ),
    );
  }
}
