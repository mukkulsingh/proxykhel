import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proxykhel/Model/UpdateProfileModel.model.dart';


class EditPersonalDetail extends StatefulWidget {
  @override
  _EditPersonalDetailState createState() => _EditPersonalDetailState();
}

class _EditPersonalDetailState extends State<EditPersonalDetail> {

  static bool _isLoading;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_)=>FullNameProvider(),),
        ChangeNotifierProvider(builder: (_)=>MobileNoProvider(),),
        ChangeNotifierProvider(builder: (_)=>SelectStateProvider(),),
        ChangeNotifierProvider(builder: (_)=>DobProvider(),),

      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: new Text('Edit Personal Details',style: TextStyle(color: Colors.white)),
        ),
        body:new ListView(
          children: <Widget>[
            SizedBox(height: 20.0,),
            FullName(),
            SizedBox(height: 20.0,),
            MobileNo(),
            SizedBox(height: 20.0,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: SelectState()),
            SizedBox(height: 20.0,),
            Dob(),
            SizedBox(height: 20.0,),
            new Stack(
              children: <Widget>[
                _isLoading?new Center(child: new CircularProgressIndicator(),):new Center(
                  child:  new Container(
                    height: 45.0,
                    child: new RaisedButton(
                      color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)
                        ),
                        child: new Text("Update Profile",style: TextStyle(color: Colors.white),),
                        onPressed: ()async{
                          setState(() {
                            _isLoading = true;
                          });
                          int num = await UpdateProfileModel.instance.updateProfile();
                          if(num == 1){
                            SnackBar snackbar = new SnackBar(content: Text("Profile successfully updated"),duration: Duration(seconds: 1),);
                            _scaffoldKey.currentState.showSnackBar(snackbar);
                            Future.delayed(Duration(seconds: 2),(){
                              Navigator.maybePop(context);
                            });
                          }
                          if(num == 2){
                            SnackBar snackbar = new SnackBar(content: Text("Please make changes in profile details"),duration: Duration(seconds: 1),);
                            _scaffoldKey.currentState.showSnackBar(snackbar);
                            setState(() {
                              _isLoading = false;
                            });
//                            Future.delayed(Duration(seconds: 2),(){
//                              Navigator.maybePop(context);
//                            });
                          }
                          if(num == 3){
                            SnackBar snackbar = new SnackBar(content: Text("Error updating profile.Try again"),duration: Duration(seconds: 1),);
                            _scaffoldKey.currentState.showSnackBar(snackbar);
//                            Future.delayed(Duration(seconds: 2),(){
//                              Navigator.maybePop(context);
//                            });
                          }
                        }
                        ),
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}

class FullNameProvider extends ChangeNotifier{

  static String _fullName;

  static bool _error=false;

  void setFulName(String fullName){
    _fullName = fullName;
    UpdateProfileModel.instance.setFullName(_fullName);
    if(_fullName==''||_fullName==null){
      _error = true;
      notifyListeners();
    }else{
      _error = false;
      notifyListeners();
    }
    notifyListeners();
  }
  get getFullName=>_fullName;
  get getError=>_error;
}

class FullName extends StatefulWidget {
  @override
  _FullNameState createState() => _FullNameState();
}

class _FullNameState extends State<FullName> {
  @override
  Widget build(BuildContext context) {
    FullNameProvider fullNameProvider = new FullNameProvider();
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Full Name",
          errorText: fullNameProvider.getError?"Invalid input":'',
        ),
        onChanged: (value){
          fullNameProvider.setFulName(value);
        },

      ),
    );
  }
}


class MobileNoProvider extends ChangeNotifier{

  static String _mobileNo;
  static bool _error=false;
  void setMobileNo(String mobile){
    _mobileNo = mobile;
    UpdateProfileModel.instance.setMobileNo(_mobileNo);
    if(_mobileNo == '' || _mobileNo == null){
      _error = true;
      notifyListeners();
    }else{
      _error = false;
      notifyListeners();
    }
    notifyListeners();
  }

  get getError=>_error;
}

class MobileNo extends StatefulWidget {
  @override
  _MobileNoState createState() => _MobileNoState();
}

class _MobileNoState extends State<MobileNo> {
  @override
  Widget build(BuildContext context) {
    MobileNoProvider mobileNoProvider = new MobileNoProvider();
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Mobile No",
          errorText: mobileNoProvider.getError?"Invalid input":'',

        ),
        onChanged: (value){
          mobileNoProvider.setMobileNo(value);
        },

      ),
    );
  }
}


class SelectStateProvider extends ChangeNotifier{

  static String _state;

  void setState(String state){
    _state = state;
    UpdateProfileModel.instance.setState(_state);
    notifyListeners();
  }

  get getState=>_state;
}

class SelectState extends StatefulWidget {
  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  @override
  Widget build(BuildContext context) {
    SelectStateProvider selectStateProvider = new SelectStateProvider();

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

    return DropdownButton<String>(
      value: selectStateProvider.getState,
      isExpanded: true,
      items: dropDownItems,
      onChanged: (value){
        setState(() {
          selectStateProvider.setState(value);
        });
      },
      hint: Text("Select your state",style: TextStyle(color: Colors.deepOrange),),
    );
  }
}


class DobProvider extends ChangeNotifier{
  static DateTime _dob;

  void setDob(DateTime dob){
    _dob = dob;
    UpdateProfileModel.instance.setDob(_dob.day.toString()+'-'+_dob.month.toString()+'-'+_dob.year.toString());
    notifyListeners();
  }

  get getdob=>_dob;
}

class Dob extends StatefulWidget {
  @override
  _DobState createState() => _DobState();
}

class _DobState extends State<Dob> {

  static DateTime _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    DobProvider dobProvider = new DobProvider();


    Future<DateTime> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(1960,1), lastDate: DateTime(DateTime.now().year,DateTime.now().month+1,DateTime.now().day));
      if(picked != null && picked != _selectedDate){
        _selectedDate = picked;

        setState(() {
          dobProvider.setDob(_selectedDate);
        });
      }
      return _selectedDate;
    }

    return Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text('Select Date Of Birth',style: TextStyle(color: Colors.deepOrange,fontSize: 18.0),),
            FlatButton(
              onPressed: () {_selectDate(context);},
              child: Text(_selectedDate.day.toString()+'-'+_selectedDate.month.toString()+'-'+_selectedDate.year.toString(),style: TextStyle(fontSize:18.0 ),),
            ),
          ],
        )
    );
  }
}
