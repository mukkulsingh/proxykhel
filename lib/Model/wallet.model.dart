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


  Future startPayment(int amount)async {
    String userId = await SavedPref.instance.getUserId();
    final response = await http.post("https://www.proxykhel.com/android/generateChecksum.php",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
        "mId": 'WGlUpt31068318705253',
        "CHANNEL_ID": "WAP",
        'INDUSTRY_TYPE_ID': 'Retail',
        'WEBSITE': 'APPSTAGING',
        'PAYTM_MERCHANT_KEY': '0AVJYh@7jLL37Q79',
        'TXN_AMOUNT': amount.toString(),
        'ORDER_ID': "12142",
        'CUST_ID': '122'
      }
    );

    if(response.statusCode == 200){
      var checksum = response.body;
      print(checksum);

      var paytmResponse = Paytm.startPaytmPayment(
          false,
          'WGlUpt31068318705253',
          "12142",
          "122",
          "WAP",
          amount.toString(),
          'APPSTAGING',
          "https://www.proxykhel.com/android/verifyChecksum.php",
          'Retail',
          checksum);

      paytmResponse.then((value) {

         final payment_response = value.toString();
        print(payment_response);
      });
    }
    print(response.statusCode);
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
