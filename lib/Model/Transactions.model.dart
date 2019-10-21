import 'dart:convert';
import 'package:http/http.dart' as http;
import 'savedpref.model.dart';

class TransactionsModel{

  static TransactionsModel _instance;

  static TransactionsModel get instance{
    if(_instance == null){
      _instance = new TransactionsModel();
    }
    return _instance;
  }
  
  Future getTransactions()async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/Transactions.php",body:{
      "type":"transactions",
      "userId":userId
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      print(res);
      if(res['success']==true){
        return transactionsDetailFromJson(response.body);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }

}

TransactionsDetail transactionsDetailFromJson(String str) => TransactionsDetail.fromJson(json.decode(str));

String transactionsDetailToJson(TransactionsDetail data) => json.encode(data.toJson());

class TransactionsDetail {
  bool success;
  List<Datum> data;

  TransactionsDetail({
    this.success,
    this.data,
  });

  factory TransactionsDetail.fromJson(Map<String, dynamic> json) => TransactionsDetail(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String walletId;
  String transaction;
  String oldBalance;
  String newBalance;
  DateTime created;
  String userId;
  String status;
  String contest;
  String action;
  String orderId;
  String modified;
  String team;
  String reasonerror;
  String statuserror;

  Datum({
    this.id,
    this.walletId,
    this.transaction,
    this.oldBalance,
    this.newBalance,
    this.created,
    this.userId,
    this.status,
    this.contest,
    this.action,
    this.orderId,
    this.modified,
    this.team,
    this.reasonerror,
    this.statuserror,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    walletId: json["wallet_id"],
    transaction: json["transaction"],
    oldBalance: json["old_balance"],
    newBalance: json["new_balance"],
    created: DateTime.parse(json["created"]),
    userId: json["user_id"],
    status: json["status"],
    contest: json["contest"],
    action: json["action"],
    orderId: json["order_id"],
    modified: json["modified"],
    team: json["team"],
    reasonerror: json["reasonerror"],
    statuserror: json["statuserror"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "wallet_id": walletId,
    "transaction": transaction,
    "old_balance": oldBalance,
    "new_balance": newBalance,
    "created": created.toIso8601String(),
    "user_id": userId,
    "status": status,
    "contest": contest,
    "action": action,
    "order_id": orderId,
    "modified": modified,
    "team": team,
    "reasonerror": reasonerror,
    "statuserror": statuserror,
  };
}
