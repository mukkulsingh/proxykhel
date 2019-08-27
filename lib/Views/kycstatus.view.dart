import 'package:flutter/material.dart';
import './../Model/savedpref.model.dart';
import './../Model/kyc.model.dart';
import './kycphoneverification.view.dart';
import './../Constants/slideTransitions.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker_modern/image_picker_modern.dart';

class KycStatusView extends StatefulWidget {
  @override
  _KycStatusViewState createState() => _KycStatusViewState();
}

class _KycStatusViewState extends State<KycStatusView> {



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static var _image;
  static bool _verify;
  static bool _verifyAadhar;
  static bool _verifyPan;
  static String emailId;
  static bool _isLoading=false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KycStatus kycStatus = KycModel.instance.getKycStatusData();
    if(kycStatus.data.idVerification == '0'){
      _verify = true;
    }
    else{
      _verify = false;
    }
    if(kycStatus.data.idVerification == '0'){
      _verifyAadhar = true;
      _verifyPan=true;
    }
    else{
      _verifyAadhar = false;
      _verifyPan=true;
    }
    _isLoading = false;
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  
  @override
  Widget build(BuildContext context) {



    KycStatus kycStatus = KycModel.instance.getKycStatusData();
    if(kycStatus.data.emailId == '0'){
      _verify = true;
    }
    else{
      _verify = false;
    }
    
    
    final verifyButton = Container(
      height: 40.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        color: Colors.yellow[700],
          onPressed: () async {
            if(emailId.contains('@')){
              //send verification email todo

              setState(() {
                _isLoading = true;
              });

              http.Response response = await http.post("https://www.proxykhel.com/android/sendverificationmail.php",body: {
                "userId":emailId
              });
              if(response.statusCode == 200){
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Mail Sent',style: TextStyle(color: Colors.red,fontSize: 22.0),),
                        content:  Text('Check your email to verify your account',style: TextStyle(fontSize: 18.0),),

                        actions: <Widget>[
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new InkWell(
                                onTap:(){Navigator.of(context).pop();},
                                child: new Text("Ok",style: TextStyle(fontSize: 18.0,color: Colors.deepOrange),textAlign: TextAlign.center,),
                              ),

                              new Container(child: new Text("                                        "),),

                            ],

                          ),


                        ],
                      );
                    });
                setState(() {
                  _isLoading = false;
                });
              }else{
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Mail Error',style: TextStyle(color: Colors.red,fontSize: 22.0),),
                        content: Row(
                          children: <Widget>[
                            Text('Mail not sent. Try again',style: TextStyle(fontSize: 18.0),),
                          ],
                        ),
                        actions: <Widget>[
                          new InkWell(
                            onTap:(){Navigator.of(context).pop();},
                            child: new Text("Ok",style: TextStyle(fontSize: 18.0,color: Colors.deepOrange),),
                          )

                        ],
                      );
                    });
              }


            }else{

              setState(() {
                _isLoading = true;
              });

              //send otp todo
              int min = 1000;
              int max = 9999;
              int otp = min + (Random().nextInt(max-min));
              var msg = "Dear USER, your OTP is $otp to activate your account on Proxy Khel.";


              http.Response response = await http.get("https://api.msg91.com/api/sendhttp.php?mobiles=$emailId&authkey=281414AsacFSKmekD5d0773a5&route=4&sender=PRKHEL&message=$msg&country=91");
              if(response.statusCode == 200){
                SnackBar snackBar = new SnackBar(content: Text("OTP sent"),duration: Duration(seconds: 1),);
               _scaffoldKey.currentState.showSnackBar(snackBar);
                Future.delayed(const Duration(milliseconds: 1500), () {
                  Navigator.push(context,SlideLeftRoute(widget: KycPhoneVerification(contact: emailId, otp: otp,)) );
                });

              }else{

                SnackBar snackBar = new SnackBar(content: Text("OTP not sent . Try again"),duration: Duration(seconds: 1),);
                _scaffoldKey.currentState.showSnackBar(snackBar);
                setState(() {
                  _isLoading = false;
                });
              }
            }

          },
          child: new Text('Verify!',style: TextStyle(color: Colors.black),),
      ),
    );

    final verifyAadharButton = new Container(
      child: FlatButton(
        color: Colors.yellow[700],
        onPressed: (){},
          child:new Text('Verify!',style: TextStyle(color: Colors.black),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final verifyPancardButton = new Container(
      child: FlatButton(
        color: Colors.yellow[700],
        onPressed: (){
          getImage();
        },
        child:new Text('Verify!',style: TextStyle(color: Colors.black),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final contactVerify = new Container(
      height: 80.0,
      child: new InkWell(
        child: new Card(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Expanded(
                flex: 3,
                child:  Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FutureBuilder(
                      future: SavedPref.instance.getEmailId(),
                      builder: (context,snapshot){
                        switch(snapshot.connectionState){

                          case ConnectionState.none:
                          return new Container(

                            child: new Stack(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                              ],
                            ),
                          );
                          break;
                          case ConnectionState.active:
                          return new Container(

                            child: new Stack(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                              ],
                            ),
                          );
                          break;
                          case ConnectionState.waiting:
                          return new Container(

                            child: new Stack(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                              ],
                            ),
                          );
                          break;
                          case ConnectionState.done:
                          if(snapshot.hasError){
                          return new Container(

                            child: new Stack(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                              ],
                            ),
                          );
                          }
                          else if(snapshot.hasData){
                            emailId = snapshot.data;
                            return new Text('$emailId',style: new TextStyle(fontSize: 18.0),);
                          }
                          else{
                            return new Container(

                              child: new Stack(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                ],
                              ),
                            );
                          }

                        }
                      }),
                ),
              ),
              new Expanded(
                flex: 1,
                child: Padding(padding: EdgeInsets.only(right: 12.0),child: _verify? _isLoading?new Center(child: new CircularProgressIndicator(),):verifyButton:new Icon(Icons.verified_user,color: Colors.green,),),
              )
            ],
          ),
        ),
      ),
    );

    final aadharId = new Container(
      height: 80.0,
      child: new Card(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Expanded(
              flex: 3,
              child:  Padding(
                padding: const EdgeInsets.all(12.0),
                child:  new Text('Aadhar ID',style: new TextStyle(fontSize: 18.0),),

              ),
            ),
            new Expanded(
              flex: 1,
              child: Padding(padding: EdgeInsets.only(right: 12.0),child: _verifyAadhar? _isLoading?new Center(child: new CircularProgressIndicator(),):verifyAadharButton:new Icon(Icons.verified_user,color: Colors.green,),),
            )
          ],
        ),
      ),
    );

    final pancardId = new Container(
      height: 80.0,
      child: new Card(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Expanded(
              flex: 3,
              child:  Padding(
                padding: const EdgeInsets.all(12.0),
                child:  new Text('Pancard ID',style: new TextStyle(fontSize: 18.0),),

              ),
            ),
            new Expanded(
              flex: 1,
              child: Padding(padding: EdgeInsets.only(right: 12.0),child: _verifyPan? _isLoading?new Center(child: new CircularProgressIndicator(),):verifyPancardButton:new Icon(Icons.verified_user,color: Colors.green,),),
            )
          ],
        ),
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text('KYC Status',style: TextStyle(color: Colors.white),),
      ),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          contactVerify,
          pancardId,
          new Container(
            child: _image == null ? Text('No image selected.') : Image.file(_image),
          )
        ],
      )
    );
  }
}
