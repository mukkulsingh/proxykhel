import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxykhel/Model/savedpref.model.dart';

class GetAadharAndPanStatusModel{
  static GetAadharAndPanStatusModel _instance;
  static GetAadharAndPanStatusModel get instance{
    if(_instance == null){
      _instance = new GetAadharAndPanStatusModel();
    }
    return _instance;
  }

  Future getAadharAndPanStatus() async {
    String userId = await SavedPref.instance.getUserId();

    http.Response response = await http.post("https://www.proxykhel.com/android/checkAadharAndPannumber.php",body: {
      "type":"getAadharAndPanStatus",
      "userId":userId
    });
    if(response.statusCode == 200){
      print(response.body);
      if(response.body != null){
        final res = json.decode(response.body);
        if(res['success']==true){
          return getAadharAndPanStatusFromJson(response.body);
        }else{
          return null;
        }
      }

    }

    else{
      return null;
    }
  }
}

GetAadharAndPanStatus getAadharAndPanStatusFromJson(String str) => GetAadharAndPanStatus.fromJson(json.decode(str));

String getAadharAndPanStatusToJson(GetAadharAndPanStatus data) => json.encode(data.toJson());

class GetAadharAndPanStatus {
  bool success;
  Data data;

  GetAadharAndPanStatus({
    this.success,
    this.data,
  });

  factory GetAadharAndPanStatus.fromJson(Map<String, dynamic> json) => GetAadharAndPanStatus(
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
  String aadharNo;
  String aadharImage;
  String aadharVerified;
  String panNo;
  String panImage;
  String panVerified;
  String stauts;
  String dob;
  String dobVerified;
  String iderror;

  Data({
    this.id,
    this.userId,
    this.aadharNo,
    this.aadharImage,
    this.aadharVerified,
    this.panNo,
    this.panImage,
    this.panVerified,
    this.stauts,
    this.dob,
    this.dobVerified,
    this.iderror,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    aadharNo: json["aadhar_no"],
    aadharImage: json["aadhar_image"],
    aadharVerified: json["aadhar_verified"],
    panNo: json["pan_no"],
    panImage: json["pan_image"],
    panVerified: json["pan_verified"],
    stauts: json["stauts"],
    dob: json["dob"],
    dobVerified: json["dob_verified"],
    iderror: json["iderror"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "aadhar_no": aadharNo,
    "aadhar_image": aadharImage,
    "aadhar_verified": aadharVerified,
    "pan_no": panNo,
    "pan_image": panImage,
    "pan_verified": panVerified,
    "stauts": stauts,
    "dob": dob,
    "dob_verified": dobVerified,
    "iderror": iderror,
  };
}
