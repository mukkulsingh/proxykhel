import 'package:flutter/material.dart';
import './login.view.dart';
import './../Constants/theme.dart' as Theme;
import './../Constants/slideTransitions.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.ProxykhelThemeData,
      home: new Scaffold(
        body: new Center(
          child: Hero(
            tag: 'loginToRegister',
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
                      margin: const EdgeInsets.only(top: 20,left: 15.0,right: 15.0),
                      child: new TextField(
                        decoration: InputDecoration(
                            hintText: 'Full Name',
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
                        decoration: InputDecoration(
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
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.black,width: 20.0)
                            )
                        ),
                      ),
                    ),

//                      new Container(
//                        margin: const EdgeInsets.only(top: 20,left: 15.0,right: 15.0),
//                        child: new TextField(
//                          decoration: InputDecoration(
//                              hintText: 'Referral Code',
//                              hintStyle: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(30.0),
//                                  borderSide: BorderSide(color: Colors.black,width: 20.0)
//                              )
//                          ),
//                        ),
//                      ),

                    new Container(
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.only(left: 50.0,right: 50),
                      child: CustomButton(buttonText: 'REGISTER',),
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

//                        new Container(
//                          margin: EdgeInsets.only(top:20.0),
//                          child: new Text('OR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),textAlign: TextAlign.center,),
//                        ),

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
                            Navigator.of(context).pushAndRemoveUntil(SlideLeftRoute(widget: LoginScreen()),(Route<dynamic> route)=>false);
                          },
                        ),

                      ],
                    ),

                  ]
              ),
            ),
          ) ,
        ),
      ),
    );
  }
}
