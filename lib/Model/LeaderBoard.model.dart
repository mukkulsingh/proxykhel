import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxykhel/Model/savedpref.model.dart';

class LeaderBoardModel{
  static LeaderBoardModel _instance;
  static LeaderBoardModel get instance{
    if(_instance == null){
      _instance = new LeaderBoardModel();
    }
    return _instance;
  }

  static String  _matchId;
  static String _contestId;

  void setMatchId(String matchId){_matchId = matchId;}
  String get getMatchId=>_matchId;

  void setContestId(String contestId){_contestId = contestId;}
  String get getContestId=>_contestId;

  Future getLeaderBoard()async{
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/score.php",body:{
      "type":"getContestScore",
      "matchId":_matchId,
      "contestId":_contestId,
      "userId": userId
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']== true){
        return leaderBoardDetailFromJson(response.body);
      }
      else{
        return null;
      }
    }else{
      return null;
    }
  }
}

LeaderBoardDetail leaderBoardDetailFromJson(String str) => LeaderBoardDetail.fromJson(json.decode(str));

String leaderBoardDetailToJson(LeaderBoardDetail data) => json.encode(data.toJson());

class LeaderBoardDetail {
  bool success;
  List<Datum> data;

  LeaderBoardDetail({
    this.success,
    this.data,
  });

