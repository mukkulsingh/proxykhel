import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import './../Model/GetProfileDetailModel.model.dart';
import './../Model/kyc.model.dart';
import './../Model/UpdateProfileModel.model.dart';
import './KycView.view.dart';

class MyProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePage(),
    );
  }
}



class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  GetProfileDetailPojo getProfileDetailPojo;
  KycStatus kycStatus;
  static bool _isLoading;
  static bool _profileNotFound;
  static bool _kycStatusNotFound;
  static bool _kycVerified;
  static String _state;


  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _mobileController;
  TextEditingController _DobController;


  Future<void> getProfileDetail() async {
    setState(() {
      _isLoading = true;
    });
    getProfileDetailPojo = await GetProfileDetailModel.instance.getProfileDetail();
    kycStatus = await KycModel.instance.getKycStatus();
    if(getProfileDetailPojo != null){
      _DobController.text = getProfileDetailPojo.data.dateofbirth??'';
      _nameController.text = getProfileDetailPojo.data.fullName??'';
      _emailController.text = getProfileDetailPojo.data.emailId??'';
      _mobileController.text = getProfileDetailPojo.data.mobileNo??'';
      if(getProfileDetailPojo.data.state == '' || getProfileDetailPojo.data.state == null){
        _state = null;
      }else
        _state = getProfileDetailPojo.data.state;
      if(kycStatus != null){
        setState(() {
          _isLoading = false;

        });
      }
      else{
        _isLoading = false;
        _kycStatusNotFound=true;
      }

    }else{
      _isLoading = false;
      _profileNotFound = true;
    }
  }

  Future _dob(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 10)),
        firstDate: DateTime(1950,1),
        lastDate: DateTime.now().subtract(Duration(days: 9)));
    if (picked != null)
      setState(() {
        _DobController.text = picked.day.toString()+'-'+picked.month.toString()+'-'+picked.year.toString();
      });
  }


  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _profileNotFound = false;
    _kycStatusNotFound = false;
    _kycVerified = false;
    _nameController = new TextEditingController();
    _emailController = new TextEditingController();
    _mobileController = new TextEditingController();
    _DobController = new TextEditingController();
    getProfileDetail();
  }
  @override
  Widget build(BuildContext context) {
    if(!_isLoading){
      if(kycStatus.data.status == "1"){
        _kycVerified = true;
      }else{
        _kycVerified = false;
      }
      List<DropdownMenuItem<String>> dropDownItems = [
        DropdownMenuItem<String>(
          child: Text("Arunachal Pradesh"),
          value: "AR",
        ),
        DropdownMenuItem<String>(
          child: Text("Bihar"),
          value: "BR",
        ),
        DropdownMenuItem<String>(
          child: Text("Chhattisgarh"),
          value: "CT",
        ),
        DropdownMenuItem<String>(
          child: Text("Goa"),
          value: "GA",
        ),
        DropdownMenuItem<String>(
          child: Text("Gujarat"),
          value: "GJ",
        ),
        DropdownMenuItem<String>(
          child: Text("Haryana"),
          value: "HR",
        ),
        DropdownMenuItem<String>(
          child: Text("Himachal Pradesh"),
          value: "HP",
        ),
        DropdownMenuItem<String>(
          child: Text("Jammu & Kashmir"),
          value: "JK",
        ),
        DropdownMenuItem<String>(
          child: Text("Jharkhand"),
          value: "JH",
        ),
        DropdownMenuItem<String>(
          child: Text("Karnataka"),
          value: "KA",
        ),
        DropdownMenuItem<String>(
          child: Text("Kerala"),
          value: "KL",
        ),
        DropdownMenuItem<String>(
          child: Text("Madhya Pradesh"),
          value: "MP",
        ),
        DropdownMenuItem<String>(
          child: Text("Maharashtra"),
          value: "MH",
        ),
        DropdownMenuItem<String>(
          child: Text("Manipur"),
          value: "MN",
        ),
        DropdownMenuItem<String>(
          child: Text("Meghalaya"),
          value: "ML",
        ),
        DropdownMenuItem<String>(
          child: Text("Mizoram"),
          value: "MZ",
        ),
        DropdownMenuItem<String>(
          child: Text("Punjab"),
          value: "PB",
        ),
        DropdownMenuItem<String>(
          child: Text("Rajasthan"),
          value: "RJ",
        ),
        DropdownMenuItem<String>(
          child: Text("Sikkim"),
          value: "SK",
        ),
        DropdownMenuItem<String>(
          child: Text("Tripura"),
          value: "TR",
        ),
        DropdownMenuItem<String>(
          child: Text("Uttarakhand"),
          value: "UK",
        ),
        DropdownMenuItem<String>(
          child: Text("Uttar Pradesh"),
          value: "UP",
        ),
        DropdownMenuItem<String>(
          child: Text("West Bengal"),
          value: "WB",
        ),
      ];


      return new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 250.0,
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap:(){
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
                                child: new Text('PROFILE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        fontFamily: 'sans-serif-light',
                                        color: Colors.black)),
                              )
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: new Stack(fit: StackFit.loose, children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: new ExactAssetImage(
                                          'assets/images/as.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                        Padding(
                            padding: EdgeInsets.only(top: 110.0, right: 0.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, SlideLeftRoute(widget: KycView()));
                              },
                              child: Center(child: _kycVerified?new Chip(
                                elevation: 6.0,
                                backgroundColor: Colors.green,
                                label:Text("KYC Verified"),
                                labelStyle: TextStyle(color: Colors.white),
                              ):new Chip(
                                elevation: 6.0,
                                  backgroundColor: Colors.red,
                                  label:Text("KYC Pending"),
                                  labelStyle: TextStyle(color: Colors.white),
                              )),
                            ),
//                            child: new Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                new CircleAvatar(
//                                  backgroundColor: Colors.deepOrange,
//                                  radius: 25.0,
//                                  child: new Icon(
//                                    Icons.error,
//                                    color: Colors.white,
//                                  ),
//                                )
//                              ],
//                            )
                        ),
                        ]),
                      )
                    ],
                  ),
                ),
                new Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Parsonal Information',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _status ? _getEditIcon() : new Container(),
                                  ],
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller:_nameController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter Your Name",
                                    ),
                                    enabled: !_status,
                                    autofocus: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'User ID',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    onTap: (){
                                      SnackBar snackbar = new SnackBar(content: Text("Read Only"),duration: Duration(seconds: 1),);
                                      Scaffold.of(context).showSnackBar(snackbar);
                                    },
                                    controller:_emailController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Email ID"),
                                    readOnly: true,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller:_mobileController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Mobile Number"),
                                    enabled: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'Date Of Birth',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'State',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: new TextField(
                                      onTap:(){_dob(context);},
                                      controller: _DobController,
                                      decoration: const InputDecoration(
                                          hintText: "Enter DOB"),
                                      enabled: !_status,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: new DropdownButton(
                                        items: dropDownItems,
                                        value: _state,
                                        hint: Text("Select State"),

                                        onChanged: (value){
                                          setState(() {
                                            _state = value;
                                            UpdateProfileModel.instance.setState(value);
                                          });
                                        }),
                                  ),
