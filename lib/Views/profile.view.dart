import 'package:flutter/material.dart';
import './personaldetails.view.dart';
import './kycstatus.view.dart';
import './bankdetails.view.dart';
import './invitefriends.view.dart';
import './../Constants/slideTransitions.dart';
import './../Model/kyc.model.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  static DateTime selectedDate = DateTime.now();

//  static Country _selected ;

  Future<bool> getKycStatus()async{

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

//    Future<DateTime> _selectDate(BuildContext context) async {
//      final DateTime picked = await showDatePicker(
//          context: context,
//          initialDate: selectedDate,
//          firstDate: DateTime(2015, 8),
//          lastDate: DateTime(2101));
//      if (picked != null && picked != selectedDate)
//        selectedDate = picked;
//      setState(() {
//        });
//      return selectedDate;
//    }
//
//    final pendingButton = new RaisedButton(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(32.0),
//      ),
//      onPressed: () {},
//      color: Colors.deepOrange,
//      child: new Text(
//        'KYC Verification Pending',
//        style: TextStyle(color: Colors.white),
//      ),
//    );
//
//    final completeButton = new RaisedButton(
//        onPressed: (){},
//        color: Colors.green,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(32.0),
//        ),
//        child: new Text(
//          'Verified',
//          style: TextStyle(color: Colors.white),
//        ));

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
      body:new Center(
        child: new ListView(children: <Widget>[
        ListTile(
        title: new Text('KYC Status'),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new FutureBuilder(
                future: KycModel.instance.getKycStatus(),
                builder: (context,snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                      return new Container(
                        width: 10,
                        height: 10,
                        child: new CircularProgressIndicator(),
                      );
                  break;
                    case ConnectionState.active:
                      return new Container(
                        width: 10,
                        height: 10,
                        child: new CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.waiting:
                      return new Container(
                        width: 10,
                        height: 10,
                        child: new CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.done:
                      if(snapshot.hasError){
                        return new Container(
                          width: 10,
                          height: 10,
                          child: new CircularProgressIndicator(),
                        );
                      }
                      else if(snapshot.hasData){
                        if(snapshot.data.data.status == '1'){
                          return new Icon(Icons.verified_user,color: Colors.green,);
                        }
                        else{
                          return new Icon(Icons.error,color: Colors.red,);
                        }
                      }
                  }
                }),
            new Icon(Icons.chevron_right),

          ],
        ),
          onTap: (){
            Navigator.push(context, SlideLeftRoute(widget: KycStatusView()));
          },
      ),
          ListTile(
            title: Text("Personal Details"),
            trailing: Icon(Icons.chevron_right),
            onTap: (){
              Navigator.push(context, SlideLeftRoute(widget: PersonalDetails()));
            },
          ),
          ListTile(
            title: new Text("Bank Details"),
            trailing: new Icon(Icons.chevron_right),
            onTap: (){
              Navigator.push(context, SlideLeftRoute(widget: BankDetails()));
            },
          ),
//          ListTile(
        //TODO
//            title: new Text('Invite Friends'),
//            trailing: new Icon(Icons.chevron_right),
//            onTap: (){
//              Navigator.push(context, SlideLeftRoute(widget: InviteFriends()));
//            },
//          ),

//        ListTile(
        //TODO
//          title: new Text('My Matches'),
//          trailing: new Icon(Icons.chevron_right),
//        )
        ]
        ),
      )
    );
}

}