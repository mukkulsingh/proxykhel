import 'package:flutter/material.dart';
import 'package:proxykhel/Constants/slideTransitions.dart';
import 'package:proxykhel/Model/GetProfileDetailModel.model.dart';
import 'package:proxykhel/Model/UpdateProfileModel.model.dart';
import './EditPersonalDetails.view.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static String _fullName;
  static bool _fullNameError;
  static String _contact;
  static bool _contactError;
  static String _state;
  static DateTime _selectedDate;
  static bool _isLoading;

  TextEditingController _fullNameController;
  TextEditingController _mobileController;


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
    _fullNameController = new TextEditingController();
    _mobileController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {


    final submit = new Container(
      margin: EdgeInsets.symmetric(horizontal: 60.0),
      height: 45.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
        onPressed: () {
          Navigator.push(context, SlideLeftRoute(widget: EditPersonalDetail()));
        },
        child: new Text("Edit Profile",style: TextStyle(color: Colors.white),),
        color: Colors.deepOrange,
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text('Personal Details',style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder(
        future: GetProfileDetailModel.instance.getProfileDetail(),
          builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator(),);
            case ConnectionState.done:
              if(snapshot.hasError){
                return new Center(child: new Text('${snapshot.hasError}'),);
              }else if(!snapshot.hasData){
                return new Center(child: Column(
                  children: <Widget>[
                    new Text("User details not found"),
                    new FlatButton(onPressed: (){setState(() {

                    });}, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Retry"),
                        new Icon(Icons.refresh)
                      ],
                    ))
                  ],
                ),);

              }
              else if(snapshot.hasData){

                return new ListView(

                  children: <Widget>[

                    new SizedBox(height: 20.0,),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("  Full name:",style: TextStyle(color:Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 24.0),textAlign: TextAlign.left,),
                            new Text("      ${snapshot.data.data.fullName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                          ],
                        )
                      ],
                    ),
                    new SizedBox(height: 20.0,),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("  Mobile no:",style: TextStyle(color:Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 24.0),textAlign: TextAlign.left,),
                            new Text("      ${snapshot.data.data.mobileNo}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                          ],
                        )
                      ],
                    ),
                    new SizedBox(height: 20.0,),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("  State: ",style: TextStyle(color:Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 24.0),textAlign: TextAlign.left,),
                            new Text("      ${snapshot.data.data.state}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                          ],
                        )
                      ],
                    ),
                    new SizedBox(height: 20.0,),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("  Date of birth: ",style: TextStyle(color:Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 24.0),textAlign: TextAlign.left,),
                            new Text("      ${snapshot.data.data.dateofbirth}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                          ],
                        )
                      ],
                    ),
                    new SizedBox(height: 20.0,),
                    new Stack(
                      children: <Widget>[
                      new Center(child: submit,),
                      ],
                    ),
                  ],

                );

              }
              else{
                return new Center(child: Column(
                  children: <Widget>[
                    new Text("Something went wrong"),
                    new FlatButton(onPressed: (){setState(() {

                    });}, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Retry"),
                        new Icon(Icons.refresh)
                      ],
                    ))
                  ],
                ),);
              }
          }
      }),
    );
  }
}
