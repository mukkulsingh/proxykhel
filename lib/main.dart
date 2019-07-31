import "package:flutter/material.dart";
import './Controller/login.controller.dart';
import './Views/login.view.dart';
import './Views/dashboard.view.dart';

void main() async {
  bool isLoggedIn = await Controller.instance.isLoggedIn();
  if(isLoggedIn){
    runApp(DashboardScreen());
  }
  else{
    runApp(Login());
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dashboard()
    );
  }
}



//class Logins extends StatefulWidget {
//  @override
//  _LoginsState createState() => _LoginsState();
//}
//
//class _LoginsState extends State<Logins> {
//  TextEditingController _username = new TextEditingController();
//  TextEditingController _password = new TextEditingController();
//
//  bool _isLoading = false;
//
//  Future<http.Response> loginRequest () async {
//    final response = await http.post('https://www.proxykhel.com/android/final.php',body: {'username':_username.text,'password':_password.text});
//    print(json.decode(response.body));
//
//  }
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: Theme.ProxykhelThemeData,
//      home: Builder(
//        builder:(context)=>
//        new Container(
//          decoration: new BoxDecoration(
//              color: Colors.white,
//          ),
//        child:new Scaffold(
//          backgroundColor: Colors.transparent,
//          body: new Center(
//              child: Hero(
//                tag: 'loginToRegister',
//                child: new Container(
//                  child: new ListView(
//                    children: <Widget>[
//                      new Container(
//                        margin: const EdgeInsets.only(top: 30.0,bottom: 30.0),
//                        child: new Image.asset('assets/images/logo.png',width: 120.0,height: 70,),
//                      ),
//                      new Container(
//                          margin: const EdgeInsets.only(left: 15.0,right: 15.0),
//                        height: 60.0,
//                        child: new Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            new Expanded(
//                              child: RaisedButton(
//                                shape: new RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(30.0)
//,                                ),
//                                color: Colors.white,
//                                  elevation: 4.0,
//                                  onPressed:(){
//                                    print('Facebook login');
//                                  },
//
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                    children: <Widget>[
//                                      Container(child: new Image.asset('assets/images/fbicon.png',height: 20.0,)),
//                                      Container(child: new Text('Facebook',style: TextStyle(color: Colors.blueAccent),),),
//                                    ],
//                                  )),
//
//                        ),
//                            new SizedBox(
//                              width: 10.0,
//                            ),
//                            new Expanded(
//                              child: RaisedButton(
//                                shape: new RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(30.0),
//                                ),
//                                elevation: 4.0,
//                                color: Colors.white,
//                                  onPressed: (){
//                                    print('google login');
//                                  },
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                    children: <Widget>[
//                                      Container(child: new Image.asset('assets/images/gicon.png',height: 25.0,)),
//                                      Container(child: new Text('Google      ',style: TextStyle(color: Colors.grey),),),
//                                    ],
//                                  )),
//
//                            ),
//
//                          ],
//                        )
//                      ),
//                      new Container(
//                        margin: const EdgeInsets.only(top: 20,left: 30.0,right: 30.0),
//                        child: new TextField(
//                          controller: _username,
//                          decoration: InputDecoration(
//                              hintText: 'Phone Number OR Email Id',
//                              hintStyle: new TextStyle(fontWeight: FontWeight.bold),
//                              border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(30.0),
//                            )
//                          ),
//                        ),
//                      ),
//
//                      new Container(
//                        margin: const EdgeInsets.only(top: 20,left: 30.0,right: 30.0),
//                        child: new TextField(
//                          controller: _password,
//                          decoration: InputDecoration(
//                              hintText: 'Password',
//                              hintStyle: new TextStyle(fontWeight: FontWeight.bold),
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(30.0),
//                                  borderSide: BorderSide(color: Colors.black,width: 20.0)
//                              )
//                          ),
//                        ),
//                      ),
//
//                      new Container(
//                        height:50.0,
//                        margin: EdgeInsets.all(15.0),
//                        padding: EdgeInsets.only(left: 50.0,right: 50),
//                        child: RaisedButton(
//                          onPressed: (){
//                            loginRequest();
//                          },
//                          elevation: 4.0,
//                          highlightElevation: 1.0,
//                          child: new Text('LOGIN',style: TextStyle(color: Colors.white),),
//                          shape: new RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(30.0),
//                          ),
//                          color: Colors.deepOrange[500],
//                          animationDuration: Duration(microseconds: 10),
//                        ),
//                      ),
//
//                      new Container(
//                        margin: EdgeInsets.only(bottom: 20.0),
//                        child: new Text('OR',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
//                      ),
//                      Row(mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//
//                          Container(
//                            child: new Text('New User?',textAlign: TextAlign.center,),
//                          ),
//                          new Container(
//                            child: new InkWell(
//                              onTap: (){
//                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext contet)=>Register()));
//                              },
//                              child: Text('Register!',style: TextStyle(color:Colors.deepOrange,fontSize: 16.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
//                            ),
//                          ),
//                        ],
//                      ),
//                      new Container(
//                        margin: EdgeInsets.only(top: 20.0),
//                        child: Center(child: new Text('Forgot password?',style: TextStyle(color:Colors.deepOrange,fontSize: 16.0,fontWeight: FontWeight.bold)),),
//                      ),
//
//                    ]
//                  ),
//                ),
//              ) ,
//              ),
//        ),
//        ),
//      ),
//    );
//  }
//}
//
//class CustomButton extends StatelessWidget {
//  final String buttonText;
//
//  CustomButton({this.buttonText});
//  @override
//  Widget build(BuildContext context) {
//    return MaterialButton(
//      elevation: 4.0,
//      highlightElevation: 1.0,
//      child: new Text(buttonText,style: TextStyle(color: Colors.white),),
//      height: 50.0,
//      shape: new RoundedRectangleBorder(
//        borderRadius: new BorderRadius.circular(30.0),
//      ),
//      color: Colors.deepOrange[500],
//      animationDuration: Duration(microseconds: 10),
//
//    );
//  }
//}
//
