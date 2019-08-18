import 'package:flutter/material.dart';
import './../Model/savedpref.model.dart';
import './../Model/kyc.model.dart';
import 'package:http/http.dart' as http;

class KycStatusView extends StatefulWidget {
  @override
  _KycStatusViewState createState() => _KycStatusViewState();
}

class _KycStatusViewState extends State<KycStatusView> {
  
  static bool _verify;
  static String emailId;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KycStatus kycStatus = KycModel.instance.getKycStatusData();
    if(kycStatus.data.emailId == '0'){
      _verify = true;
    }
    else{
      _verify = false;
    }
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
          onPressed: (){

            if(emailId.contains('@')){
              print('email');
            }else{
              print('phone');
            }

          },
          child: new Text('!Verify',style: TextStyle(color: Colors.black),),
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
                child: Padding(padding: EdgeInsets.only(right: 12.0),child: _verify?verifyButton:new Icon(Icons.verified_user,color: Colors.green,),),
              )
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text('KYC Status',style: TextStyle(color: Colors.white),),
      ),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          contactVerify
        ],
      )
    );
  }
}
