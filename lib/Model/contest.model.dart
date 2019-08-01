import 'dart:convert';
import 'package:http/http.dart' as http;

class ContestModel{
  static ContestModel _instance;

  static ContestModel get instance {
    if(_instance == null){
      _instance = new ContestModel();
    }
    return _instance;
  }
  
  Future<ContestList> getContestList(String matchId) async {
    http.Response response = await http.post("https://www.proxykhel.com/android/contest.php",body: {"matchId":matchId,"type":"getContests"});
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success'] == true){
        ContestList contestList = contestListFromJson(response.body);
        return contestList;
      }else{
        return null;
      }
    }
    else{
      return null;
    }
  }
}


ContestList contestListFromJson(String str) => ContestList.fromJson(json.decode(str));

String contestListToJson(ContestList data) => json.encode(data.toJson());

class ContestList {
  bool success;
  List<Datum> data;

  ContestList({
    this.success,
    this.data,
  });

  factory ContestList.fromJson(Map<String, dynamic> json) => new ContestList(
    success: json["success"],
    data: new List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": new List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String matchId;
  String winnersAmt;
  String maxTeam;
  String totlaJoin;
  String winner;
  String proxyPercentage;
  String singleEntry;
  String multiEntry;
  String winingAmtVary;
  String opponent;
  String contestCancel;
  String entryfee;

  Datum({
    this.id,
    this.matchId,
    this.winnersAmt,
    this.maxTeam,
    this.totlaJoin,
    this.winner,
    this.proxyPercentage,
    this.singleEntry,
    this.multiEntry,
    this.winingAmtVary,
    this.opponent,
    this.contestCancel,
    this.entryfee,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
    id: json["id"],
    matchId: json["matchId"],
    winnersAmt: json["winnersAmt"],
    maxTeam: json["maxTeam"],
    totlaJoin: json["totlaJoin"],
    winner: json["winner"],
    proxyPercentage: json["proxy_percentage"],
    singleEntry: json["single_entry"],
    multiEntry: json["multi_entry"],
    winingAmtVary: json["wining_amt_vary"],
    opponent: json["opponent"],
    contestCancel: json["contest_cancel"],
    entryfee: json["entryfee"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "matchId": matchId,
    "winnersAmt": winnersAmt,
    "maxTeam": maxTeam,
    "totlaJoin": totlaJoin,
    "winner": winner,
    "proxy_percentage": proxyPercentage,
    "single_entry": singleEntry,
    "multi_entry": multiEntry,
    "wining_amt_vary": winingAmtVary,
    "opponent": opponent,
    "contest_cancel": contestCancel,
    "entryfee": entryfee,
  };
}
