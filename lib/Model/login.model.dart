import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'package:proxykhel/Model/savedpref.model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'dart:math';

import './../Model/verifyphone.model.dart';

class Model{
  static Model _instance;

  static String _facebookFullName;
  static String _facebookEmailId;

  static Model get instance  {
    if(_instance == null){
      _instance = new Model();
    }
    return _instance;
  }


  void setFacebookEmail(String emailId){
    _facebookEmailId = emailId;
  }
  void setFacebookFullName(String fullName){
    _facebookFullName = fullName;
  }

  Future<int> logginIn(String username, String password) async {
    final pref = await SharedPreferences.getInstance();
    http.Response response = await http.post("https://www.proxykhel.com/android/final.php", body: {'username': username.toString(), 'password':password.toString()});
    if(response.statusCode == 200){
      if(json.decode(response.body) != false){
        UserAccount account = userAccountFromJson(response.body);

        if(account.data.status == '0'){

          if(account.data.logontype == 'mobile'){
            int min = 1000;
            int max = 9999;
            int otp = min + (Random().nextInt(max-min));
            VerifyPhoneModel.instance.setOTP(otp);
            VerifyPhoneModel.instance.setUserId(account.data.id);
            var msg = "Dear USER, your OTP is ${VerifyPhoneModel.instance.getOTP()} to activate your account on Proxy Khel.";


    http.Response response = await http.get("https://api.msg91.com/api/sendhttp.php?mobiles=${account.data.emailId}&authkey=281414AsacFSKmekD5d0773a5&route=4&sender=PRKHEL&message=$msg&country=91");
            return 2;
          }else{
            VerifyPhoneModel.instance.setUserId(account.data.id);
            return 3;
          }
        }
        if (account.data.status == '1'){
          pref.setString('emailId', account.data.emailId);
          pref.setString('userId', account.data.id);
          pref.setString('username', account.data.username);
          pref.setString('fullName', account.data.fullName);
          return 1;
        }
        else{
          return 0;
        }
      }
      else {
        return 0;
      }
    }else{
      return 0;
    }
  }

  void facebookLogin()async{
    final pref = await SharedPreferences.getInstance();
    pref.setString("emailId", _facebookEmailId);
    pref.setString("fullname", _facebookFullName);
  }
  
  Future<int> googleLogin(String uId, String emailId, String fullName,String picture,String firstName)async{

    if(picture == null){
      picture = '';
    }
    http.Response response = await http.post("https://www.proxykhel.com/android/google_model.php",body: {
      "type":"googleLogin",
      "uid":uId,
      "emailId":emailId,
      "fullName":fullName,
      "picture":picture,
      "username":firstName
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      print(res);
      if(res == null){
        return  0;
      }
      if(res['success']==true){
        final pref = await SharedPreferences.getInstance();
        UserAccount account = userAccountFromJson(response.body);
        pref.setString('emailId', account.data.emailId);
        pref.setString('userId', account.data.id);
        pref.setString('username', account.data.username);
        pref.setString('fullName', account.data.fullName);
        return 1;
      }else{
        return 0;
      }
    }else{
      return 0;
    }
  }

  Future<bool> checkIfLoggedIn() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String emailId = pref.getString('emailId');
    if(emailId != null && emailId != ''){
      return true;
    }
    else{
      return false;
    }

  }


}

UserAccount userAccountFromJson(String str) => UserAccount.fromJson(json.decode(str));

String userAccountToJson(UserAccount data) => json.encode(data.toJson());

class UserAccount {
  bool success;
  Data data;

  UserAccount({
    this.success,
    this.data,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => new UserAccount(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  dynamic the0;
  String id;
  String fullName;
  String emailId;
  String mobileNo;
  String type;
  String dateofbirth;
  String state;
  String socialId;
  String socialInfo;
  String status;
  DateTime insertDatetime;
  dynamic ipAddress;
  String password;
  DateTime linkdatetime;
  String username;
  String teamname;
  String eemailerror;
  String logontype;

  Data({
    this.the0,
    this.id,
    this.fullName,
    this.emailId,
    this.mobileNo,
    this.type,
    this.dateofbirth,
    this.state,
    this.socialId,
    this.socialInfo,
    this.status,
    this.insertDatetime,
    this.ipAddress,
    this.password,
    this.linkdatetime,
    this.username,
    this.teamname,
    this.eemailerror,
    this.logontype,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    the0: json["0"],
    id: json["id"],
    fullName: json["fullName"],
    emailId: json["emailId"],
    mobileNo: json["mobileNo"],
    type: json["type"],
    dateofbirth: json["dateofbirth"],
    state: json["state"],
    socialId: json["socialId"],
    socialInfo: json["socialInfo"],
    status: json["status"],
    insertDatetime: DateTime.parse(json["insertDatetime"]),
    ipAddress: json["ipAddress"],
    password: json["password"],
    linkdatetime: DateTime.parse(json["linkdatetime"]),
    username: json["username"],
    teamname: json["teamname"],
    eemailerror: json["eemailerror"],
    logontype: json["logontype"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "id": id,
    "fullName": fullName,
    "emailId": emailId,
    "mobileNo": mobileNo,
    "type": type,
    "dateofbirth": dateofbirth,
    "state": state,
    "socialId": socialId,
    "socialInfo": socialInfo,
    "status": status,
    "insertDatetime": insertDatetime.toIso8601String(),
    "ipAddress": ipAddress,
    "password": password,
    "linkdatetime": linkdatetime.toIso8601String(),
    "username": username,
    "teamname": teamname,
    "eemailerror": eemailerror,
    "logontype": logontype,
  };
}
