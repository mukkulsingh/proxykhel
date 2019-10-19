import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxykhel/Model/savedpref.model.dart';

class ReferralCodeModel{
  static ReferralCodeModel _instance;
  static ReferralCodeModel get instance{
    if(_instance == null){
      _instance = new ReferralCodeModel();
    }
    return _instance;
  }
  Future getReferralCode()async{
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/Refer.php",body:{
      "type":"getrefer",
      "userId":userId,
    });
    if(response.statusCode == 200){
     if(response.body != null){
       return referralCodeDataFromJson(response.body);
     }
    }else{
      return null;
    }
  }
}
ReferralCodeData referralCodeDataFromJson(String str) => ReferralCodeData.fromJson(json.decode(str));

String referralCodeDataToJson(ReferralCodeData data) => json.encode(data.toJson());

class ReferralCodeData {
  String id;
  String userId;
  String refId;
  String refCount;
  String refBy;

  ReferralCodeData({
    this.id,
    this.userId,
    this.refId,
    this.refCount,
    this.refBy,
  });

  factory ReferralCodeData.fromJson(Map<String, dynamic> json) => ReferralCodeData(
    id: json["id"],
    userId: json["user_id"],
    refId: json["ref_id"],
    refCount: json["ref_count"],
    refBy: json["ref_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "ref_id": refId,
    "ref_count": refCount,
    "ref_by": refBy,
  };
}
