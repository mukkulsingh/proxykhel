import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import 'package:proxykhel/Model/GetAadharAndPanStatus.model.dart';
import 'package:proxykhel/Model/GetProfileDetailModel.model.dart';
import 'package:proxykhel/Model/SendVerificationMail.model.dart';
import 'package:proxykhel/Model/UploadIdProof.model.dart';
import 'package:proxykhel/Model/VerifyPhoneKyc.model.dart';
import 'package:proxykhel/Model/insertBankDetails.model.dart';
import 'package:proxykhel/Model/kyc.model.dart';
import 'package:proxykhel/Model/uploadPassbook.model.dart';

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
  var _PanImage;
  var _passbookImage;

  static bool _docTypeError;
  static bool _isEmailId;
  static bool _aadharSubmited;
  static bool _panSubmited;
  static bool _passbookUploaded;
  static bool _passbookStatus;

  static KycStatus _kycStatus;
  static GetProfileDetailPojo _userDetail;
  static GetAadharAndPanStatus _getAadharAndPanStatus;

  static bool _emailStatus;
  static bool _idProofStatus;
  static bool _bankDetails;

  static bool _isPageLoading;
  static bool _dataFound;

  TextEditingController _holderController;
  TextEditingController _ifscContorller;
  TextEditingController _accountController;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future getProfileDetail()async{
    _userDetail = await GetProfileDetailModel.instance.getProfileDetail();
    _getAadharAndPanStatus = await GetAadharAndPanStatusModel.instance.getAadharAndPanStatus();
    if(_userDetail != null && _getAadharAndPanStatus != null){
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
      initState();
    });
  }


  Future getPanImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _PanImage = image;
      UploadIdProofModel.instance.uploadPan(image);
      initState();
    });
  }
  Future getPassbookImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _passbookImage = image;
    });
  }


  @override
  void initState() {
    _holderController = new TextEditingController();
    _ifscContorller = new TextEditingController();
    _accountController = new TextEditingController();
    _kycStatus = KycModel.instance.getKycStatusData();

    _aadharSubmited = false;
    _panSubmited = false;

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
    String _imageName = '';

    if(_passbookImage !=  null){
      _imageName = _passbookImage.path.split("/").last;
    }

    if(_isPageLoading == true){
      return new Center(child:  new CircularProgressIndicator(),);
    }

    else if(_isPageLoading == false && _dataFound == true){
      if(_idProofStatus == false){
        if(_getAadharAndPanStatus.data.aadharImage == null || _getAadharAndPanStatus.data.aadharImage == '')
          _aadharSubmited = false;
        else{
          _aadharSubmited = true;
        }
        if(_getAadharAndPanStatus.data.panImage == null || _getAadharAndPanStatus.data.panImage == '' ){
          _panSubmited = false;
        }else{
          _panSubmited  =true;
        }
      }
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
                          leading: _emailStatus?new Icon(Icons.check_circle,color: Colors.green,):new Icon(Icons.error,color: Colors.red,),
                          title: Text('Basic information'),
                          children: <Widget>[
                            new ListTile(
                              onTap:()async{
                                if(_emailStatus){

                                }

                                else if(!_emailStatus){
                                  if(_userDetail.data.emailId.contains("@")){
                                    showDialog(context: context,
                                        builder: (context){
                                          return new AlertDialog(
                                            title: new Text("Success",style: TextStyle(color: Colors.green),),
                                            content: new Text("Verification mail sent"),
                                            actions: <Widget>[
                                              OutlineButton(
                                                child: new Text("OK",style: TextStyle(color: Colors.deepOrange),),
                                                borderSide: BorderSide(
                                                    color: Colors.deepOrange
                                                ),
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                    SendVerficationMail.instance.setEmail(_userDetail.data.emailId);
                                    SendVerficationMail.instance.sendVerificationMail();
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
                                }

                              },
                              trailing: _emailStatus? Icon(Icons.check_circle,color: Colors.green,):Icon(Icons.error,color: Colors.red,),
                              title: Text("User Id"),
                              subtitle: Text("${_userDetail.data.emailId}"),
                            ),
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
                              title: Text("${_getAadharAndPanStatus.data.aadharNo}"),
                              subtitle: Text("${_getAadharAndPanStatus.data.panNo}"),
                            ),
                          ],
                        ),
                      ): new Container(
                        child: new ExpansionTile(
                          leading: new Icon(Icons.error,color: Colors.red,),
                          title: Text("Identity Proof"),
                          children: <Widget>[
                            _aadharSubmited?new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(flex:1,child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: new Text("Aadhar submitted for verification"))),
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: new RaisedButton(
                                      onPressed: (){
                                        getImage();
                                      },
                                      color: Colors.deepOrange,
                                      child: new Text("Upload again",style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                              ],
                            ):new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(flex:1,child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: new Text("Aadhar not verified"))),
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: new RaisedButton(
                                      onPressed: (){
                                        getImage();

                                      },
                                      color: Colors.deepOrange,
                                      child: new Text("Upload Aadhar",style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            _panSubmited?new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(flex:1,child: Container(margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: new Text("Pan submited for verification"))),
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: new RaisedButton(
                                      color: Colors.deepOrange,
                                      onPressed: (){
                                        getPanImage();
                                      },
                                      child: new Text("Upload again",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                )
                              ],
                            ):
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(flex:1,child: Container(margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: new Text("Pan not verified"))),
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: new RaisedButton(
                                      color: Colors.deepOrange,
                                      onPressed: (){
                                        getPanImage();
                                      },
                                      child: new Text("Upload Pan",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                )
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
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Text("Passbook not verified\n ${_imageName}"),
                                Container(
                                  width: 150.0,
                                  child: new RaisedButton(
                                    onPressed: (){
                                      getPassbookImage();
                                    },
                                    child: new Text("Upload Passbook"),
                                  ),
                                )
                              ],
                            ),
                            new Center(
                              child: new RaisedButton(
                                  onPressed: () async{
                                    if(_accountController.text == null || _holderController == null || _ifscContorller == null
                                      || _passbookImage == null
                                    ){
                                      SnackBar snackbar  = new SnackBar(content: Text("Please fill all the details"));
                                      _scaffoldKey.currentState.showSnackBar(snackbar);
                                    }
                                    InsertBankDetailsModel.instance.setAccount(_accountController.text);
                                    InsertBankDetailsModel.instance.setHolder(_holderController.text);
                                    InsertBankDetailsModel.instance.setIfsc(_ifscContorller.text);
                                    showDialog(context: context,builder: (context){
                                      return SimpleDialog(
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              new SizedBox(width: 10.0,),
                                              new CircularProgressIndicator(),
                                              new SizedBox(width: 10.0,),
                                              new Text("Please wait..."),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                                    if(await InsertBankDetailsModel.instance.insertBankDetails(_passbookImage)){
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            title: Text("Success",style: TextStyle(color: Colors.green),),
                                            content: Text("Bank details added successfully"),
                                            actions: <Widget>[
                                              OutlineButton(

                                                child: new Text("OK",style: TextStyle(color: Colors.deepOrange),),
                                                borderSide: BorderSide(
                                                  color: Colors.deepOrange
                                                ),
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        }
                                      );
                                    }

                                  },
                                child: new Text("SUBMIT",style: TextStyle(color:Colors.white),),
                                color: Colors.deepOrange,
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
