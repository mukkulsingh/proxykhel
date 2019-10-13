import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import 'package:proxykhel/Model/GetProfileDetailModel.model.dart';
import 'package:proxykhel/Model/UploadIdProof.model.dart';
import 'package:proxykhel/Model/VerifyPhoneKyc.model.dart';
import 'package:proxykhel/Model/kyc.model.dart';
import 'package:proxykhel/Model/verifyphone.model.dart';

import 'VerifyPhoneKyc.view.dart';


class KycView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KycBody(),
    );
  }
}

class KycBody extends StatefulWidget {
  @override
  _KycBodyState createState() => _KycBodyState();
}

class _KycBodyState extends State<KycBody> {

  var _image;
  static bool _docTypeError;
  static bool _isEmailId;


  static KycStatus _kycStatus;
  static GetProfileDetailPojo _userDetail;

  static bool _emailStatus;
  static bool _idProofStatus;
  static bool _bankDetails;

  static bool _isPageLoading;
  static bool _dataFound;

  TextEditingController _holderController;
  TextEditingController _ifscContorller;
  TextEditingController _accountController;

  Future getProfileDetail()async{
    _userDetail = await GetProfileDetailModel.instance.getProfileDetail();
    if(_userDetail != null){
      setState(() {
        _isPageLoading = false;
        _dataFound = true;
      });
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      UploadIdProofModel.instance.uploadIdProof(image);
    });
  }

  @override
  void initState() {
    _holderController = new TextEditingController();
    _ifscContorller = new TextEditingController();
    _accountController = new TextEditingController();
    _kycStatus = KycModel.instance.getKycStatusData();

    getProfileDetail();

    if(_kycStatus.data.emailId == "1")
      _emailStatus = true;
    else
      _emailStatus = false;

    if(_kycStatus.data.idVerification == "1")
      _idProofStatus = true;
    else
      _idProofStatus = false;


    if(_kycStatus.data.bankVerification == "1" )
      _bankDetails = true;
    else
      _bankDetails = false;

    _isPageLoading = true;
    _dataFound = false;

    _docTypeError = true;

    _isEmailId = false;
  }
  @override
  Widget build(BuildContext context) {

    if(_isPageLoading == true){
      return new Center(child:  new CircularProgressIndicator(),);
    }

    else if(_isPageLoading == false && _dataFound == true){
      return Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.maybePop(context);
                              },
                              child: new Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 22.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: new Text('KYC',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      fontFamily: 'sans-serif-light',
                                      color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: new ExpansionTile(
                          leading: _idProofStatus?new Icon(Icons.check_circle,color: Colors.green,):new Icon(Icons.error,color: Colors.red,),
                          title: Text('Basic information'),
                          children: <Widget>[
                            new ListTile(
                              onTap:()async{
                                if(_userDetail.data.emailId.contains("@")){

                                }else{
                                  int min = 1000;
                                  int max = 9999;
                                  int otp = min + (Random().nextInt(max-min));
                                  VerifyPhoneKycModel.instance.setOTP(otp);
                                  VerifyPhoneKycModel.instance.setContact(int.parse(_userDetail.data.emailId));
                                  var msg = "Dear User, your OTP is ${VerifyPhoneKycModel.instance.getOTP()} to activate your account on Proxy Khel.";


                                  http.Response response = await http.get("https://api.msg91.com/api/sendhttp.php?mobiles=${_userDetail.data.emailId}&authkey=281414AsacFSKmekD5d0773a5&route=4&sender=PRKHEL&message=$msg&country=91");
                                  if(response.statusCode == 200){
                                    SnackBar snackbar = new SnackBar(content: Text('OTP sent'),duration: Duration(seconds: 1),);
                                    Scaffold.of(context).showSnackBar(snackbar);
                                  }
                                  Future.delayed(const Duration(milliseconds: 1200));

                                  Navigator.push(context, SlideLeftRoute(widget: VerifyPhoneKyc()));
                                }
                              },
                              trailing: _emailStatus? Icon(Icons.check_circle,color: Colors.green,):Icon(Icons.error,color: Colors.red,),
                              title: Text("User Id"),
                              subtitle: Text("${_userDetail.data.emailId}"),
                            ),
                            new ListTile(
                              onTap:(){

                              },
                              trailing: _emailStatus? Icon(Icons.check_circle,color: Colors.green,):Icon(Icons.error,color: Colors.red,),
                              title: Text("Date of birth"),
                              subtitle: Text("${_userDetail.data.dateofbirth}"),
                            )

                          ],
                        ),
                      ),
                      _idProofStatus?new Container(
                        child: new ExpansionTile(
                          leading: new Icon(Icons.check_circle,color: Colors.green,),
                          title: Text('Id number'),
                          children: <Widget>[
                            new ListTile(
                              onTap:(){

                              },
                              trailing: Icon(Icons.check_circle,color: Colors.green,),
                              title: Text(""),
                              subtitle: Text(""),
                            ),
                          ],
                        ),
                      ):                          new Container(
                        child: new ExpansionTile(
                          leading: new Icon(Icons.check_circle,color: Colors.green,),
                          title: Text("Identity Proof"),
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new DropdownButton(
                                        value: UploadIdProofModel.instance.getType,
                                        items: [
                                          DropdownMenuItem(
                                            value: 1,
                                            child: new Text("Aadhar Card"),
                                          ),
                                          DropdownMenuItem(
                                            value: 2,
                                            child: new Text("Pan Card"),
                                          )
                                        ],
                                        hint: Text("Select Id Type"),
                                        onChanged: (value){
                                          setState(() {
                                            UploadIdProofModel.instance.setType(value);
                                          });
                                        }),
                                    _docTypeError?new Container(child:new Text("Required",style: TextStyle(color: Colors.red,fontSize: 10.0),)):new Container(),
                                  ],
                                ),
                                new Container(
                                  height: 25.0,
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: new RaisedButton(
                                    onPressed: (){
                                      if(UploadIdProofModel.instance.getType == null){
                                        setState(() {
                                          _docTypeError = true;
                                        });
                                      }
                                      else{
                                        setState(() {
                                          _docTypeError = true;
                                        });
                                        getImage();
                                      }
                                    },
                                    child: new Text("upload",style: TextStyle(color: Colors.white),),
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      new Container(
                        child: new ExpansionTile(
                          title: Text("Bank Details"),
                          leading: _bankDetails?new Icon(Icons.check_circle,color: Colors.green,):new Icon(Icons.error,color: Colors.red,),
                          children: <Widget>[
                            ListTile(
                              title: Text("Holder Name"),
                              leading: Icon(Icons.person),
                              subtitle: new TextField(
                                controller: _holderController,
                                decoration: InputDecoration(
                                    labelText: "Eg: Ramesh"
                                ),
                              ),
                            ),

                            ListTile(
                              title: Text("Account Number"),
                              leading: Icon(Icons.account_circle),
                              subtitle: TextField(
                                controller: _accountController,
                                decoration: InputDecoration(
                                    labelText: "Eg: 120003015456"
                                ),
                              ),
                            ),

                            ListTile(
                              title: Text("IFSC Code"),
                              leading: Icon(Icons.account_balance),
                              subtitle: TextField(
                                controller: _ifscContorller,
                                decoration: InputDecoration(
                                    labelText: "Eg: SBIO00001235"
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
    return new Container();
  }
}
