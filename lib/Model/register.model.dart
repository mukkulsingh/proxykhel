import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './../Model/verifyphone.model.dart';

class Model{
  static Register register;


  static Model _instance;

  static Model get instance{
    if(_instance == null){
      _instance = new Model();
    }
    return _instance;
  }

  Future<int> registeringNewUser(String fullName, String emailOrPhone, String password, String url) async{

    http.Response response = await http.post(url,body:{'type':"register",'fullName':fullName, 'emailId':emailOrPhone.toString(),'password':password.toString()});
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      print(res);

      if(res['data'] == 'invalidPhone'){
        return 1;
      }
      else if(res['data'] == 'invalidEmail'){
        return 2;
      }
      else if(res['data'] == 'UserExits'){
        return 3;
      }
      else if(res["success"]=="true") {
        register = registerFromJson(response.body);
        VerifyPhoneModel.instance.setOTP(register.data.otp);
        VerifyPhoneModel.instance.setContact(int.parse(register.data.emailId));
        VerifyPhoneModel.instance.setFullName(register.data.fullName);
        VerifyPhoneModel.instance.setEmailId(register.data.emailId);
        VerifyPhoneModel.instance.setUsername(register.data.username);
        VerifyPhoneModel.instance.setUserId(register.data.id);
        return 4;
      }
      else{
        return 0;
      }
    }
    else{
      return 0;
    }
  }
}


Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  String success;
  Data data;

  Register({
    this.success,
    this.data,
  });

  factory Register.fromJson(Map<String, dynamic> json) => new Register(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
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
  int otp;

  Data({
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
    this.otp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
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
    otp: json["otp"],
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
    "otp": otp,
  };
}
