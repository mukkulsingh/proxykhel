import 'dart:convert';
import 'package:http/http.dart' as http;
import './../Constants/contestdata.dart';

class ContestDetailModel {


  static ContestDetailModel _instance;

  static ContestDetailModel get instance{
    if(_instance == null){
      _instance = new ContestDetailModel();
    }
    return _instance;
  }
  static String contestId;
  static String contestDuration;
  static String currentmatchId;
  static String teamname1;
  static String teamname2;
  static String _matchType;
  void setMatchType(String matchType){
    _matchType = matchType;
  }

  String getMatchType(){
    return _matchType;
  }


  void setContestDuration(String  duration){
    contestDuration = duration;
  }

  void setContestId(String contestID){
    contestId = contestID;
  }

  String getContestId(){
    return contestId;
  }


  void setMatchId(String matchId){
    currentmatchId = matchId;
  }
  void setTeam1Name(String team1name){
    teamname1 = team1name;
  }

  void setTeam2Name(String team2name){
    teamname2 = team2name;
  }
  String getMatchId(){
    return currentmatchId;
  }

  String getContestDuration(){
    return contestDuration;
  }
  String getTeam1Name(){
    return teamname1;
  }
  String getTeam2Name(){
    return teamname2;
  }

  ContestData contestDataModel;
  void setContestDetail(contestDetail){

    contestDataModel = contestDetail;
  }

  ContestData getContestData(){
    return contestDataModel;
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
