import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proxykhel/Model/savedpref.model.dart';


class UpdateProfileModel{

  static UpdateProfileModel _instance;

  static String _fullName;
  static String _mobileNo;
  static String _state;
  static String _dob;

  void setFullName(String fullName){
    _fullName = fullName;
  }


  void setMobileNo(String mobileNo){
    _mobileNo = mobileNo;
  }

  void setState(String state){
    _state = state;
  }

  void setDob(String dob){
    _dob = dob;
  }

  get getfullName=>_fullName;
  get getMobileNo=>_mobileNo;
  get getState=>_state;
  get getDob=>_dob;

  static UpdateProfileModel get instance{
   if(_instance == null){
     _instance = new UpdateProfileModel();
   }
   return _instance;
  }

  Future<int> updateProfile()async{
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/updateProfile.php",body: {
      "type":"updateProfile",
      "userId":userId,
      "fullName":_fullName,
      "mobileNo":_mobileNo,
      "dateofbirth":_dob,
      "state":_state
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return 1;
      }else if(res['success']==false)
        {
        return 2;
      }else{
        return 3;
      }
    }
    else{
      return 3;
    }
  }
}