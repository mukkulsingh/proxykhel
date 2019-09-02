import 'dart:convert';
import 'package:http/http.dart' as http;
import 'savedpref.model.dart';
class BankDetailModel{
  static BankDetailModel _instance;

  static String _holderName;
  static String _accountNumber;
  static String _ifscCode;

  void setAccountNumber(String accountNumber){
    _accountNumber = accountNumber;
  }

  void setHolderName(String holderName){
    _holderName = holderName;
  }
  void setIfscCode(String ifscCode){
    _ifscCode = ifscCode;
  }

  get getIfsc=>_ifscCode;
  get getHolder=>_holderName;
  get getAccount=>_accountNumber;

  static BankDetailModel get instance{
    if(_instance == null){
      _instance = new BankDetailModel();
    }
    return _instance;
  }

  Future<BankDetailPojo> getBankDetail() async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/getBankDetails.php",body: {
      "type":"getBankDetails",
      "userId":userId
    });

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success'] == true){
        return bankDetailPojoFromJson(response.body);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }

  Future<int> updateBankDetails() async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/BankDetails.php",body: {
      "type":"uploadBankDetails",
      "userId":userId,
      "bankHolder":_holderName,
      "ifsc":_ifscCode,
      "bankAccount":_accountNumber
    });

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return 1;
      }else{
        return 2;
      }
    }else {
      return 2;
    }
  }

}

BankDetailPojo bankDetailPojoFromJson(String str) => BankDetailPojo.fromJson(json.decode(str));

String bankDetailPojoToJson(BankDetailPojo data) => json.encode(data.toJson());

class BankDetailPojo {
  bool success;
  Data data;

  BankDetailPojo({
    this.success,
    this.data,
  });

  factory BankDetailPojo.fromJson(Map<String, dynamic> json) => new BankDetailPojo(
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
  String bankAccount;
  String ifsc;
  String verified;
  String status;
  String bankphoto;
  DateTime modified;
  String created;
  String bankholder;
  String idbank;

  Data({
    this.id,
    this.userId,
    this.bankAccount,
    this.ifsc,
    this.verified,
    this.status,
    this.bankphoto,
    this.modified,
    this.created,
    this.bankholder,
    this.idbank,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    id: json["id"],
    userId: json["user_id"],
    bankAccount: json["bank_account"],
    ifsc: json["ifsc"],
    verified: json["verified"],
    status: json["status"],
    bankphoto: json["bankphoto"],
    modified: DateTime.parse(json["modified"]),
    created: json["created"],
    bankholder: json["bankholder"],
    idbank: json["idbank"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "bank_account": bankAccount,
    "ifsc": ifsc,
    "verified": verified,
    "status": status,
    "bankphoto": bankphoto,
    "modified": modified.toIso8601String(),
    "created": created,
    "bankholder": bankholder,
    "idbank": idbank,
  };
}
