import 'package:flutter/material.dart';
import 'package:proxykhel/Model/GetReferalCode.model.dart';
import 'package:share/share.dart';
class ReferAndEarn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReferAndEarnView(),
    );
  }
}

class ReferAndEarnView extends StatefulWidget {
  @override
  _ReferAndEarnViewState createState() => _ReferAndEarnViewState();
}

class _ReferAndEarnViewState extends State<ReferAndEarnView> {

  static bool _isPalgeLoading;
  static bool _dataFound;
  ReferralCodeData _referralCodeData;

  Future getReferalCode() async{
    _referralCodeData = await ReferralCodeModel.instance.getReferralCode();
    if(_referralCodeData != null){
      setState(() {
        _isPalgeLoading = false;
        _dataFound = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isPalgeLoading = true;
    _dataFound = false;
    getReferalCode();
  }

  @override
  Widget build(BuildContext context) {
    String referralCode = '';

    if(_isPalgeLoading){
      return new Center(child: new CircularProgressIndicator(),);
    }
    else
      if(_referralCodeData.refId != null){
        referralCode = _referralCodeData.refId;
      }
    return ListView(
      children: <Widget>[
        new SizedBox(height: 20.0,),
        new Center(child: new Text("How it works",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),),
        Divider(),
        Padding(padding:EdgeInsets.only(left: 4.0),child: new Text("REFER",style: TextStyle(color:Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 18.0))),
        Padding(padding:EdgeInsets.only(left: 8.0),child: new Text("Share yore referral code with your friend",style: TextStyle(color: Colors.blueGrey,fontSize: 16.0),)),
        new SizedBox(height: 20.0,),
        Padding(padding:EdgeInsets.only(left: 4.0),child: new Text("ADD",style: TextStyle(color:Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 18.0))),
        Padding(padding:EdgeInsets.only(left: 8.0),child: new Text("Your friend successfully registers to proxykhel using your referral code",style: TextStyle(color: Colors.blueGrey,fontSize: 16.0))),
        new SizedBox(height: 20.0,),
        Padding(padding:EdgeInsets.only(left: 4.0),child: new Text("EARN",style: TextStyle(color:Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 18.0))),
        Padding(padding:EdgeInsets.only(left: 8.0),child: new Text("Your friend & you both get Rs.100 Bonus",style: TextStyle(color: Colors.blueGrey,fontSize: 16.0))),

        new SizedBox(height: 20.0,),
        new Text(referralCode,style: TextStyle(color: Colors.deepOrange,fontSize: 18.0),textAlign: TextAlign.center,),
        new SizedBox(height: 20.0,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 124.0),
          child: new RaisedButton(
              child: new Text("SHARE",style: TextStyle(color: Colors.white),),
              onPressed: (){
                Share.share('Get Rs.100 Bonus in your proxykhel account by signin up using my referral link https://www.proxykhel.com/registration?r=${_referralCodeData.refId}');
              },
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
        ),
      ],
    );
  }
}