//                                  child: new TextField(
//                                    controller: _stateController,
//                                    decoration: const InputDecoration(
//                                        hintText: "Enter State"),
//                                    enabled: !_status,
//                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        !_status ? _getActionButtons() : new Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }else{
     return new Center(child: new CircularProgressIndicator(),);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _DobController.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: (){
                      if(_nameController.text == null || _nameController.text == ''
                        || _mobileController.text == null || _mobileController.text == ''
                        || UpdateProfileModel.instance.getState == null
                        || _DobController.text == null || _DobController.text == ''
                      ){
                        SnackBar snackbar = new SnackBar(content: Text("Please fill all details"),duration: Duration(seconds: 1),);
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                      else{
                        setState(() async {
                          showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)
                                ),
                                backgroundColor: Colors.transparent,
                                content: new Center(child: CircularProgressIndicator(),),
                              );
                            }
                          );
                          UpdateProfileModel.instance.setMobileNo(_mobileController.text);
                          UpdateProfileModel.instance.setFullName(_nameController.text);
                          UpdateProfileModel.instance.setDob(_DobController.text);
                          int num = await UpdateProfileModel.instance.updateProfile();
                          if(num == 1){
                            setState(() {
                              Navigator.of(context).maybePop();
                              _status = true;
                              FocusScope.of(context).requestFocus(new FocusNode());
                            });
                          }else if(num == 2){
                            setState(() {
                              Navigator.of(context).maybePop();
                              SnackBar snackbar = new SnackBar(content: Text("Duplicate entries"),duration: Duration(seconds: 1),);
                              Scaffold.of(context).showSnackBar(snackbar);
                              _status = true;
                              FocusScope.of(context).requestFocus(new FocusNode());
                            });
                          }else {
                            setState(() {
                              Navigator.of(context).maybePop();
                              SnackBar snackbar = new SnackBar(content: Text("Error updating profile"),duration: Duration(seconds: 1),);
                              Scaffold.of(context).showSnackBar(snackbar);
                              _status = true;
                              FocusScope.of(context).requestFocus(new FocusNode());
                            });
                          }
                        });


                      }

                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}