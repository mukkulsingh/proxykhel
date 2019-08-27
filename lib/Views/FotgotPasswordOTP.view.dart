import 'package:flutter/material.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import 'package:proxykhel/Views/CeateNewPassword.view.dart';
import './../Model/ForgotPassword.model.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
class ForgotPasswordOTP extends StatefulWidget {
  @override
  _ForgotPasswordOTPState createState() => _ForgotPasswordOTPState();
}

class _ForgotPasswordOTPState extends State<ForgotPasswordOTP> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static String _otp;
  static bool _otpError;
  static bool _isResendBtnLoading;
  static bool _isLoading;
  @override
  void initState() {
    super.initState();
    _otpError=false;
    _isResendBtnLoading=false;
    _isLoading=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: new Image.asset(
              'assets/images/logo.png',
              width: 120.0,
              height: 70,
            ),
          ),

          new Container(
            child: new Text(
              "OTP sent to ${ForgotPasswordModel.instance.getPhoneNo}",
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 20,left: 20.0,right: 20.0),
            child: new TextField(
              onChanged: (value){
                setState(() {
                  _otp = value;
                  _otpError=false;
                });
              },
              decoration: InputDecoration(
                hintText: 'OTP',
                hintStyle: new TextStyle(fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                errorText: _otpError?"Invalid input":"",
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Center(
            child: Container(
              child: Stack(
                children: <Widget>[
                  _isLoading?new CircularProgressIndicator():new Container(
                    height: 45.0,
                    child: new RaisedButton(onPressed: (){
                      if(_otp == '' || _otp == null){
                        setState(() {
                          _otpError=true;
                        });
                      }else{
                        setState(() {
                          _otpError=false;
                          _isLoading=true;
                        });
                        if(ForgotPasswordModel.instance.verifyOTP(_otp)){
                          SnackBar snackbar = new SnackBar(content: Text("OTP verified"),duration: Duration(seconds: 1),);
                          _scaffoldKey.currentState.showSnackBar(snackbar);
                          Future.delayed(Duration(seconds: 1),(){
                            Navigator.push(context, SlideLeftRoute(widget: CreateNewPassword()));
                            setState(() {
                              _isLoading=false;
                            });
                          });
                        }else{
                          SnackBar snackbar = new SnackBar(content: Text("Invalid OTP"),duration: Duration(seconds: 1),);
                          _scaffoldKey.currentState.showSnackBar(snackbar);
                          setState(() {
                            _isLoading=false;
                            _isResendBtnLoading=false;
                          });
                        }
                      }
                    },
                      elevation: 4.0,
                      highlightElevation: 1.0,
                      child: new Text('Submit',style: TextStyle(color: Colors.white),),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.deepOrange[500],
                      animationDuration: Duration(microseconds: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          new Center(
            child: new Stack(
              children: <Widget>[
                _isResendBtnLoading?new Center(child: new CircularProgressIndicator(),):Container(
                  margin: EdgeInsets.symmetric(horizontal: 100.0),
                  height: 45.0,
                  child: new FlatButton(
                    onPressed: ()async{
                      setState(() {
                        _isResendBtnLoading=true;
                        _isLoading=false;
                      });
                      int min = 1000;
                      int max = 9999;
                      int otp = min + (Random().nextInt(max-min));
                      ForgotPasswordModel.instance.setOTP(otp.toString());
                      var msg = "Dear USER, your OTP is $otp to reset  your password on Proxy Khel";


                      http.Response response = await http.get("https://api.msg91.com/api/sendhttp.php?mobiles=${ForgotPasswordModel.instance.getPhoneNo}&authkey=281414AsacFSKmekD5d0773a5&route=4&sender=PRKHEL&message=$msg&country=91");
                      if(response.statusCode == 200){
                        SnackBar snackbar = new SnackBar(content: Text('OTP sent'),duration: Duration(seconds: 1),);
                        _scaffoldKey.currentState.showSnackBar(snackbar);
                        Future.delayed(const Duration(milliseconds: 1200),(){
                          setState(() {
                            _isResendBtnLoading=false;
                          });
                        });
                      }else{
                        SnackBar snackbar = new SnackBar(content: Text('OTP not sent.Try again'),duration: Duration(seconds: 1),);
                        _scaffoldKey.currentState.showSnackBar(snackbar);
                        setState(() {
                          _isResendBtnLoading=false;
                          _isLoading=false;
                        });
                      }


                    },
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Text("Resend OTP",style: TextStyle(color: Colors.blue),),
                        Icon(Icons.refresh,color: Colors.blue,),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
