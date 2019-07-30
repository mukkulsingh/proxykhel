import 'package:flutter/material.dart';


import './../main.dart';
void main()=>runApp(Register());

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorDark: Colors.deepOrange,
        primaryColor: Colors.black,
        accentColor: Colors.orangeAccent,
        buttonColor: Colors.orangeAccent,
      ),
      home: Builder(
        builder:(context)=>
        new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
          ),
          child:new Scaffold(
            backgroundColor: Colors.transparent,
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
//                        new Container(
//                            margin: const EdgeInsets.only(left: 15.0,right: 15.0),
//                            height: 60.0,
//                            child: new Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                new Expanded(
//                                  child: new FlatButton(onPressed: (){
//                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//                                  },
//
//                                    highlightColor: Colors.deepOrange,
//                                    color: Colors.white,
//                                    child: new Text('LOGIN'),
//                                  ),
//                                ),
//                                new Expanded(child: new FlatButton(onPressed: (){
//
//                                },
//                                  highlightColor: Colors.deepOrange,
//                                  color: Colors.deepOrange,
//                                  child: new Text('REGISTER',style: TextStyle(color: Colors.white),),
//
//                                ),)
//
//                              ],
//                            )
//                        ),
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

                        new Container(
                          margin: const EdgeInsets.only(top: 20,left: 15.0,right: 15.0),
                          child: new TextField(
                            decoration: InputDecoration(
                                hintText: 'Referral Code',
                                hintStyle: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(color: Colors.black,width: 20.0)
                                )
                            ),
                          ),
                        ),

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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
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
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
      },
    );
  }
}

