import 'package:flutter/material.dart';
import './../Constants/theme.dart' as Theme;
import './../Controller/login.controller.dart';
import './register.view.dart';
import './../Constants/slideTransitions.dart';
import 'package:connectivity/connectivity.dart';
import './dashboard.view.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  static bool _isTextObsecured = false;

  bool _isLoading = false;
  String msg='';

  String BASE_URL ='https://www.proxykhel.com/';
  String endPointLogin ='android/final.php';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isTextObsecured = false;
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
            backgroundColor: Colors.transparent,
            body: Builder(
              builder:(context)=> Center(
                child: Hero(
                  tag: 'loginToRegister',
                  child: new Container(
                    child: new ListView(
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(top: 30.0,bottom: 30.0),
                            child: new Image.asset('assets/images/logo.png',width: 120.0,height: 70,),
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
                                        onPressed:(){
                                          print('Facebook login');
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
                                          print('google login');
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

                                          bool isLogin = await Controller.instance.loginRequest(BASE_URL+endPointLogin, _username.text, _password.text);

                                          if(isLogin){
                                            Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget:Dashboard()),(Route<dynamic> route)=>false);
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
                            child: Center(child: new Text('Forgot password?',style: TextStyle(color:Colors.deepOrange,fontSize: 16.0,fontWeight: FontWeight.bold)),),
                          ),

                        ]
                    ),
                  ),
                ) ,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;

  CustomButton({this.buttonText});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 4.0,
      highlightElevation: 1.0,
      child: new Text(buttonText,style: TextStyle(color: Colors.white),),
      height: 50.0,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      color: Colors.deepOrange[500],
      animationDuration: Duration(microseconds: 10),
    );
  }
}