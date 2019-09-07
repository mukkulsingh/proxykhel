import './../Model/BankDetailModel.model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EditBankDetails extends StatefulWidget {
  @override
  _EditBankDetailsState createState() => _EditBankDetailsState();
}

class _EditBankDetailsState extends State<EditBankDetails> {

  static bool _isLoading;
  static bool _inputError;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _inputError = false;
  }



  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_)=>AccountNumberProvider(),),
        ChangeNotifierProvider(builder: (_)=>HolderNameProvider(),),
        ChangeNotifierProvider(builder: (_)=>IfscProvider(),),

      ],
      child: Scaffold(
        key: _scaffoldKey,
          appBar: new AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            title: new Text('Edit Bank Details',style: TextStyle(color: Colors.white)),
          ),
          body:new ListView(
            children: <Widget>[
              new SizedBox(
                height: 20.0,
              ),
              HolderName(),
              new SizedBox(height: 20.0,),
              AccountNumber(),
              new SizedBox(height: 20.0,),
              IfscCode(),
              new SizedBox(height: 20.0,),
              _inputError?new Container(margin: EdgeInsets.only(bottom: 20.0),child: new Text("All fields are mendatory",textAlign: TextAlign.center,style: TextStyle(color: Colors.red),),):new Container(),
              new Stack(
                children: <Widget>[
                  _isLoading?new Center(child: new CircularProgressIndicator(),):new Center(child: new Container(
                    height: 45.0,
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)
                      ),
                      color: Colors.deepOrange,
                        child: new Text("SUBMIT",style: TextStyle(color:Colors.white),),
                        onPressed: ()async{
                        if(BankDetailModel.instance.getAccount == null || BankDetailModel.instance.getAccount == ''
                            || BankDetailModel.instance.getHolder == null || BankDetailModel.instance.getHolder == ''
                        || BankDetailModel.instance.getIfsc == null || BankDetailModel.instance.getIfsc == ''
                        ){
                          setState(() {
                            _inputError = true;
                          });
                        }
                        else{
                          setState(() {
                            _inputError=false;
                            _isLoading = true;
                          });
                          int n = await BankDetailModel.instance.updateBankDetails();
                          if(n == 1){
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(Duration(seconds: 2), () {
                                            Navigator.of(context).pop(true);
                                            Navigator.of(context).pop(true);
                                          });
                                          return AlertDialog(
                                            title: Text('Success',style: TextStyle(color: Colors.green,fontSize: 22.0),),
                                            content: Row(
                                              children: <Widget>[
                                                Text('Account details updated',style: TextStyle(fontSize: 18.0),),
                                                Icon(Icons.check_circle,color:Colors.green,size: 16.0,)
                                              ],
                                            ),
                                          );
                                        });
                          }else{
                            SnackBar snackbar = new SnackBar(content: Text("Error updating bank detail"),duration: Duration(seconds: 1),);
                            _scaffoldKey.currentState.showSnackBar(snackbar);
                            setState(() {
                              _isLoading = false;
                              _inputError = false;
                            });
                          }
                        }
                        }
                        ),
                  ),)
                ],
              )
            ],
          )
      ),
    );
  }
}

class HolderNameProvider extends ChangeNotifier{
  static String _fullName;

  static bool _isError=false;

  void setFullName(String fullName){
    _fullName = fullName;
    if(_fullName == '' || _fullName == null){
      _isError = true;
    }
    BankDetailModel.instance.setHolderName(_fullName);
    notifyListeners();
  }

  get getError=>_isError;
}

class HolderName extends StatefulWidget {
  @override
  _HolderNameState createState() => _HolderNameState();
}

class _HolderNameState extends State<HolderName> {
  @override
  Widget build(BuildContext context) {
    HolderNameProvider holderNameProvider = new HolderNameProvider();
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Account holder name",
          errorText: holderNameProvider.getError ? "Invalid name":"",
        ),
        onChanged: (value){
          holderNameProvider.setFullName(value);
        },
      ),
    );
  }
}

class IfscProvider extends ChangeNotifier{
  static String _ifsc;
  static bool _ifscError=false;
  void setIfsc(String ifsc){
    _ifsc = ifsc;
    if(_ifsc == null || _ifsc == ''){
      _ifscError = true;
    }
    else{
      _ifscError=false;
    }
    BankDetailModel.instance.setIfscCode(_ifsc);
    notifyListeners();
  }

  get getifscError=>_ifscError;
}

class IfscCode extends StatefulWidget {
  @override
  _IfscCodeState createState() => _IfscCodeState();
}

class _IfscCodeState extends State<IfscCode> {
  @override
  Widget build(BuildContext context) {
    IfscProvider ifscProvider = new IfscProvider();
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "IFSC Code",
          errorText: ifscProvider.getifscError?"Invalid input":"",
        ),
        onChanged: (value){
          ifscProvider.setIfsc(value);
        },
      ),
    );
  }
}


class AccountNumberProvider extends ChangeNotifier{
  static String _accountNumber;
  static bool _isError=false;

  void setAccountNumber(String accountNumber){
    _accountNumber = accountNumber;
    if(_accountNumber == '' || _accountNumber == null){
      _isError = true;
    }else{
      _isError = false;
    }
    BankDetailModel.instance.setAccountNumber(_accountNumber);
    notifyListeners();
  }

  get getError=>_isError;

}

class AccountNumber extends StatefulWidget {
  @override
  _AccountNumberState createState() => _AccountNumberState();
}

class _AccountNumberState extends State<AccountNumber> {
  @override
  Widget build(BuildContext context) {
    AccountNumberProvider accountNumberProvider = new AccountNumberProvider();
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: new TextField(
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Account No.",
          errorText: accountNumberProvider.getError?"Invalid account":"",
        ),
        onChanged: (value){
          accountNumberProvider.setAccountNumber(value);
        },
      ),
    );
  }
}