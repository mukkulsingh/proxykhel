import 'package:flutter/material.dart';
import './login.view.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  static bool _isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                },
                decoration: InputDecoration(
                    hintText: 'Registered Phone Number OR Email',
                    hintStyle: new TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )
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
                        setState(() {
                          _isLoading=true;
                        });
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
