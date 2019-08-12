import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import './../Model/kyc.model.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  static DateTime selectedDate = DateTime.now();

  static Country _selected ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future<DateTime> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        selectedDate = picked;
      setState(() {
        });
      return selectedDate;
    }

    final pendingButton = new RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      onPressed: () {},
      color: Colors.deepOrange,
      child: new Text(
        'KYC Verification Pending',
        style: TextStyle(color: Colors.white),
      ),
    );

    final completeButton = new RaisedButton(
        onPressed: (){},
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: new Text(
          'Verified',
          style: TextStyle(color: Colors.white),
        ));

    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Center(
        child: new ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: new CircleAvatar(
              child: Image(
                image: AssetImage('assets/images/empty-avatar.png'),
              ),
              radius: 60.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text(
                  'General Status: ',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
pendingButton,
//               FutureBuilder(
//                   future: KycModel.instance.getKycStatus(),
//                   builder: (context,snapshot){
//                     switch(snapshot.connectionState){
//                       case ConnectionState.none:
//                         return new Stack(children: <Widget>[new Center(child: new CircularProgressIndicator(),)],);
//                         break;
//                       case ConnectionState.active:
//                         return new Stack(children: <Widget>[new Center(child: new CircularProgressIndicator(),)],);
//                         break;
//                       case ConnectionState.waiting:
//                         return new Stack(children: <Widget>[new Center(child: new CircularProgressIndicator(),)],);
//                         break;
//                       case ConnectionState.done:
//                         new CircularProgressIndicator();
//                         if(snapshot.hasError){
//                           new Text('Something went wrong');
//                         }
//                         else if(!snapshot.hasData){
//                          new Text("Error");
//                         }
//                         else if(snapshot.data.data.status == "0"){
//                              return CircularProgressIndicator();
//                          }
//                         else if(snapshot.data == null){
//                           return new Container();
//
//                         }
//                         else{
//                           return CircularProgressIndicator();
//                         }
//                         break;
//                     }
//                   }),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text(
                      'Contest Won',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    new Text('-'),
                  ],
                ),
                new Column(
                  children: <Widget>[
                    new Text(
                      'Contest Join',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    new Text('-'),
                  ],
                ),
                new Column(
                  children: <Widget>[
                    new Text(
                      'Winnings',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    new Text('-'),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Mobile No.',
                  border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text('Select Date Of Birth',style: TextStyle(color: Colors.deepOrange,fontSize: 18.0),),
                FlatButton(
                  onPressed: () {_selectDate(context);},
                  child: Text(selectedDate.day.toString()+'-'+selectedDate.month.toString()+'-'+selectedDate.year.toString(),style: TextStyle(fontSize:18.0 ),),
                ),
              ],
            )
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: CountryPicker(
              dense: false,
              showFlag: true,  //displays flag, true by default
              showDialingCode: false, //displays dialing code, false by default
              showName: true, //displays country name, true by default
              onChanged: (Country country) {
                setState(() {
                  _selected = country;
                });
              },
              selectedCountry: _selected,
            ),
          ),
          new Container(
            height: 45.0,
            margin: EdgeInsets.symmetric(horizontal: 100.0,vertical: 20.0),
            child: new RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              onPressed: (){},
              child: new Text('UPDATE PROFILE',style: TextStyle(color: Colors.white),),
              color: Colors.deepOrange,
            ),
          )
        ]),
      ),
    );
  }
}
