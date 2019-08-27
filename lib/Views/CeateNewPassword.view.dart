import 'package:flutter/material.dart';
import './../Constants/slideTransitions.dart';
import './../Model/ForgotPassword.model.dart';
import './forgotpassword.view.dart';
import './login.view.dart';

class CreateNewPassword extends StatefulWidget {
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static String _newPassword;
  static bool _newPasswordError;
  static String _confirmPassword;
  static bool _confirmPasswordError;
  static bool _isLoading;

  @override
  void initState() {
    super.initState();
    _newPasswordError=false;
    _confirmPasswordError=false;
    _isLoading=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: new Image.asset(
              'assets/images/logo.png',
              width: 120.0,
              height: 70,
            ),
          ),

          SizedBox(height: 20.0,),
          new Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: new TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "New Password",
                errorText: _newPasswordError?"Invalid input":""
              ),
              onChanged: (value){
                _newPassword = value;
                setState(() {
                  _newPasswordError=false;
                  _confirmPasswordError=false;
                });
              },
            ),
          ),
          new Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: new TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm password",
                errorText: _confirmPasswordError?"Invalid input":"",

              ),
              onChanged: (value){
                _confirmPassword=value;
              },
            ),
          ),
          Center(
            child: new Container(
              child: Stack(
                children: <Widget>[
                  _isLoading?new Center(child: new CircularProgressIndicator(),):new Container(height: 45.0,
                    child: new RaisedButton(onPressed: ()async{
                      if(_newPassword == '' || _newPassword == null){
                        setState(() {
                          _newPasswordError=true;
                        });
                      }else if(
                      _confirmPassword=='' || _confirmPassword==null){
                        setState(() {
                          _confirmPasswordError=true;
                        });
                      }
                      else if(_newPassword != _confirmPassword){
                        SnackBar snackbar = new SnackBar(content: Text("Password does not match",),duration: Duration(seconds: 2),);
                        _scaffoldKey.currentState.showSnackBar(snackbar);
                        setState(() {
                          _confirmPasswordError=true;
                          _newPasswordError=true;
                        });
                      }
                      else if(_newPassword == _confirmPassword){
                        setState(() {
                          _isLoading = true;
                        });
                        if(await ForgotPasswordModel.instance.updatePassword(_newPassword)){
                          showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pushAndRemoveUntil(context, SlideRightRoute(widget: LoginScreen()), (Route<dynamic> route)=>false);
                                });
                                return AlertDialog(
                                  title: Text('Success',style: TextStyle(color: Colors.green,fontSize: 22.0),),
                                  content: Text('Password successfully changed',style: TextStyle(fontSize: 18.0),),

                                );
                              });
                        }else{
                          showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pushAndRemoveUntil(context, SlideRightRoute(widget: ForgotPassword()), (Route<dynamic> route)=>false);
                                });
                                return AlertDialog(
                                  title: Text('Error',style: TextStyle(color: Colors.red,fontSize: 22.0),),
                                  content: Text('Something went wrong. Try again',style: TextStyle(fontSize: 18.0),),
                                );
                              });
                        }
                      }

                    },
                      child: new Text("Submit",style: TextStyle(color: Colors.white),),
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    )
                    ,
                  )                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
