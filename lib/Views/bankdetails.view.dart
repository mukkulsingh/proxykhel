import 'package:flutter/material.dart';
import './EditBankDetails.view.dart';
import './../Model/BankDetailModel.model.dart';
import './../Constants/slideTransitions.dart';
class BankDetails extends StatefulWidget {
  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    final submitButton = new Container(
      height: 45.0,
      margin: EdgeInsets.symmetric(horizontal: 60.0),
      child: new RaisedButton(
        onPressed: ()async{
          Navigator.push(context, SlideLeftRoute(widget: EditBankDetails()));

        },
        child: new Text("Edit",style: TextStyle(color: Colors.white),),
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text('Bank Details',style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder(
          future: BankDetailModel.instance.getBankDetail(),
          builder: (context,snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator(),);
              case ConnectionState.done:
                if(snapshot.hasError){
                  return new Center(child: new Text(snapshot.hasError.toString()),);
                }
                else if(snapshot.hasData){
                  ListView(
                    children: <Widget>[
                      new SizedBox(
                        height: 20.0,
                      ),
                      new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            new Text("Holder Name:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                            new Text("${snapshot.data.data.bankholder}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                          ],
                        )
                      ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new Text("Accoount No:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                              new Text("${snapshot.data.data.bankAccount}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                            ],
                          )
                        ],
                      ),
                      new SizedBox(height: 20.0,),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new Text("IFSC code:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                              new Text("${snapshot.data.data.ifsc}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                            ],
                          )
                        ],
                      ),
                      new SizedBox(height: 20.0,),
                      new Center(child: submitButton,),
                    ],
                  );

                }
            }
          }),
    )
  }
}



