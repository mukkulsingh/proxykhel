import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {

  final GlobalKey<ScaffoldState> _scaffolKey = new GlobalKey<ScaffoldState>();

  static String _fullName;
  static bool _fullNameError;
  static String _contact;
  static bool _contactError;
  static String _state;
  static DateTime _selectedDate;
  static bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullName='';
    _contact='';
    _fullNameError = false;
    _contactError = false;
    _selectedDate = DateTime.now();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {


    Future<DateTime> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(1960,1), lastDate: DateTime(DateTime.now().year,DateTime.now().month+1,DateTime.now().day));
      if(picked != null && picked != _selectedDate){
        _selectedDate = picked;
        setState(() {

        });
      }
      return _selectedDate;
    }

    final fullName = new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Full Name",
          errorText: _fullNameError?"Invalid input":'',
        ),
        onChanged: (value){
          _fullName = value;
          setState(() {
            _fullNameError=false;
          });
        },

      ),
    );

    final mobileNo = new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Mobile No",
          errorText: _contactError?"Invalid input":'',

        ),
        onChanged: (value){
          _contact = value;
          setState(() {
            _contactError = false;
          });
        },

      ),
    );



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

    final selectState = DropdownButton<String>(
      value: _state,
      isExpanded: true,
      items: dropDownItems,
      onChanged: (value){
        setState(() {
          _state = value;
        });
      },
    );


    final dob =  Container(
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

    final submit = new Container(
      margin: EdgeInsets.symmetric(horizontal: 60.0),
      height: 45.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
        onPressed: () async {

          if(_fullName == '' && _contact == ''){
            setState(() {
              _fullNameError = true;
              _contactError = true;
            });
          }
          else if(_fullName == '' || _fullName == null ){
            setState(() {
              _fullNameError = true;
            });
          }
          else if(_contact == '' || _contact == null){
            setState(() {
              _contactError = true;
            });
          }
          else{
            setState(() {
              _isLoading = true;
            });
            exit(0);
            http.Response response = await http.post("",body: {
              "type":"updateUserProfile",
              "fullName":_fullName,
              "contact":_contact,
              "state":_state,
              "dob":_selectedDate.toString(),
            });
            if(response.statusCode == 200){
              final res = json.decode(response.body);
              if(res['success']==true){
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop(true);
                      });
                      return AlertDialog(
                        title: Text('Success',style: TextStyle(color: Colors.green,fontSize: 22.0),),
                        content: Row(
                          children: <Widget>[
                            Text('Profile updated',style: TextStyle(fontSize: 18.0),),
                            Icon(Icons.check_circle,color:Colors.green,size: 16.0,)
                          ],
                        ),
                      );
                    });
                setState(() {
                  _isLoading = false;
                });
              }
              else{
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop(true);
                      });
                      return AlertDialog(
                        title: Text('Error',style: TextStyle(color: Colors.red,fontSize: 22.0),),
                        content: Row(
                          children: <Widget>[
                            Text('Error updating profile.Try again.',style: TextStyle(fontSize: 18.0),),
                            Icon(Icons.error,color:Colors.red,size: 24.0,)
                          ],
                        ),
                      );
                    });
              }
            }
            else{
              SnackBar snackbar = new SnackBar(content: Text("Error updating profile.Please try again"));
              _scaffolKey.currentState.showSnackBar(snackbar);
              setState(() {
                _isLoading = false;
              });
            }
          }
        },
        child: new Text("UPDATE PROFILE",style: TextStyle(color: Colors.white),),
        color: Colors.deepOrange,
      ),
    );

    return Scaffold(
      key: _scaffolKey,
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text('Personal Details',style: TextStyle(color: Colors.white)),
      ),
      body: new ListView(

        children: <Widget>[

          new SizedBox(height: 20.0,),
          fullName,
          new SizedBox(height: 20.0,),
          mobileNo,
          new SizedBox(height: 20.0,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: selectState
          ),
          new SizedBox(height: 20.0,),
          dob,
          new SizedBox(height: 20.0,),
          new Stack(
          children: <Widget>[
            _isLoading ? new Center(child:  new CircularProgressIndicator(),) : new Center(child: submit,),
    ],
    ),
        ],

      ),
    );
  }
}
