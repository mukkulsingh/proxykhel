import 'package:flutter/material.dart';
import './../Constants/theme.dart' as theme;
import './../Constants/slideTransitions.dart';
import './../Model/verifyphone.model.dart';
import './../Views/verifyphone.view.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
class VerifyPhoneAfterLogin extends StatefulWidget {
  @override
  _VerifyPhoneAfterLoginState createState() => _VerifyPhoneAfterLoginState();
}

class _VerifyPhoneAfterLoginState extends State<VerifyPhoneAfterLogin> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static String _contact;
  static bool _inputError;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inputError = false;
  }

  @override
  Widget build(BuildContext context) {

    final contactText = TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Enter contact number",
        errorText: _inputError?'Invalid contact no':''
      ),
      onChanged: (value) {
        _contact = value;
        setState(() {
          _inputError = false;
        });
      },
    );
    return MaterialApp(
        title: 'ProxyKhel',
        theme: theme.ProxykhelThemeData,
        home: new Scaffold(
          key: _scaffoldKey,
            body: SafeArea(
          child: new Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new SizedBox(
                      height: 20.0,
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: new Image.asset(
                        'assets/images/logo.png',
                        width: 100.0,
                        height: 70,
                      ),
                    ),
                    new SizedBox(
                      height: 20.0,
                    ),
                    new Text(
                      'Please verify your phone number',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    new SizedBox(
                      height: 20.0,
                    ),

                    contactText,

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 60.0),
                      height: 45.0,
                      child: new RaisedButton(onPressed: () async {
                        if(_contact.length != 10){
                          setState(() {
                            _inputError = true;
                          });
                        }
                        else{
                          int min = 1000;
                          int max = 9999;
                          int otp = min + (Random().nextInt(max-min));
                          VerifyPhoneModel.instance.setOTP(otp);
                          VerifyPhoneModel.instance.setContact(int.parse(_contact));
                          var msg = "Dear User, your OTP is ${VerifyPhoneModel.instance.getOTP()} to activate your account on Proxy Khel.";


                          http.Response response = await http.get("https://api.msg91.com/api/sendhttp.php?mobiles=$_contact&authkey=281414AsacFSKmekD5d0773a5&route=4&sender=PRKHEL&message=$msg&country=91");
                          if(response.statusCode == 200){
                            SnackBar snackbar = new SnackBar(content: Text('OTP sent'),duration: Duration(seconds: 1),);
                            _scaffoldKey.currentState.showSnackBar(snackbar);
                          }
                          Future.delayed(const Duration(milliseconds: 1200));

                          Navigator.push(context, SlideLeftRoute(widget: VerifyPhone()));
                        }
                      },
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: new Text('Send OTP',style: TextStyle(color: Colors.white),),
                        color: Colors.deepOrange,
                      ),
                    )
                  ]),
            ),
          ),
        )));
  }
}
