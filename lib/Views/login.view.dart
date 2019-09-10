import 'package:flutter/material.dart';
import './../Constants/theme.dart' as Theme;
import './../Model/login.model.dart';
import './register.view.dart';
import './../Constants/slideTransitions.dart';
import 'package:connectivity/connectivity.dart';
import './dashboard.view.dart';
import './verifyphoneafterlogin.view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './verifyphone.view.dart';
import './../Model/verifyphone.model.dart';
import './forgotpassword.view.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  GoogleSignInAccount _currentUser;

  static bool _isTextObsecured;

  bool _isLoading = false;
  String msg='';

  String BASE_URL ='https://www.proxykhel.com/';
  String endPointLogin ='android/final.php';

  bool isLoggedIn = false;

  String _contactText;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        return false;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        return false;
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult
                .accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        Model.instance.setFacebookEmail(profile['name'].toString());
        Model.instance.setFacebookFullName(profile['email'].toString());
        onLoginStatusChanged(true);
        return true;
        break;
    }
  }


  @override
  void initState() {
    super.initState();
    _isTextObsecured = true;
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
  }



  Future<int> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      String email = _googleSignIn.currentUser.email;
      String fullName = _googleSignIn.currentUser.displayName;
      String uId = _googleSignIn.currentUser.id;
      String picture = _googleSignIn.currentUser.photoUrl;
      List<String> s = _googleSignIn.currentUser.displayName.split(new RegExp('\\s+'));
      String firstName = s[0];
      int num = await Model.instance.googleLogin(uId, email, fullName, picture, firstName);
      return num;

    } catch (error) {
      print(error);
    }
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.ProxykhelThemeData,
      home: Builder(
        builder:(context)=>
        new Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
          child:new Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: Builder(
              builder:(context)=> Center(
                  child: new Container(
                    child: new ListView(
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(top: 30.0,bottom: 30.0),
                            child: new Image.asset('assets/images/logo.png',width: 80.0,height: 60,),
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
                                        onPressed:()async{

                                          print('Facebook login');
                                          if(await initiateFacebookLogin()){
                                            Model.instance.facebookLogin();
                                           Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget: Dashboard()), (Route<dynamic> route)=>false);
                                          }  else{
                                            SnackBar snackbar = new SnackBar(content: Text("Error logging in"),duration: Duration(seconds: 1),);
                                            _scaffoldKey.currentState.showSnackBar(snackbar);
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
                                        onPressed: () async {
//                                          signInWithGoogle().whenComplete(() {
//                                            Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget: Dashboard()), (Route<dynamic> route)=>false);
//                                          });
                                          int num = await _handleSignIn();
                                          if(num==1){
                                            Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget: Dashboard()), (Route<dynamic> route)=>false);
                                          }else{
                                            SnackBar snackBar = new SnackBar(content: Text("Error logging in.Try again"),duration: Duration(seconds: 1),);
                                            _scaffoldKey.currentState.showSnackBar(snackBar);
                                          }
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
                            margin: const EdgeInsets.only(top: 20,left: 30.0,right: 30.0),
                            child: new TextField(
                              controller: _username,
                              onChanged: (value){
                                setState(() {
                                  msg='';
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'Phone Number OR Email Id',
                                  hintStyle: new TextStyle(fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )
                              ),
                            ),
                          ),

                          new Container(
                            margin: const EdgeInsets.only(top: 20,left: 30.0,right: 30.0),
                            child: new TextField(
                              obscureText: _isTextObsecured,
                              onChanged: (value){
                                setState(() {
                                  msg='';
                                });
                              },
                              controller: _password,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                                    setState(() {
                                      _isTextObsecured = !_isTextObsecured;
                                    });
                                  },),
                                  hintText: 'Password',
                                  hintStyle: new TextStyle(fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: Colors.black,width: 20.0)
                                  )
                              ),
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: new Text(msg,style: TextStyle(color: Colors.red),textAlign: TextAlign.center,),
                          ),
                          Center(
                            child: new Stack(
                              children: <Widget>[
                                _isLoading ? new CircularProgressIndicator():new Container(
                                  height:50.0,
                                  width: 120.0,
                                  margin: EdgeInsets.all(15.0),
                                  padding: EdgeInsets.only(left: 0.0,right: 0.0),
                                  child: RaisedButton(
                                    onPressed: () async  {
                                      var connectivityResult = await (Connectivity().checkConnectivity());
                                      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                        if(_username.text != '' && _username.text != null && _password.text != '' && _password.text != null){

                                          setState(() {
                                            _isLoading = true;
                                          });

                                          int isLogin = await Model.instance.logginIn(_username.text, _password.text);
                                          if(isLogin == 1){
                                            Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget:Dashboard()),(Route<dynamic> route)=>false);
                                          }
                                          else if(isLogin == 2){
                                            VerifyPhoneModel.instance.setContact(int.parse(_username.text));
                                            Navigator.push(context, SlideLeftRoute(widget:VerifyPhone()));

                                          }
                                          else if(isLogin == 3){
                                            Navigator.push(context, SlideLeftRoute(widget:VerifyPhoneAfterLogin()));
                                          }
                                          else{
                                            msg = 'Invalid username or password';
                                          }
                                          setState(() {
                                            _password.clear();
                                            _isLoading=false;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            msg = 'Username or Password can not be empty';
                                          });
                                        }

                                      } else if (connectivityResult == ConnectivityResult.none) {
                                        setState(() {
                                          msg = '';
                                        });
                                        final snackBar = SnackBar(
                                            content: Text('No internet connection'));
                                        Scaffold.of(context).showSnackBar(snackBar);

                                      }



                                    },
                                    elevation: 4.0,
                                    highlightElevation: 1.0,
                                    child: new Text('LOGIN',style: TextStyle(color: Colors.white),),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.deepOrange[500],
                                    animationDuration: Duration(microseconds: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
//                          _isLoading ?new SizedBox.fromSize(size: Size(50, 50),child: CircularProgressIndicator(),) :

                          new Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: new Text('OR',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Container(
                                child: new Text('New User?',textAlign: TextAlign.center,),
                              ),
                              new Container(
                                child: new InkWell(
                                  onTap: (){
                                    Navigator.push(context, SlideLeftRoute(widget:Register()));
                                  },
                                  child: Text('Register!',style: TextStyle(color:Colors.deepOrange,fontSize: 16.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                ),
                              ),
                            ],
                          ),
                          new Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Center(child: InkWell(
                                onTap: (){Navigator.push(context, SlideLeftRoute(widget: ForgotPassword()));},
                                child: new Text('Forgot password?',style: TextStyle(color:Colors.deepOrange,fontSize: 16.0,fontWeight: FontWeight.bold))),),
                          ),

                        ]
                    ),
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}