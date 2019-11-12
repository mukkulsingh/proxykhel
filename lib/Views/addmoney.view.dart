import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proxykhel/Model/AddMoneyWallet.model.dart';
import './../Model/wallet.model.dart';
import 'package:paytm_payments/paytm_payments.dart';
import './../Model/savedpref.model.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';
class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {

  static bool _isLoading;

  static bool _transactionSuccess;

  static bool _internet;
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  void setResponseListener(){

    // setting a listener on payment response
    PaytmPayments.responseStream.listen((Map<dynamic, dynamic> responseData){

      /*
      * {RESPMSG : [MSG]} // this is the type of map object received, except for one case.
      *
      * In this unique case, Transaction Response is received of the format:
      * {CURRENCY: INR, ORDERID: 1557210948833, STATUS: TXN_FAILURE, BANKTXNID: , RESPMSG: Invalid checksum, MID: rxazcv89315285244163, RESPCODE: 330, TXNAMOUNT: 10.00}
      *
      * Call any method here to handle payment process on receiving response. According to the response received.
      * handleResponse();
      *
      * */
      handleResponse(responseData);

    });
  }



  static String _amountToAdd;
  static bool _isLowBalance;

  TextEditingController _amountController;
  static bool _amountToAddError;

  Future checkinternet() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _internet = false;
    }
    else{
      setState(() {
        _internet = true;
      });
    }
  }

  void handleResponse(Map<dynamic, dynamic> responseData)async {
    if(responseData["STATUS"] == "TXN_SUCCESS"){
      AddMoneyWalletModel.instance.setBalance(_amountToAdd);
      if(await AddMoneyWalletModel.instance.addBalance()){
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Success",style: TextStyle(color: Colors.green),),
                content: Text("Transaction successfull"),
                actions: <Widget>[
                  OutlineButton(
                    borderSide: BorderSide(
                        color: Colors.deepOrange
                    ),
                    child: new Text("OK",style: TextStyle(color: Colors.deepOrange),),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
        );
      }

    }else if(responseData["STATUS"] == "TXN_FAILURE"){
      showDialog(context: _scaffoldKey.currentContext,
          builder: (context){
            return AlertDialog(
              title: new Text("Error"),
              content: new Text("Error adding money"),
              actions: <Widget>[
                new FlatButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  setState(() {

                  });
                }, child: new Text("OK"))
              ],
            );
          }
      );
    }else{
      Navigator.pop(context);
    }
  }
  void openCheckout(String amount) async {
    String newAmount = amount + "00";
    var options = {
      'key': 'rzp_live_qBuBu3vEQNfiux',
      'amount': newAmount,
      'name': 'ProxyKhel',
      'description': 'Add money to proxykhel wallet',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);

      AddMoneyWalletModel.instance.setBalance(_amountToAdd);
      if(await AddMoneyWalletModel.instance.addBalance()){
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Success",style: TextStyle(color: Colors.green),),
                content: Text("Transaction successfull"),
                actions: <Widget>[
                  OutlineButton(
                    borderSide: BorderSide(
                        color: Colors.deepOrange
                    ),
                    child: new Text("OK",style: TextStyle(color: Colors.deepOrange),),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
        );
      }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setResponseListener();
    _isLoading=false;
    _amountToAdd='0';
    _amountController = TextEditingController();
    _amountToAddError = false;
    _internet = true;
    checkinternet();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> initPayment(String txnAmount) async {

    // try/catch any Exceptions.
    try {
      var userId = await SavedPref.instance.getUserId();
   await PaytmPayments.makePaytmPayment(


        "WGlUpt31068318705253", // [YOUR_MERCHANT_ID] (required field)
        "https://www.proxykhel.com/android/generateChecksum.php", // [YOUR_CHECKSUM_URL] (required field)
        customerId: userId, // [UNIQUE_ID_FOR_YOUR_CUSTOMER] (auto generated if not specified)
        orderId: DateTime.now().millisecondsSinceEpoch.toString(), // [UNIQUE_ID_FOR_YOUR_ORDER] (auto generated if not specified)
        txnAmount: txnAmount, // default: 10.0
        channelId: "WAP", // default: WAP (STAGING value)
        industryTypeId: "Retail", // default: Retail (STAGING value)
        website: "DEFAULT", // default: APPSTAGING (STAGING value)
        staging: false, // default: true (by default paytm staging environment is used)
        showToast: false, // default: true (by default shows callback messages from paytm in Android Toasts)


//     "rxazcv89315285244163", // [YOUR_MERCHANT_ID] (required field)
//     "https://ajax8732.000webhostapp.com/generateChecksum.php", // [YOUR_CHECKSUM_URL] (required field)
//     customerId: "12345", // [UNIQUE_ID_FOR_YOUR_CUSTOMER] (auto generated if not specified)
//     orderId: DateTime.now().millisecondsSinceEpoch.toString(), // [UNIQUE_ID_FOR_YOUR_ORDER] (auto generated if not specified)
//     txnAmount: "10.0", // default: 10.0
//     channelId: "WAP", // default: WAP (STAGING value)
//     industryTypeId: "Retail", // default: Retail (STAGING value)
//     website: "APPSTAGING", // default: APPSTAGING (STAGING value)
//     staging: true, // default: true (by default paytm staging environment is used)
//     showToast: false, // default: true (by default shows callback messages from paytm in Android Toasts)
      );
    } on Exception {
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amountController.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    _isLoading=false;

    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text(
          'Add Money',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: _internet?Center(
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
                Container(margin:EdgeInsets.only(right: 10.0),child: FutureBuilder(
                  future: WalletModel.instance.getWalletBalance(),
                  builder: (context, snapshot) {

                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                        return Center(child:new CircularProgressIndicator());
                      case ConnectionState.active:
                        return Center(child:new CircularProgressIndicator());
                        break;
                      case ConnectionState.waiting:
                        return Center(child:new CircularProgressIndicator());
                        break;
                      case ConnectionState.done:
                        if(snapshot.hasError){
                          SnackBar snackbar = new SnackBar(content: Text('Error fetching balance'));
                          Scaffold.of(context).showSnackBar(snackbar);
                        }
                        else if(!snapshot.hasData){
                          SnackBar snackbar = new SnackBar(content: Text('Error fetching balance'));
                          Scaffold.of(context).showSnackBar(snackbar);
                        }
                        else{
                          return new Text(snapshot.data.walletAmount??"0",style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 16.0),);
                        }
                    }
                    return new Container();
                  }
                )),
              ],
            ),
          ],
        ),
            Divider(),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: TextField(
            inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
            decoration: InputDecoration(
                labelText: 'Amount To Add',
                border: OutlineInputBorder(),
              errorText: _amountToAddError ? "Invalid Amount":null,
            ),
            onChanged: (value){
              if(value != '') {
                _amountToAdd = (value);
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
              child: Stack(
                children: <Widget>[
                  Center(
                    child: _isLoading? new CircularProgressIndicator():new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      color: Colors.deepOrange,
                      onPressed: ()async{
                        if(_amountToAdd == "0" || _amountToAdd == null || _amountToAdd == ''){
                          setState(() {
                            _amountToAddError = true;
                          });
                        }else{
                            setState(() {
                              _isLoading=true;
                            });

                            showDialog(context: context,
                            builder: (context){
                              return SimpleDialog(
                                children: <Widget>[
                                 ListTile(
                                   title: Text("PayTM"),
                                   onTap: (){
                                     initPayment(_amountToAdd);
                                   },
                                 ),
                                  ListTile(
                                    title: Text("Other Payment Method"),
                                    onTap: (){
                                      openCheckout(_amountToAdd);
                                    },
                                  )
                                ],
                              );
                            }
                            );

//                            _scaffoldKey.currentState.showBottomSheet(
//
//                                    (context){
//                              return new ListView(
//                                shrinkWrap: true,
//                                children: <Widget>[
//                                  new ListTile(
//                                    title: new Text("PayTM",style: TextStyle(color: Colors.white),),
//                                    onTap: (){
//
//                                      initPayment(_amountToAdd);
//
//                                    },
//                                  ),
//                                  new ListTile(
//                                    title: new Text("Other",style: TextStyle(color: Colors.white)),
//                                  )
//                                ],
//                              );
//                            },
//                            backgroundColor: Colors.grey[900]
//                            );

                        }
                      },
                      child: new Text('ADD MONEY',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ):new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Please check internet connectivity"),
            Container(
              width: 100.0,
              child: new OutlineButton(onPressed: (){
                setState(() {

                });
              },
                borderSide: BorderSide(
                  color: Colors.deepOrange
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text("Retry",style: TextStyle(color: Colors.deepOrange),),
                    new SizedBox(width: 2.0,),
                    new Icon(Icons.refresh,color: Colors.deepOrange,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}