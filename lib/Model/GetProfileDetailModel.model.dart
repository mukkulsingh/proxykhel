import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proxykhel/Model/savedpref.model.dart';

class GetProfileDetailModel{

  static GetProfileDetailModel _instance;

  static GetProfileDetailModel get instance{
    if(_instance == null){
      _instance = new GetProfileDetailModel();
    }
    return _instance;
  }

  Future<GetProfileDetailPojo> getProfileDetail() async {

   String userId = await SavedPref.instance.getUserId();

   http.Response response = await http.post("https://www.proxykhel.com/android/getProfileDetail.php",body: {
     "type":"getProfileDetail",
     "userId":userId
   });
   if(response.statusCode == 200){
     final res = json.decode(response.body);
     if(res['success']==true){
       return getProfileDetailPojoFromJson(response.body);
     }else{
       return null;
     }
   }

   else{
     return null;
   }
  }
}

GetProfileDetailPojo getProfileDetailPojoFromJson(String str) => GetProfileDetailPojo.fromJson(json.decode(str));

String getProfileDetailPojoToJson(GetProfileDetailPojo data) => json.encode(data.toJson());

class GetProfileDetailPojo {
  bool success;
  Data data;

  GetProfileDetailPojo({
    this.success,
    this.data,
  });

  factory GetProfileDetailPojo.fromJson(Map<String, dynamic> json) => new GetProfileDetailPojo(
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