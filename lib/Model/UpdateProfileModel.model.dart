import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proxykhel/Model/savedpref.model.dart';


class UpdateProfileModel{

  static UpdateProfileModel _instance;

  static UpdateProfileModel get instance{
   if(_instance == null){
     _instance = new UpdateProfileModel();
   }
   return _instance;
  }

  Future<int> updateProfile(String fullName, String mobileNo, String state, String dateofbirth)async{
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/updateProfile.php",body: {
      "type":"updateProfile",
      "userId":userId,
      "fullName":fullName,
      "mobileNo":mobileNo,
      "dateofbirth":dateofbirth,
      "state":state
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