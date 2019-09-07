import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';


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
  static int _idType;

  TextEditingController _holderController;
  TextEditingController _ifscContorller;
  TextEditingController _accountController;


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    _idType = null;
    _holderController = new TextEditingController();
    _ifscContorller = new TextEditingController();
    _accountController = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
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
                        leading: new Icon(Icons.check_circle,color: Colors.green,),
                          title: Text('Basic information'),
                        children: <Widget>[
                          new ListTile(
                            trailing:Icon(Icons.check_circle,color: Colors.green,),
                            title: Text("User Id"),
                            subtitle: Text("mukkulsingh786@gmail.com"),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      child: new ExpansionTile(
                        leading: new Icon(Icons.check_circle,color: Colors.green,),
                        title: Text("Identity Proof"),
                        children: <Widget>[
                         new Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: <Widget>[
                             new DropdownButton(
                                 value: _idType,
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
                                      _idType = value;
                                    });
                                 }),
                             new Container(
                               height: 25.0,
                               margin: EdgeInsets.only(top: 10.0),
                               child: new RaisedButton(
                                 onPressed: (){
                                   getImage();
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
                        leading: new Icon(Icons.check_circle,color: Colors.green,),
                        children: <Widget>[
                          ListTile(
                            title: Text("Holder Name"),
                            leading: Icon(Icons.person),
                            subtitle: new TextField(
                              controller: _holderController,
                              decoration: InputDecoration(
                                labelText: "Holder Name"
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("Account Number"),
                            leading: Icon(Icons.account_circle),
                            subtitle: TextField(
                              controller: _accountController,
                              decoration: InputDecoration(
                                labelText: "Account No."
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("IFSC Code"),
                            leading: Icon(Icons.account_balance),
                            subtitle: TextField(
                              controller: _ifscContorller,
                              decoration: InputDecoration(
                                  labelText: "IFSC Code"
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
}
