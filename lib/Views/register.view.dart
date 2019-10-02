import 'package:flutter/material.dart';
import './../Constants/theme.dart' as Theme;
import './../Constants/slideTransitions.dart';
import 'package:connectivity/connectivity.dart';
import './../Model/register.model.dart';
import './verifyphone.view.dart';
import './../Views/login.view.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './dashboard.view.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static bool _isLoading;
  static bool _emailOrPhoneError;
  static bool _passwordError;
  static bool _fullNameError;

  TextEditingController emailOrPhoneController;
  TextEditingController passwordController;
  TextEditingController fullNameController;

  static String _emailOrPhone;
  static String _password;
  static String _fullName;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isLoggedIn = false;


  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  Future<bool> initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        return false;
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        return false;
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult
                .accessToken.token}');

        var profile = json.decode(graphResponse.body);
        Model.instance.setFacebookEmail(profile['name'].toString());
        Model.instance.setFacebookFullName(profile['email'].toString());

        onLoginStatusChanged(true);
        return true;
        break;
    }
  }


  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult Authuser = await _auth.signInWithCredential(credential);
    final FirebaseUser user = Authuser.user;

    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }


  @override
  void initState() {
    // TODO: implement initState
    _isLoading = false;
    _fullNameError=false;
    _passwordError = false;
    _emailOrPhoneError=false;
    emailOrPhoneController = new TextEditingController();
    passwordController = new TextEditingController();
    fullNameController = new TextEditingController();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailOrPhoneController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.ProxykhelThemeData,
      home: Builder(
        builder:(context)=> new Scaffold(
          key: _scaffoldKey,
          body: new Center(
            child: new Container(
                child: new ListView(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: new Image.asset('assets/images/logo.png',width: 100.0,height: 70,),
                      ),

                new Container(
                    margin: const EdgeInsets.only(left: 15.0,right: 15.0),
                    height: 60.0,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Expanded(
                          child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                                ,                                ),
                              color: Colors.white,
                              elevation: 4.0,
                              onPressed:() async {
                                if(await initiateFacebookLogin()){
                                  Model.instance.facebookLogin();
                                  Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget:Dashboard()), (Route<dynamic> route)=>false);
                                }
                              },

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(child: new Image.asset('assets/images/fbicon.png',height: 20.0,)),
                                  Container(child: new Text('Facebook',style: TextStyle(color: Colors.blueAccent),),),
                                ],
                              )),

                        ),
                        new SizedBox(
                          width: 10.0,
                        ),
                        new Expanded(
                          child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              elevation: 4.0,
                              color: Colors.white,
                              onPressed: (){
                                signInWithGoogle();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(child: new Image.asset('assets/images/gicon.png',height: 25.0,)),
                                  Container(child: new Text('Google      ',style: TextStyle(color: Colors.grey),),),
                                ],
                              )),

                        ),

                      ],
                    )
                ),
                      new Container(
                        margin: const EdgeInsets.only(top: 20,left: 15.0,right: 15.0),
                        child: new TextField(
                          controller: fullNameController,
                          onChanged:(value){
                            _fullName = value;
                            setState(() {
                              _fullNameError = false;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Full Name',
                              errorText: _fullNameError? 'Invalid input':'',
                              errorStyle: TextStyle(color:Colors.red),
                              hintStyle: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 20,left: 15.0,right: 15.0),
                        child: new TextField(
                          controller: emailOrPhoneController,
                          onChanged: (value){
                            _emailOrPhone = value;
                            setState(() {
                              _emailOrPhoneError = false;
                            });
                          },
                          decoration: InputDecoration(
                            errorText: _emailOrPhoneError ? 'Invalid input': '',
                              errorStyle: TextStyle(color:Colors.red),
                              hintText: 'Phone Number OR Email ID',
                              hintStyle: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )
                          ),
                        ),
                      ),

                      new Container(
                        margin: const EdgeInsets.only(top: 20,left: 15.0,right: 15.0),
                        child: new TextField(
                          controller: passwordController,
                          onChanged: (value){
                            _password = value;
                            setState(() {
                              _passwordError = false;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Password',
                              errorText: _passwordError? 'invalid password':'',
                              errorStyle: TextStyle(color:Colors.red),
                              hintStyle: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Colors.black,width: 20.0)
                              )
                          ),
                        ),
                      ),

                      _isLoading ?  new Center(child: new Stack(children: <Widget>[new CircularProgressIndicator()],),): new Container(
                        margin: EdgeInsets.all(20.0),
                        padding: EdgeInsets.only(left: 50.0,right: 50),
                        child: SizedBox(
                          child: MaterialButton(
                            onPressed: ()async{
                              var connectivityResult = await (Connectivity().checkConnectivity());
                              if (connectivityResult == ConnectivityResult.none) {
                                final snackBar = SnackBar(
                                    content: Text('No internet connection'));
                                _scaffoldKey.currentState.showSnackBar(snackBar);
                              }
                              else{
                                setState(() {
                                  _isLoading = true;
                                });
                                int num = await Model.instance.registeringNewUser(
                                   _fullName,
                                    _emailOrPhone,
                                    _password,
                                    "https://www.proxykhel.com/android/reg.php");
                                switch(num){
                                  case 1:
                                    setState(() {
                                      _isLoading = false;
                                      _emailOrPhoneError = true;
                                    });
                                    break;
                                  case 2:
                                    setState(() {
                                      _isLoading = false;
                                      _emailOrPhoneError = true;
                                    });
                                    break;
                                  case 3:
                                    final snackBar = SnackBar(
                                        content: Text('User Exists'),duration: const Duration(milliseconds: 1500),);
                                    _scaffoldKey.currentState.showSnackBar(snackBar);
                                    emailOrPhoneController.clear();
//                                    fullNameController.clear();
//                                    passwordController.clear();
                                    await new Future.delayed(const Duration(seconds: 2),);
                                    setState(() {
                                      _isLoading=false;
                                    });
                                    break;
                                  case 4:
                                    final snackBar = SnackBar(
                                        content: Text('Successfully registered'));
                                    _scaffoldKey.currentState.showSnackBar(snackBar);
                                    await new Future.delayed(const Duration(seconds: 2),);
                                    Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget: VerifyPhone()), (Route<dynamic> route)=>false);
                                    break;
                                  default:
                                    final snackBar = SnackBar(
                                        content: Text('Something went wrong try again'));
                                    _scaffoldKey.currentState.showSnackBar(snackBar);
                                    break;
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              }

                            },
                            elevation: 4.0,
                            highlightElevation: 1.0,
                            child: new Text('Register',style: TextStyle(color: Colors.white),),
                            height: 50.0,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.deepOrange[500],
                            animationDuration: Duration(microseconds: 10),
                          ),
                        ),
                      ),


                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            child: Text('By registering, I agree to Proxykhel\'s',style: TextStyle(fontSize: 16.0),),
                          ),
                          new Container(
                            child: Text('T&Cs',style: TextStyle(color: Colors.blueAccent,fontSize: 16.0),),
                          )
                        ],
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            margin:EdgeInsets.only(top: 15.0),
                            child: new Text('Already a user? ',style: TextStyle(fontSize: 16.0),),
                          ),
                          new InkWell(
                            child: new Container(
                              margin:EdgeInsets.only(top: 15.0),
                              child: new Text('Login!',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.deepOrange),),
                            ),
                            onTap: (){
                                Navigator.of(context).pushAndRemoveUntil(SlideLeftRoute(widget: LoginScreen()), (Route<dynamic> route)=>false);
                            },
                          ),

                        ],
                      ),

                    ]
                ),
              ),
          ),
        ),
      ),
    );
  }
}
