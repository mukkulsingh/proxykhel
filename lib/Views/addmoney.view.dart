import 'package:flutter/material.dart';
import './../Model/wallet.model.dart';
import 'package:paytm_payments/paytm_payments.dart';
import './../Model/savedpref.model.dart';
class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {

  static bool _isLoading;

  void setResponseListener(){

    // setting a listener on payment response
    PaytmPayments.responseStream.listen((Map<dynamic, dynamic> responseData){

      print(responseData);

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
    });
  }



  static String _amountToAdd;
  static bool _isLowBalance;

  TextEditingController _amountController;
  static bool _amountToAddError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setResponseListener();
    _isLoading=false;
    _amountToAdd='0';
    _amountController = TextEditingController();
    _amountToAddError = false;
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
        showToast: true, // default: true (by default shows callback messages from paytm in Android Toasts)
      );

    } on Exception {

      print("Some error occurred");
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
                Container(margin:EdgeInsets.only(right: 10.0),child: new Text(WalletModel.instance.getBalance()??"0",style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 16.0),)),
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
                      onPressed: (){
                        if(_amountToAdd == "0" || _amountToAdd == null || _amountToAdd == ''){
                          setState(() {
                            _amountToAddError = true;
                          });
                        }else{
                            setState(() {
                              _isLoading=true;
                            });
//                    WalletModel.instance.startPayment(_amountToAdd);
                          initPayment(_amountToAdd);


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
      ),
    );
  }
}
