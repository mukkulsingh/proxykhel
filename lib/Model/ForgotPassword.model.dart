import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordModel{

  static String _otp;

  static ForgotPasswordModel _instance;

  static String _emailId;

  static ForgotPasswordModel get instance {
    if(_instance == null){
      _instance = new ForgotPasswordModel();
    }
    return _instance;
  }

  get getPhoneNo=>_emailId;

  void setOTP(String otp){
    _otp = otp;
  }
  Future<int> forgotPassword(String emaild) async {

    http.Response response = await http.post("https://www.proxykhel.com/android/ForgotPassword.php",body: {
      "type":"forgotPassword",
      "emailId":emaild,
    });

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true && res['data']=='1'){
        _otp = res['otp'].toString();
        _emailId = emaild;
        return 1;
      }
      else if(res['success']==true && res['data']=='2'){
        return 2;
      }
      else if(res['success']==false){
        return 3;
      }
      else{
        return 4;
      }
    }else{
      return 0;
    }
  }

  Future<bool> updatePassword(String password)async {
    http.Response response = await http.post(
        "https://www.proxykhel.com/android/UpdatePassword.php", body: {
      "type": "updatePassword",
      "emailId": _emailId,
      "password": password
    });
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      print(res);
      if (res['success'] == true) {
        return true;
      } else {
        return false;
      }
    }else{
      return false;
    }
  }
  get getOTP=>_otp;

  bool verifyOTP(String otp) {
    if(_otp == otp){
      return true;
    }else{
      return false;
    }
  }

}