import 'package:http/http.dart' as http;
import 'savedpref.model.dart';
import 'dart:convert';
class WithdrawModel{
  static WithdrawModel _instance;
  static WithdrawModel get instance{
    if(_instance == null){
      _instance = new WithdrawModel();
    }
    return _instance;
  }

  static String _withdrawAmount;

  void setWithdrawAmount(String withdrawAmount){_withdrawAmount = withdrawAmount;}
  String get getWithdrawAmount=>_withdrawAmount;

  Future chekcKyc() async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/CheckKyc.php",body:{
      "type":"checkKyc",
      "userId": userId,
    });

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res == true){
        return true;
      }else{
        return false;
      }
    }
  }

  Future withdraw()async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/Withdraw.php",body:{
      "type":"withdraw",
      "userId":userId,
      "withdrawalAmount":_withdrawAmount,
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res == true){
        return true;
      }else{
        return false;
      }
    }else {
      return false;
    }
  }
}