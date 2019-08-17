import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyPhoneModel{

  static int otp;
  static int _contact;

  static String _emailId;
  static String _username;
  static String _userId;
  static String _fullName;
  static VerifyPhoneModel _instance;

  static VerifyPhoneModel get instance {
    if(_instance == null){
      _instance = new VerifyPhoneModel();
    }
    return _instance;
  }

  void setUserId(String userId){
    _userId = userId;
  }
  void setUsername(String username){
    _username = username;
  }
  void setEmailId(String emailId){
    _emailId = emailId;
  }
  void setFullName(String fullName){
    _fullName = fullName;
  }

  Future<bool> verifyOTP(int OTP) async  {
    if(otp == OTP){
      
      http.Response response = await http.post("https://www.proxykhel.com/android/updateUserStatus.php",body: {
        "type":"updateUserStatus",
        "userId":_userId
      });

      if(response.statusCode == 200){
        final res = json.decode(response.body);
        if(res['suucess']==true && res['msg']=='ok'){
          final pref = await SharedPreferences.getInstance();
          pref.setString('username',_username);
          pref.setString('userId', _userId);
          pref.setString('emailId', _emailId);
          pref.setString('fullName', _fullName);
          return true;
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }

    }
    else{
      return false;
    }
  }

  void setContact(int contact){
    _contact = contact;
  }

  int getContact(){
    return _contact;
  }

  void setOTP(int otp){
    otp = otp;
  }

  int getOTP(){
    return otp;
  }
}