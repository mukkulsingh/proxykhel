import 'package:http/http.dart' as http;
import 'dart:convert';
import 'savedpref.model.dart';

class JoinedContestListModel {


  static String _matchId;
  static String _team1;
  static String _team2;
  static String _matchType;

  void setTeam1(String team1){
    _team1 = team1;
  }

  void setTeam2(String team2){
    _team2 = team2;
  }
  void setMatchId(String matchId){
    _matchId = matchId;
  }

  void setMatchType(String matchType){
    _matchType = matchType;
  }

  get getTeam1=>_team1;
  get getTeam2=>_team2;
  get getMatchType=>_matchType;

  static JoinedContestListModel _instance ;
  static JoinedContestListModel get instance {
    if(_instance == null){
      _instance = new JoinedContestListModel();
    }
    return _instance;
  }
  
  Future<JoinedContestDetail> getJoinedContest() async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/joinedcontest.php",
      body: {
      "type":"getJoinedContest",
        "userId":userId,
        "matchId":_matchId
      }
    );
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return joinedContestDetailFromJson(response.body);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }

}



JoinedContestDetail joinedContestDetailFromJson(String str) => JoinedContestDetail.fromJson(json.decode(str));

String joinedContestDetailToJson(JoinedContestDetail data) => json.encode(data.toJson());

class JoinedContestDetail {
  bool success;
  List<Datum> data;

  JoinedContestDetail({
    this.success,
    this.data,
  });

  factory JoinedContestDetail.fromJson(Map<String, dynamic> json) => new JoinedContestDetail(
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
  String sportId;
  String contestName;
  String matchId;
  String contestAmt;
  String winnersAmt;
  String maxTeam;
  String totlaJoin;
  ContestType contestType;
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
  List<JoinedContest> joinedContest;

  Datum({
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
    this.joinedContest,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
    id: json["id"],
    sportId: json["sportId"],
    contestName: json["contestName"],
    matchId: json["matchId"],
    contestAmt: json["contestAmt"],
    winnersAmt: json["winnersAmt"],
    maxTeam: json["maxTeam"],
    totlaJoin: json["totlaJoin"],
    contestType: contestTypeValues.map[json["contestType"]],
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
    joinedContest: new List<JoinedContest>.from(json["joined_contest"].map((x) => JoinedContest.fromJson(x))),
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
    "contestType": contestTypeValues.reverse[contestType],
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
    "joined_contest": new List<dynamic>.from(joinedContest.map((x) => x.toJson())),
  };
}

enum ContestType { MEGA, PARTIAL, WIN_LOST }

final contestTypeValues = new EnumValues({
  "Mega": ContestType.MEGA,
  "Partial": ContestType.PARTIAL,
  "winLost": ContestType.WIN_LOST
});

class JoinedContest {
  String teamname;
  String id;

  JoinedContest({
    this.teamname,
    this.id,
  });

  factory JoinedContest.fromJson(Map<String, dynamic> json) => new JoinedContest(
    teamname: json["teamname"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "teamname": teamname,
    "id": id,
  };
}



class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}