import 'package:flutter/material.dart';
import 'package:proxykhel/Model/VerifyPhoneKyc.model.dart';
import './../Constants/theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'dart:math';
import './../Constants/slideTransitions.dart';
import 'dashboard.view.dart';
class VerifyPhoneKyc extends StatefulWidget {
  @override
  _VerifyPhoneKycState createState() => _VerifyPhoneKycState();
}

class _VerifyPhoneKycState extends State<VerifyPhoneKyc> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static bool _resendOtpVisibility;
  static bool _isResendButtonLoading;
  static bool _isSubmitButtonLoading;
  static bool _isOtpError;
  static String _textOnButton = "SUBMIT";
  static int _OTP;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _OTP = 0;
    _isOtpError=false;
    _isResendButtonLoading=false;
    _resendOtpVisibility = false;
    _isSubmitButtonLoading=false;
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        _resendOtpVisibility=true;
      });
    });

    _textOnButton = "SUBMIT";
    return MaterialApp(
      title: 'ProxyKhel',
      theme: Theme.ProxykhelThemeData,
      home: new Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: new Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: new ListView(
                children: <Widget>[
                  new SizedBox(
                    height: 20.0,
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: new Image.asset('assets/images/logo.png',width: 100.0,height: 70,),
                  ),
                  new SizedBox(height: 20.0,),

                  new Text('Please verify your phone number',style: TextStyle(color:Colors.deepOrange,fontSize: 16.0,fontWeight: FontWeight.bold,),maxLines: 2,softWrap: true,textAlign: TextAlign.center,),
                  new SizedBox(height: 20.0,),
                  new Text('OTP sent to ${VerifyPhoneKycModel.instance.getContact()}',textAlign: TextAlign.center,),

                  new SizedBox(height: 20.0,),

                  new TextField(
                    onChanged: (value){
                      _OTP = int.parse(value);
                      setState(() {
                        _isOtpError = false;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter OTP",
                        errorText: _isOtpError?"Invalid OTP":''
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:60.0),
                    child: Stack(
                      children: <Widget>[
                        _isSubmitButtonLoading ?new Center(child: new CircularProgressIndicator(),):new Center(
                          child: new Container(
                            height: 45.0,
                            child: new RaisedButton(
                              onPressed: () async {
                                if(_OTP == 0 || _OTP == null){
                                  setState(() {
                                    _isOtpError=true;
                                  });
                                }
                                else{

                                  if( await VerifyPhoneKycModel.instance.verifyOTP(_OTP)){
                                    setState(() {
                                      _isSubmitButtonLoading = true;
                                    });
                                    SnackBar snackBar = new SnackBar(content: Text('OTP verified'),duration: const Duration(milliseconds: 1500),);
                                    _scaffoldKey.currentState.showSnackBar(snackBar);

                                    Future.delayed(const Duration(milliseconds: 1700), () {
                                      Navigator.of(context).pushAndRemoveUntil(SlideLeftRoute(widget: Dashboard()), (Route<dynamic> route)=>false);
                                    });
                                  }else if(!await VerifyPhoneKycModel.instance.verifyOTP(_OTP)){

                                    SnackBar snackBar = new SnackBar(content: Text('OTP verification failed. Try again'),duration: const Duration(milliseconds: 1000),);
                                    _scaffoldKey.currentState.showSnackBar(snackBar);
                                    setState(() {
                                      _resendOtpVisibility = true;
                                      _isSubmitButtonLoading = false;
                                    });
                                  }
                                }
                              },
                              color: Colors.deepOrange,
                              child: Text(_textOnButton,style: TextStyle(color: Colors.white),),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Stack(
                    children: <Widget>[

                      _resendOtpVisibility? _isResendButtonLoading ? new Center(child: new CircularProgressIndicator(),) : new Container(
                        margin: EdgeInsets.only(top: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 80.0),
                        child: new FlatButton(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          splashColor: Colors.blue,
                          onPressed: ()async{

                            setState(() {
                              _isResendButtonLoading = true;
                            });

                            int min = 1000;
                            int max = 9999;
                            int otp = min + (Random().nextInt(max-min));

                            VerifyPhoneKycModel.instance.setOTP(otp);

                            int contact = VerifyPhoneKycModel.instance.getContact();

                            var msg = "Dear USER, your OTP is ${VerifyPhoneKycModel.instance.getOTP()} to activate your account on Proxy Khel.";

                            http.Response response = await http.get
                              ("https://api.msg91.com/api/sendhttp.php?mobiles=${contact.toString()}&authkey=281414AsacFSKmekD5d0773a5&route=4&sender=PRKHEL&message=$msg&country=91");

                            if(response.statusCode == 200){
                              SnackBar snackBar = new SnackBar(content: Text('OTP sent'),duration: const Duration(milliseconds: 500),);

                              _scaffoldKey.currentState.showSnackBar(snackBar);

                              setState(() {
                                _isResendButtonLoading = false;
                                _isSubmitButtonLoading = false;
                              });
                            }
                            else{
                              SnackBar snackBar = new SnackBar(content: Text('OTP not sent. Try again!'),duration: const Duration(milliseconds: 500),);
                              Scaffold.of(context).showSnackBar(snackBar);

                              setState(() {
                                _isResendButtonLoading = false;
                                _isSubmitButtonLoading = false;
                              });
                            }
                          },

                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Text('Resend OTP',style: TextStyle(fontSize: 12.0,color: Colors.blue),),
                              new Icon(Icons.refresh,color: Colors.blue,),
                            ],
                          ),

                        ),
                      ):new Container(),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
