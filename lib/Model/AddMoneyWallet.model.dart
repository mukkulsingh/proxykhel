import 'dart:convert';

import 'package:proxykhel/Model/savedpref.model.dart';
import 'package:http/http.dart' as http;

class AddMoneyWalletModel{
  static AddMoneyWalletModel _instance;
  static AddMoneyWalletModel get instance{
    if(_instance == null){
      _instance = new AddMoneyWalletModel();
    }
    return _instance;
  }

  static String _balance;

  void setBalance(String balance){
    _balance = balance;
  }

  get getBalance=>_balance;
  Future addBalance() async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/AddMoneyWallet.php",body: {
      "type":"addMoneyWallet",
      "userId":userId,
      "amount":_balance,
    });

    if(response.statusCode  == 200){
      if(json.decode(response.body) == true){
        return true;
      }else{
        return false;
      }
    }
  }
}