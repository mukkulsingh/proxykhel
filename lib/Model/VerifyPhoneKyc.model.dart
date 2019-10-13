import 'package:proxykhel/Model/savedpref.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyPhoneKycModel{

  static int otp;
  static int _contact;
  static VerifyPhoneKycModel _instance;

  static VerifyPhoneKycModel get instance {
    if(_instance == null){
      _instance = new VerifyPhoneKycModel();
    }
    return _instance;
  }

  void setContact(int contact){
    _contact = contact;
  }

  int getContact(){
    return _contact;
  }

  void setOTP(int OTP){
    otp = OTP;
  }

  int getOTP(){
    return otp;
  }   


  Future<bool> verifyOTP(int OTP)async{
    if(otp == OTP){
      String userId = await SavedPref.instance.getUserId();
      http.Response response = await http.post("https://www.proxykhel.com/android/VerifyPhoneKyc.php",body: {
        "type":"updateUserStatus",
        "userId":userId,
        "mobileNo":_contact.toString(),
      });
      if(response.statusCode == 200){
        final res = json.decode(response.body);
        if(res['success']=='true' && res['msg']=='ok'){
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


}