  factory LeaderBoardDetail.fromJson(Map<String, dynamic> json) => LeaderBoardDetail(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  AllRounder batsman;
  AllRounder bowler;
  AllRounder wicketKeeper;
  AllRounder allRounder;
  ManOfTheMatch manOfTheMatch;
  AllRounder superStriker;
  FantasyWinningPoint fantasyWinningPoint;
  List<Map<String, AllRounder>> fantasyWinningPlayersPoint;
  double totalPoints;
  Teamdata teamdata;

  Datum({
    this.batsman,
    this.bowler,
    this.wicketKeeper,
    this.allRounder,
    this.manOfTheMatch,
    this.superStriker,
    this.fantasyWinningPoint,
    this.fantasyWinningPlayersPoint,
    this.totalPoints,
    this.teamdata,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    batsman: AllRounder.fromJson(json["Batsman"]),
    bowler: AllRounder.fromJson(json["Bowler"]),
    wicketKeeper: AllRounder.fromJson(json["WicketKeeper"]),
    allRounder: AllRounder.fromJson(json["AllRounder"]),
    manOfTheMatch: ManOfTheMatch.fromJson(json["ManOfTheMatch"]),
    superStriker: AllRounder.fromJson(json["SuperStriker"]),
    fantasyWinningPoint: json["FantasyWinningPoint"] == null ? null : FantasyWinningPoint.fromJson(json["FantasyWinningPoint"]),
    fantasyWinningPlayersPoint: List<Map<String, AllRounder>>.from(json["FantasyWinningPlayersPoint"].map((x) => Map.from(x).map((k, v) => MapEntry<String, AllRounder>(k, AllRounder.fromJson(v))))),
    totalPoints: json["totalPoints"].toDouble(),
    teamdata: Teamdata.fromJson(json["teamdata"]),
  );

  Map<String, dynamic> toJson() => {
    "Batsman": batsman.toJson(),
    "Bowler": bowler.toJson(),
    "WicketKeeper": wicketKeeper.toJson(),
    "AllRounder": allRounder.toJson(),
    "ManOfTheMatch": manOfTheMatch.toJson(),
    "SuperStriker": superStriker.toJson(),
    "FantasyWinningPoint": fantasyWinningPoint == null ? null : fantasyWinningPoint.toJson(),
    "FantasyWinningPlayersPoint": List<dynamic>.from(fantasyWinningPlayersPoint.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
    "totalPoints": totalPoints,
    "teamdata": teamdata.toJson(),
  };
}

class AllRounder {
  String eligibiltyPoint;
  Type type;
  dynamic name;
  double perRun;
  double perFour;
  int perSix;
  String perStrikeRate;
  int allRounderCatch;
  String runout;
  int runoutStump;
  int lbw;
  int bowled;
  int perWicket;
  double perDotBall;
  String runsPerOver7;
  String runsPerOver4;
  String eligibility;
  double rewardSixesPoint;
  String rewardStrikeRatePoint;
  double rewardWicketPoint;
  String runsPerOver1;
  String runsPerOver6;
  String runsPerOver3;
  dynamic rewardBattingPoint;
  String eligibilityPoints;
  String rewardStrikeRatePoints;

  AllRounder({
    this.eligibiltyPoint,
    this.type,
    this.name,
    this.perRun,
    this.perFour,
    this.perSix,
    this.perStrikeRate,
    this.allRounderCatch,
    this.runout,
    this.runoutStump,
    this.lbw,
    this.bowled,
    this.perWicket,
    this.perDotBall,
    this.runsPerOver7,
    this.runsPerOver4,
    this.eligibility,
    this.rewardSixesPoint,
    this.rewardStrikeRatePoint,
    this.rewardWicketPoint,
    this.runsPerOver1,
    this.runsPerOver6,
    this.runsPerOver3,
    this.rewardBattingPoint,
    this.eligibilityPoints,
    this.rewardStrikeRatePoints,
  });

  factory AllRounder.fromJson(Map<String, dynamic> json) => AllRounder(
    eligibiltyPoint: json["eligibiltyPoint"] == null ? null : json["eligibiltyPoint"],
    type: json["type"] == null ? null : typeValues.map[json["type"]],
    name: json["Name"],
    perRun: json["perRun"].toDouble(),
    perFour: json["perFour"].toDouble(),
    perSix: json["perSix"],
    perStrikeRate: json["perStrikeRate"],
    allRounderCatch: json["catch"],
    runout: json["runout"],
    runoutStump: json["runoutStump"],
    lbw: json["lbw"],
    bowled: json["bowled"],
    perWicket: json["perWicket"],
    perDotBall: json["perDotBall"].toDouble(),
    runsPerOver7: json["runsPerOver7"] == null ? null : json["runsPerOver7"],
    runsPerOver4: json["runsPerOver4"] == null ? null : json["runsPerOver4"],
    eligibility: json["eligibility"] == null ? null : json["eligibility"],
    rewardSixesPoint: json["rewardSixesPoint"] == null ? null : json["rewardSixesPoint"].toDouble(),
    rewardStrikeRatePoint: json["rewardStrikeRatePoint"] == null ? null : json["rewardStrikeRatePoint"],
    rewardWicketPoint: json["rewardWicketPoint"] == null ? null : json["rewardWicketPoint"].toDouble(),
    runsPerOver1: json["runsPerOver1"] == null ? null : json["runsPerOver1"],
    runsPerOver6: json["runsPerOver6"] == null ? null : json["runsPerOver6"],
    runsPerOver3: json["runsPerOver3"] == null ? null : json["runsPerOver3"],
    rewardBattingPoint: json["rewardBattingPoint"],
    eligibilityPoints: json["eligibilityPoints"] == null ? null : json["eligibilityPoints"],
    rewardStrikeRatePoints: json["rewardStrikeRatePoints"] == null ? null : json["rewardStrikeRatePoints"],
  );

  Map<String, dynamic> toJson() => {
    "eligibiltyPoint": eligibiltyPoint == null ? null : eligibiltyPoint,
    "type": type == null ? null : typeValues.reverse[type],
    "Name": name,
    "perRun": perRun,
    "perFour": perFour,
    "perSix": perSix,
    "perStrikeRate": perStrikeRate,
    "catch": allRounderCatch,
    "runout": runout,
    "runoutStump": runoutStump,
    "lbw": lbw,
    "bowled": bowled,
    "perWicket": perWicket,
    "perDotBall": perDotBall,
    "runsPerOver7": runsPerOver7 == null ? null : runsPerOver7,
    "runsPerOver4": runsPerOver4 == null ? null : runsPerOver4,
    "eligibility": eligibility == null ? null : eligibility,
    "rewardSixesPoint": rewardSixesPoint == null ? null : rewardSixesPoint,
    "rewardStrikeRatePoint": rewardStrikeRatePoint == null ? null : rewardStrikeRatePoint,
    "rewardWicketPoint": rewardWicketPoint == null ? null : rewardWicketPoint,
    "runsPerOver1": runsPerOver1 == null ? null : runsPerOver1,
    "runsPerOver6": runsPerOver6 == null ? null : runsPerOver6,
    "runsPerOver3": runsPerOver3 == null ? null : runsPerOver3,
    "rewardBattingPoint": rewardBattingPoint,
    "eligibilityPoints": eligibilityPoints == null ? null : eligibilityPoints,
    "rewardStrikeRatePoints": rewardStrikeRatePoints == null ? null : rewardStrikeRatePoints,
  };
}

enum Type { ALL_ROUNDER, BATSMAN, BOWLER, SUPER_STRIKER, WICKET_KEEPER }

final typeValues = EnumValues({
  "AllRounder": Type.ALL_ROUNDER,
  "Batsman": Type.BATSMAN,
  "Bowler": Type.BOWLER,
  "SuperStriker": Type.SUPER_STRIKER,
  "WicketKeeper": Type.WICKET_KEEPER
});

class FantasyWinningPoint {
  String fantasyEligibilityPoint;
  String fantasyRewardPoint2;

  FantasyWinningPoint({
    this.fantasyEligibilityPoint,
    this.fantasyRewardPoint2,
  });

  factory FantasyWinningPoint.fromJson(Map<String, dynamic> json) => FantasyWinningPoint(
    fantasyEligibilityPoint: json["fantasyEligibilityPoint"],
    fantasyRewardPoint2: json["fantasyRewardPoint2"],
  );

  Map<String, dynamic> toJson() => {
    "fantasyEligibilityPoint": fantasyEligibilityPoint,
    "fantasyRewardPoint2": fantasyRewardPoint2,
  };
}

class ManOfTheMatch {
  dynamic eligibilityPoint;
  String type;
  String rewardSixesPoint;
  String rewardFoursPoint;
  dynamic rewardStrikeRatePoint;
  String rewardWicketPoint;
  dynamic rewardFiveWicketsPoint;
  dynamic name;
  double perRun;
  int perFour;
  int perSix;
  String perStrikeRate;
  int manOfTheMatchCatch;
  String runout;
  int runoutStump;
  int lbw;
  int bowled;
  int perWicket;
  double perDotBall;
  String runsPerOver4;
  String runsPerOver6;

  ManOfTheMatch({
    this.eligibilityPoint,
    this.type,
    this.rewardSixesPoint,
    this.rewardFoursPoint,
    this.rewardStrikeRatePoint,
    this.rewardWicketPoint,
    this.rewardFiveWicketsPoint,
    this.name,
    this.perRun,
    this.perFour,
    this.perSix,
    this.perStrikeRate,
    this.manOfTheMatchCatch,
    this.runout,
    this.runoutStump,
    this.lbw,
    this.bowled,
    this.perWicket,
    this.perDotBall,
    this.runsPerOver4,
    this.runsPerOver6,
  });

  factory ManOfTheMatch.fromJson(Map<String, dynamic> json) => ManOfTheMatch(
    eligibilityPoint: json["eligibilityPoint"],
    type: json["type"],
    rewardSixesPoint: json["rewardSixesPoint"],
    rewardFoursPoint: json["rewardFoursPoint"],
    rewardStrikeRatePoint: json["rewardStrikeRatePoint"],
    rewardWicketPoint: json["rewardWicketPoint"],
    rewardFiveWicketsPoint: json["rewardFiveWicketsPoint"],
    name: json["Name"],
    perRun: json["perRun"].toDouble(),
    perFour: json["perFour"],
    perSix: json["perSix"],
    perStrikeRate: json["perStrikeRate"],
    manOfTheMatchCatch: json["catch"],
    runout: json["runout"],
    runoutStump: json["runoutStump"],
    lbw: json["lbw"],
    bowled: json["bowled"],
    perWicket: json["perWicket"],
    perDotBall: json["perDotBall"].toDouble(),
    runsPerOver4: json["runsPerOver4"] == null ? null : json["runsPerOver4"],
    runsPerOver6: json["runsPerOver6"] == null ? null : json["runsPerOver6"],
  );

  Map<String, dynamic> toJson() => {
    "eligibilityPoint": eligibilityPoint,
    "type": type,
    "rewardSixesPoint": rewardSixesPoint,
    "rewardFoursPoint": rewardFoursPoint,
    "rewardStrikeRatePoint": rewardStrikeRatePoint,
    "rewardWicketPoint": rewardWicketPoint,
    "rewardFiveWicketsPoint": rewardFiveWicketsPoint,
    "Name": name,
    "perRun": perRun,
    "perFour": perFour,
    "perSix": perSix,
    "perStrikeRate": perStrikeRate,
    "catch": manOfTheMatchCatch,
    "runout": runout,
    "runoutStump": runoutStump,
    "lbw": lbw,
    "bowled": bowled,
    "perWicket": perWicket,
    "perDotBall": perDotBall,
    "runsPerOver4": runsPerOver4 == null ? null : runsPerOver4,
    "runsPerOver6": runsPerOver6 == null ? null : runsPerOver6,
  };
}

class Teamdata {
  String id;
  String userId;
  String sportId;
  String contestId;
  String matchId;
  String batsman;
  String bowler;
  String allrounder;
  String wicketkeeper;
  String manofthematch;
  String superstriker;
  String player1;
  String player2;
  String player3;
  String player4;
  String player5;
  String playerSession;
  String country1Session;
  String country2Session;
  String matchSession;
  String status;
  DateTime insertDatetime;
  String ipAddress;
  String teamname;
  String credit;

  Teamdata({
    this.id,
    this.userId,
    this.sportId,
    this.contestId,
    this.matchId,
    this.batsman,
    this.bowler,
    this.allrounder,
    this.wicketkeeper,
    this.manofthematch,
    this.superstriker,
    this.player1,
    this.player2,
    this.player3,
    this.player4,
    this.player5,
    this.playerSession,
    this.country1Session,
    this.country2Session,
    this.matchSession,
    this.status,
    this.insertDatetime,
    this.ipAddress,
    this.teamname,
    this.credit,
  });

  factory Teamdata.fromJson(Map<String, dynamic> json) => Teamdata(
    id: json["id"],
    userId: json["userId"],
    sportId: json["sportId"],
    contestId: json["contestId"],
    matchId: json["matchId"],
    batsman: json["batsman"],
    bowler: json["bowler"],
    allrounder: json["allrounder"],
    wicketkeeper: json["wicketkeeper"],
    manofthematch: json["manofthematch"],
    superstriker: json["superstriker"],
    player1: json["player1"],
    player2: json["player2"],
    player3: json["player3"],
    player4: json["player4"],
    player5: json["player5"],
    playerSession: json["player_session"],
    country1Session: json["country1_session"],
    country2Session: json["country2_session"],
    matchSession: json["match_session"],
    status: json["status"],
    insertDatetime: DateTime.parse(json["insertDatetime"]),
    ipAddress: json["ipAddress"],
    teamname: json["teamname"],
    credit: json["credit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "sportId": sportId,
    "contestId": contestId,
    "matchId": matchId,
    "batsman": batsman,
    "bowler": bowler,
    "allrounder": allrounder,
    "wicketkeeper": wicketkeeper,
    "manofthematch": manofthematch,
    "superstriker": superstriker,
    "player1": player1,
    "player2": player2,
    "player3": player3,
    "player4": player4,
    "player5": player5,
    "player_session": playerSession,
    "country1_session": country1Session,
    "country2_session": country2Session,
    "match_session": matchSession,
    "status": status,
    "insertDatetime": insertDatetime.toIso8601String(),
    "ipAddress": ipAddress,
    "teamname": teamname,
    "credit": credit,
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
