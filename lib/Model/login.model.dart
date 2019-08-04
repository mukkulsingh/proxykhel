import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class Model{

  static UserAccount account = null;

  UserAccount userAccountFromJson(String str) => UserAccount.fromJson(json.decode(str));

  String userAccountToJson(UserAccount data) => json.encode(data.toJson());

  static Model _instance;

  static Model get instance  {
    if(_instance == null){
      _instance = new Model();
    }
    return _instance;
  }

  Future<bool> logginIn(String username, String password, String url) async {
    final pref = await SharedPreferences.getInstance();
    http.Response response = await http.post(url, body: {'username': username, 'password':password});
    if(response.statusCode == 200){
      if(json.decode(response.body) != false){
        account = userAccountFromJson(response.body);
        if (account != null){
          pref.setString('emailId', account.emailId);
          pref.setString('userId', account.id);
          pref.setString('username', account.username);
          return true;
        }
        else{
          return false;
        }
      }
      else {
        return false;
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



class UserAccount {
  String id;
  String fullName;
  String emailId;
  String mobileNo;
  String type;
  String dateofbirth;
  String state;
  String socialId;
  String username;

  UserAccount({
    this.id,
    this.fullName,
    this.emailId,
    this.mobileNo,
    this.type,
    this.dateofbirth,
    this.state,
    this.socialId,
    this.username,
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
    username: json["username"],
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
    "username": username,
  };
}