import 'package:http/http.dart' as http;
import 'dart:convert';
import 'savedpref.model.dart';
import 'package:async/async.dart';

class WalletModel{

  AsyncMemoizer _memoizer = new AsyncMemoizer();

  static String balanceAmount;
  static String _bonusAmount="0";
  static WalletModel _instance;
  static WalletModel get instance{

    if(_instance == null){
      _instance = new WalletModel();
    }
    return _instance;
  }


  Future getWalletBalance() async {
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
  }

  void setBonusAmount(String bonusAount){_bonusAmount = bonusAount;}

  void setBalance(String balance){
    balanceAmount = balance;
  }

  String getBalance(){
    return balanceAmount;
  }

  String get getBonusAoumnt=>_bonusAmount;

}


WalletDetails walletDetailsFromJson(String str) => WalletDetails.fromJson(json.decode(str));

String walletDetailsToJson(WalletDetails data) => json.encode(data.toJson());

class WalletDetails {
  String id;
  String userId;
  String walletAmount;
  DateTime created;
  String bonus;

  WalletDetails({
    this.id,
    this.userId,
    this.walletAmount,
    this.created,
    this.bonus
  });

  factory WalletDetails.fromJson(Map<String, dynamic> json) => new WalletDetails(
    id: json["id"],
    userId: json["user_id"],
    walletAmount: json["wallet_amount"],
    created: DateTime.parse(json["created"]),
    bonus: json["bonus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "wallet_amount": walletAmount,
    "created": created.toIso8601String(),
    "bonus":bonus
  };
}
