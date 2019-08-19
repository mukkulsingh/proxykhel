import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './../Model/savedpref.model.dart';
import 'dart:convert';
import 'dart:math';

class KycPhoneVerification extends StatefulWidget {
  String contact;
  int otp;
  KycPhoneVerification({ this.contact,this.otp});
  @override
  _KycPhoneVerificationState createState() => _KycPhoneVerificationState();
}

class _KycPhoneVerificationState extends State<KycPhoneVerification> {

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  static bool _isLoading;
  static bool _isResendButtonLoading;
  static bool _isError;
  static String contact;
  static int otp;
  static bool _isResendButtonVisible;

  static int _otp;
  @override
  void initState() {
    // TODO: implement initState
    _isError = false;
    contact = widget.contact;
    otp = widget.otp;
    _isResendButtonVisible=false;
    _isLoading = false;
    _isResendButtonLoading=false;
  }
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 10),(){
      setState(() {
        _isResendButtonVisible=true;
      });
    });

    final OtpInput = new Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter OTP",
            errorText: _isError?"OTP can not be empty":""
        ),
        onChanged: (value){
          _otp = int.parse(value);
          setState(() {
            _isError = false;
          });
        },
      ),
    );

    final submitOtp = new Container(
      height: 45.0,
      width: 150.0,
      child: new RaisedButton(
        onPressed: () async{

          if(_otp != 0 && _otp != null){

            setState(() {
              _isLoading = true;
            });

            if(_otp == otp){
              String userId = await SavedPref.instance.getUserId();
              http.Response response = await http.post("https://www.proxykhel.com/android/kycverificationmobile.php",body: {
                "type":"MobileVerificationKyc",
                "userid":userId,
              });
              if(response.statusCode == 200){
                final res = json.decode(response.body);
                if(res['success']==true && res['msg']=='ok'){
                  showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                          title: Text('Success',style: TextStyle(color: Colors.green,fontSize: 22.0),),
                          content: Row(
                            children: <Widget>[
                              Text('Mobile number verified',style: TextStyle(fontSize: 18.0),),
                              Icon(Icons.check_circle,color:Colors.green,size: 16.0,)
                            ],
                          ),
                        );
                      });

                }else  if(res['success']==false && res['msg']=='fail'){
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
                              Text('Mobile verifaction failed.',style: TextStyle(fontSize: 18.0),),
                              Icon(Icons.error,color:Colors.red,size: 24.0,)
                            ],
                          ),
                        );
                      });
                  setState(() {
                    _isLoading=false;
                    _isResendButtonLoading = false;
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
                            Text('Mobile number verifaction failed.Try again',style: TextStyle(fontSize: 18.0),),
                            Icon(Icons.report_problem,color:Colors.red,size: 16.0,)
                          ],
                        ),
                      );
                    });
              }
            }
            else{
              setState(() {
                _isLoading = false;
                _isResendButtonLoading=false;
                SnackBar snackbar = new SnackBar(content:Text('Invalid OTP',),duration: const Duration(seconds: 1),);
                _scaffoldkey.currentState.showSnackBar(snackbar);
              });
            }

          }else{
            setState(() {
              _isError=true;
            });
          }
        },
        child:new Text("SUBMIT",style: TextStyle(color: Colors.white),),
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final resendButton = new Container(
      height: 20.0,
      width: 160.0,
      child: new FlatButton(
        onPressed: ()async {
          setState(() {
            _isLoading=false;
            _isResendButtonLoading = true;
          });

          int min = 1000;
          int max = 9999;
          int OTP = min + (Random().nextInt(max - min));
          otp = OTP;
          var msg = "Dear USER, your OTP is $OTP to activate your account on Proxy Khel.";
          http.Response response = await http.get(
              "https://api.msg91.com/api/sendhttp.php?mobiles=$contact&authkey=281414AsacFSKmekD5d0773a5&route=4&sender=PRKHEL&message=$msg&country=91");
          if(response.statusCode == 200){
            SnackBar snackbar = new SnackBar(content:Text('OTP sent',),duration: const Duration(seconds: 1),);
            _scaffoldkey.currentState.showSnackBar(snackbar);
            setState(() {
              _isResendButtonLoading = false;
            });
          }
          else{
            SnackBar snackbar = new SnackBar(content:Text('OTP not sent. Try again',),duration: const Duration(seconds: 1),);
            _scaffoldkey.currentState.showSnackBar(snackbar);

          }
        },

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text("Resend OTP",style: TextStyle(color: Colors.blue),),
            new Icon(Icons.refresh,color: Colors.blue,),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
    return Scaffold(
      key: _scaffoldkey,
      appBar: new AppBar(
        title: new Text("Verify Contact",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),

      body: new Column(
        children: <Widget>[

          new SizedBox(
            height: 20.0,
          ),
          new Text('OTP sent to $contact',style: TextStyle(color: Colors.deepOrange,fontSize: 18.0),),

          SizedBox(height: 20.0,),

          OtpInput,
          SizedBox(height: 20.0,),

          new Stack(
            children: <Widget>[
              _isLoading?new Center(child: new CircularProgressIndicator(),): submitOtp,

            ],
          ),

          SizedBox(height: 20.0,),

          new Stack(
            children: <Widget>[
              _isResendButtonVisible ? _isResendButtonLoading ? new Center(child: new CircularProgressIndicator(),):resendButton : new Container(),
            ],
          )


        ],
      ),
    );
  }
}
