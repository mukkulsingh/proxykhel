import 'package:http/http.dart' as http;
import 'dart:convert';
import 'savedpref.model.dart';
import 'package:async/async.dart';
import 'package:paytm/paytm.dart';

class WalletModel{

  AsyncMemoizer _memoizer = new AsyncMemoizer();


  static String balanceAmount;

  static WalletModel _instance;
  static WalletModel get instance{

    if(_instance == null){
      _instance = new WalletModel();
    }
    return _instance;
  }


  Future getWalletBalance() async {
    return this._memoizer.runOnce(()async {
      String userId = await SavedPref.instance.getUserId();
      http.Response response = await http.post("https://www.proxykhel.com/android/wallet.php",body: {
        "type":"getWalletBalance",
        "userId":userId
      });
      if(response.statusCode == 200){
        return  walletDetailsFromJson(response.body);
      }else{
        return null;
      }
    });
  }

  void setBalance(String balance){
    balanceAmount = balance;
  }

  String getBalance(){
    return balanceAmount;
  }

}


WalletDetails walletDetailsFromJson(String str) => WalletDetails.fromJson(json.decode(str));

String walletDetailsToJson(WalletDetails data) => json.encode(data.toJson());

class WalletDetails {
  String id;
  String userId;
  String walletAmount;
  DateTime created;
  DateTime modified;

  WalletDetails({
    this.id,
    this.userId,
    this.walletAmount,
    this.created,
    this.modified,
  });

  factory WalletDetails.fromJson(Map<String, dynamic> json) => new WalletDetails(
    id: json["id"],
    userId: json["user_id"],
    walletAmount: json["wallet_amount"],
    created: DateTime.parse(json["created"]),
    modified: DateTime.parse(json["modified"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "wallet_amount": walletAmount,
    "created": created.toIso8601String(),
    "modified": modified.toIso8601String(),
  };
}
