import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import 'package:proxykhel/Views/FotgotPasswordOTP.view.dart';
import './../Model/ForgotPassword.model.dart';
import 'login.view.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static bool _isLoading;
  static String _emailId;
  static bool _emailIdError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=false;
    _emailIdError=false;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: new Center(
        child: new ListView(
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 30.0,bottom: 30.0),
              child: new Image.asset('assets/images/logo.png',width: 120.0,height: 70,),
            ),

            new Container(
              child: new Text(
                "Forgot Password",
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
                    _emailId = value;
                    _emailIdError=false;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Registered Phone Number OR Email',
                    hintStyle: new TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  errorText: _emailIdError?"Invalid input":"",
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
                      child: new RaisedButton(onPressed: () async{
                        if(_emailId == '' || _emailId == null){
                          setState(() {
                            _emailIdError=true;
                          });
                        }else{
                          setState(() {
                            _emailIdError=false;
                            _isLoading=true;
                          });
                          int num = await ForgotPasswordModel.instance.forgotPassword(_emailId);
                          switch(num){
                            case 0:
                              SnackBar snackbar = new SnackBar(content: Text("Server error. Try again!"),duration: const Duration(seconds: 1),);
                              _scaffoldKey.currentState.showSnackBar(snackbar);
                              setState(() {
                                _isLoading=false;
                              });
                              break;
                            case 1:
                              SnackBar snackbar = new SnackBar(content: Text("OTP sent"),duration: const Duration(seconds: 1),);
                              _scaffoldKey.currentState.showSnackBar(snackbar);
                              Future.delayed(Duration(seconds: 1),(){
                                Navigator.push(context, SlideLeftRoute(widget: ForgotPasswordOTP()));
                                setState(() {
                                  _isLoading=false;
                                });
                              });
                              break;

                            case 2:
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.pushAndRemoveUntil(context, SlideRightRoute(widget: LoginScreen()), (Route<dynamic> route)=>false);
                                    });
                                    return AlertDialog(
                                      title: Text('Success',style: TextStyle(color: Colors.green,fontSize: 22.0),),
                                      content: Row(
                                        children: <Widget>[
                                          Text('Check your email to create new password',style: TextStyle(fontSize: 18.0),),
                                        ],
                                      ),
                                    );
                                  });
                              break;
                            case 3:
                              SnackBar snackbar = new SnackBar(content: Text("Invalid user"),duration: const Duration(seconds: 1),);
                              _scaffoldKey.currentState.showSnackBar(snackbar);
                              setState(() {
                                _isLoading=false;
                              });
                              break;
                            default:
                              SnackBar snackbar = new SnackBar(content: Text("Something went wrong.Please try again"),duration: const Duration(seconds: 1),);
                              _scaffoldKey.currentState.showSnackBar(snackbar);
                              setState(() {
                                _isLoading=false;
                              });
                              break;
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
          ],
    ),
      ),
    );
  }
}
