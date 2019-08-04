import 'dart:convert';
import 'package:http/http.dart' as http;
import './../Views/tabBarMega.view.dart';
import './../Views/tabBarHtoH.view.dart';
import './../Views/tabBarPartial.view.dart';

class ContestDetailModel {
  static ContestDetailModel _instance;
  static ContestDetailModel get instance{
    if(_instance == null){
      _instance = new ContestDetailModel();
    }
    return _instance;
  }
  static String contestDuration;
  void setContestDuration(String  duration){
    contestDuration = duration;
  }

  String getContestDuration(){
    return contestDuration;
  }

  ContestData contestDetailModel;
  void setContestDetail(contestDetail){
    contestDetailModel = contestDetail;
  }

  Future<ContestDetailPojo> getContestDetail(int contestId,int matchId) async {
    http.Response response = await http.post("https://www.proxykhel.com/android/contest.php",
    body:{
      "matchId":matchId.toString(),
      "contestId":contestId.toString(),
      "type":"getContestDetail"
    });

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        print(res);
        return contestDetailFromJson(response.body);
      }
      else{
        return null;
      }
    }else{
      return null;
    }
  }
}


ContestDetailPojo contestDetailFromJson(String str) => ContestDetailPojo.fromJson(json.decode(str));

String contestDetailToJson(ContestDetailPojo data) => json.encode(data.toJson());

class ContestDetailPojo {
  bool success;
  Data data;

  ContestDetailPojo({
    this.success,
    this.data,
  });

  factory ContestDetailPojo.fromJson(Map<String, dynamic> json) => new ContestDetailPojo(
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
  String sportId;
  String contestName;
  String matchId;
  String contestAmt;
  String winnersAmt;
  String maxTeam;
  String totlaJoin;
  String contestType;
  String status;
  DateTime insertDatetime;
  String ipAddress;
  String winnerPercentage;
  String loserPercentage;
  String winner;
  String proxyPercentage;
  String singleEntry;
  String multiEntry;
  String winingAmtVary;
  String opponent;
  String contestCancel;
  String distrubution;
  String singleDistrubution;
  String rangeDistrubution;
  String entryfee;
  String cancelOn;

  Data({
    this.id,
    this.sportId,
    this.contestName,
    this.matchId,
    this.contestAmt,
    this.winnersAmt,
    this.maxTeam,
    this.totlaJoin,
    this.contestType,
    this.status,
    this.insertDatetime,
    this.ipAddress,
    this.winnerPercentage,
    this.loserPercentage,
    this.winner,
    this.proxyPercentage,
    this.singleEntry,
    this.multiEntry,
    this.winingAmtVary,
    this.opponent,
    this.contestCancel,
    this.distrubution,
    this.singleDistrubution,
    this.rangeDistrubution,
    this.entryfee,
    this.cancelOn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    id: json["id"],
    sportId: json["sportId"],
    contestName: json["contestName"],
    matchId: json["matchId"],
    contestAmt: json["contestAmt"],
    winnersAmt: json["winnersAmt"],
    maxTeam: json["maxTeam"],
    totlaJoin: json["totlaJoin"],
    contestType: json["contestType"],
    status: json["status"],
    insertDatetime: DateTime.parse(json["insertDatetime"]),
    ipAddress: json["ipAddress"],
    winnerPercentage: json["winner_percentage"],
    loserPercentage: json["loser_percentage"],
    winner: json["winner"],
    proxyPercentage: json["proxy_percentage"],
    singleEntry: json["single_entry"],
    multiEntry: json["multi_entry"],
    winingAmtVary: json["wining_amt_vary"],
    opponent: json["opponent"],
    contestCancel: json["contest_cancel"],
    distrubution: json["distrubution"],
    singleDistrubution: json["single_distrubution"],
    rangeDistrubution: json["range_distrubution"],
    entryfee: json["entryfee"],
    cancelOn: json["cancel_on"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sportId": sportId,
    "contestName": contestName,
    "matchId": matchId,
    "contestAmt": contestAmt,
    "winnersAmt": winnersAmt,
    "maxTeam": maxTeam,
    "totlaJoin": totlaJoin,
    "contestType": contestType,
    "status": status,
    "insertDatetime": insertDatetime.toIso8601String(),
    "ipAddress": ipAddress,
    "winner_percentage": winnerPercentage,
    "loser_percentage": loserPercentage,
    "winner": winner,
    "proxy_percentage": proxyPercentage,
    "single_entry": singleEntry,
    "multi_entry": multiEntry,
    "wining_amt_vary": winingAmtVary,
    "opponent": opponent,
    "contest_cancel": contestCancel,
    "distrubution": distrubution,
    "single_distrubution": singleDistrubution,
    "range_distrubution": rangeDistrubution,
    "entryfee": entryfee,
    "cancel_on": cancelOn,
  };
}
