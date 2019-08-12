import 'package:http/http.dart'as http;
import 'dart:async';
import 'dart:convert';
import 'savedpref.model.dart';

class KycModel{

  static KycModel _instance;

  static KycModel get instance{
    if(_instance == null){
      _instance = new KycModel();
    }
    return _instance;
  }

  Future<KycStatus> getKycStatus() async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post(
      "https://www.proxykhel.com/android/kycCheck.php",
      headers: {'content-type':'application/json'},
      body: json.encode({
        "type":"checkKyc",
        "userId":userId,
      }),
    );

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        print('here');
        return kycStatusFromJson(response.body);
      }
      else{
        print('false');
        return null;
      }
    }else{
      print('false');

      return null;
    }
  }

}



KycStatus kycStatusFromJson(String str) => KycStatus.fromJson(json.decode(str));

String kycStatusToJson(KycStatus data) => json.encode(data.toJson());

class KycStatus {
  bool success;
  Data data;

  KycStatus({
    this.success,
    this.data,
  });

  factory KycStatus.fromJson(Map<String, dynamic> json) => new KycStatus(
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
  String userId;
  String emailId;
  String optionalemailId;
  String idVerification;
  String bankVerification;
  String status;
  String eemailerror;

  Data({
    this.id,
    this.userId,
    this.emailId,
    this.optionalemailId,
    this.idVerification,
    this.bankVerification,
    this.status,
    this.eemailerror,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    id: json["id"],
    userId: json["user_id"],
    emailId: json["emailId"],
    optionalemailId: json["optionalemailId"],
    idVerification: json["id_verification"],
    bankVerification: json["bank_verification"],
    status: json["status"],
    eemailerror: json["eemailerror"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "emailId": emailId,
    "optionalemailId": optionalemailId,
    "id_verification": idVerification,
    "bank_verification": bankVerification,
    "status": status,
    "eemailerror": eemailerror,
  };
}