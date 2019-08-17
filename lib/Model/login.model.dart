import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class Model{
  static Model _instance;

  static Model get instance  {
    if(_instance == null){
      _instance = new Model();
    }
    return _instance;
  }

  Future<int> logginIn(String username, String password) async {
    final pref = await SharedPreferences.getInstance();
    http.Response response = await http.post("https://www.proxykhel.com/android/final.php", body: {'username': username.toString(), 'password':password.toString()});
    if(response.statusCode == 200){
      if(json.decode(response.body) != false){
        UserAccount account = userAccountFromJson(response.body);
        if(account.status == '0'){
          return 2;
        }
        if (account.status == '1'){
          pref.setString('emailId', account.emailId);
          pref.setString('userId', account.id);
          pref.setString('username', account.username);
          return 1;
        }
        else{
          return 0;
        }
      }
      else {
        return 0;
      }
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

  UserAccount({
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
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => new UserAccount(
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
  );

  Map<String, dynamic> toJson() => {
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
  };
}
