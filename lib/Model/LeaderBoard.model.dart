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


LeaderBoardDetailOld leaderBoardDetailFromJson1(String str) => LeaderBoardDetailOld.fromJson(json.decode(str));

String leaderBoardDetailToJson1(LeaderBoardDetailOld data) => json.encode(data.toJson());

class LeaderBoardDetailOld {
  bool success;
  List<DatumOld> data;

  LeaderBoardDetailOld({
    this.success,
    this.data,
  });

  factory LeaderBoardDetailOld.fromJson(Map<String, dynamic> json) => LeaderBoardDetailOld(
    success: json["success"],
    data: List<DatumOld>.from(json["data"].map((x) => DatumOld.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumOld {
  AllRounder1 batsman;
  AllRounder1 bowler;
  AllRounder1 wicketKeeper;
  AllRounder1 allRounder;
  ManOfTheMatch1 manOfTheMatch;
  AllRounder1 superStriker;
//  FantasyWinningPoint fantasyWinningPoint;
  List<Map<String, AllRounder1>> fantasyWinningPlayersPoint;
  double totalPoints;
  Teamdata1 teamdata;

  DatumOld({
    this.batsman,
    this.bowler,
    this.wicketKeeper,
    this.allRounder,
    this.manOfTheMatch,
    this.superStriker,
//    this.fantasyWinningPoint,
    this.fantasyWinningPlayersPoint,
    this.totalPoints,
    this.teamdata,
  });

  factory DatumOld.fromJson(Map<String, dynamic> json) => DatumOld(
    batsman: AllRounder1.fromJson(json["Batsman"]),
    bowler: AllRounder1.fromJson(json["Bowler"]),
    wicketKeeper: AllRounder1.fromJson(json["WicketKeeper"]),
    allRounder: AllRounder1.fromJson(json["AllRounder"]),
    manOfTheMatch: ManOfTheMatch1.fromJson(json["ManOfTheMatch"]),
    superStriker: AllRounder1.fromJson(json["SuperStriker"]),
//    fantasyWinningPoint: FantasyWinningPoint.fromJson(json["FantasyWinningPoint"]),
    fantasyWinningPlayersPoint: List<Map<String, AllRounder1>>.from(json["FantasyWinningPlayersPoint"].map((x) => Map.from(x).map((k, v) => MapEntry<String, AllRounder1>(k, AllRounder1.fromJson(v))))),
    totalPoints: json["totalPoints"] == null ? 0 : json["totalPoints"].toDouble(),
    teamdata: Teamdata1.fromJson(json["teamdata"]),
  );

  Map<String, dynamic> toJson() => {
    "Batsman": batsman.toJson(),
    "Bowler": bowler.toJson(),
    "WicketKeeper": wicketKeeper.toJson(),
    "AllRounder": allRounder.toJson(),
    "ManOfTheMatch": manOfTheMatch.toJson(),
    "SuperStriker": superStriker.toJson(),
//    "FantasyWinningPoint": fantasyWinningPoint.toJson(),
    "FantasyWinningPlayersPoint": List<dynamic>.from(fantasyWinningPlayersPoint.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
    "totalPoints": totalPoints,
    "teamdata": teamdata.toJson(),
  };
}

class AllRounder1 {
  String eligibiltyPoint;
  String type;
  dynamic name;
  dynamic perRun;
  dynamic perFour;
  dynamic perSix;
  String perStrikeRate;
  dynamic allRounderCatch;
  String runout;
  dynamic runoutStump;
  dynamic lbw;
  dynamic bowled;
  dynamic perWicket;
  dynamic perDotBall;
  String maidenOver;
  String runsPerOver5;
  String eligibility;
  dynamic rewardFoursPoint;
  String rewardStrikeRatePoint;
  String runsPerOver6;
  String runsPerOver2;
  dynamic rewardBattingPoint;
  String moreRuns1;
  String eligibilityPoints;

  AllRounder1({
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
    this.maidenOver,
    this.runsPerOver5,
    this.eligibility,
    this.rewardFoursPoint,
    this.rewardStrikeRatePoint,
    this.runsPerOver6,
    this.runsPerOver2,
    this.rewardBattingPoint,
    this.moreRuns1,
    this.eligibilityPoints,
  });

  factory AllRounder1.fromJson(Map<String, dynamic> json) => AllRounder1(
    eligibiltyPoint: json["eligibiltyPoint"] == null ? "0" : json["eligibiltyPoint"],
    type: json["type"] == null ? null : json["type"],
    name: json["Name"],
    perRun: json["perRun"] == null? 0.0 : json["perRun"].toDouble(),
    perFour: json["perFour"] == null ? 0.0 : json["perFour"].toDouble(),
    perSix: json["perSix"],
    perStrikeRate: json["perStrikeRate"],
    allRounderCatch: json["catch"],
    runout: json["runout"],
    runoutStump: json["runoutStump"],
    lbw: json["lbw"],
    bowled: json["bowled"],
    perWicket: json["perWicket"],
    perDotBall: json["perDotBall"] == null ? 0.0 : json["perDotBall"].toDouble(),
    maidenOver: json["maidenOver"] == null ? null : json["maidenOver"],
    runsPerOver5: json["runsPerOver5"] == null ? null : json["runsPerOver5"],
    eligibility: json["eligibility"] == null ? null : json["eligibility"],
    rewardFoursPoint: json["rewardFoursPoint"] == null ? null : json["rewardFoursPoint"],
    rewardStrikeRatePoint: json["rewardStrikeRatePoint"] == null ? null : json["rewardStrikeRatePoint"],
    runsPerOver6: json["runsPerOver6"] == null ? null : json["runsPerOver6"],
    runsPerOver2: json["runsPerOver2"] == null ? null : json["runsPerOver2"],
    rewardBattingPoint: json["rewardBattingPoint"],
    moreRuns1: json["moreRuns1"] == null ? null : json["moreRuns1"],
    eligibilityPoints: json["eligibilityPoints"] == null ? null : json["eligibilityPoints"],
  );

  Map<String, dynamic> toJson() => {
    "eligibiltyPoint": eligibiltyPoint == null ? null : eligibiltyPoint,
    "type": type == null ? null : type,
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
    "maidenOver": maidenOver == null ? null : maidenOver,
    "runsPerOver5": runsPerOver5 == null ? null : runsPerOver5,
    "eligibility": eligibility == null ? null : eligibility,
    "rewardFoursPoint": rewardFoursPoint == null ? null : rewardFoursPoint,
    "rewardStrikeRatePoint": rewardStrikeRatePoint == null ? null : rewardStrikeRatePoint,
    "runsPerOver6": runsPerOver6 == null ? null : runsPerOver6,
    "runsPerOver2": runsPerOver2 == null ? null : runsPerOver2,
    "rewardBattingPoint": rewardBattingPoint,
    "moreRuns1": moreRuns1 == null ? null : moreRuns1,
    "eligibilityPoints": eligibilityPoints == null ? null : eligibilityPoints,
  };
}

//class FantasyWinningPoint {
//  String fantasyEligibilityPoint;
//  String fantasyRewardPoint2;
//
//  FantasyWinningPoint({
//    this.fantasyEligibilityPoint,
//    this.fantasyRewardPoint2,
//  });
//
//  factory FantasyWinningPoint.fromJson(Map<String, dynamic> json) => FantasyWinningPoint(
//    fantasyEligibilityPoint: json["fantasyEligibilityPoint"] == null ? "0" : json["fantasyEligibilityPoint"],
//    fantasyRewardPoint2: json["fantasyRewardPoint2"] == null ? "0" : json["fantasyRewardPoint2"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "fantasyEligibilityPoint": fantasyEligibilityPoint,
//    "fantasyRewardPoint2": fantasyRewardPoint2,
//  };
//}

class ManOfTheMatch1 {
//  dynamic eligibilityPoint;
  String type;
  String rewardSixesPoint;
  String rewardFoursPoint;
  dynamic rewardStrikeRatePoint;
  String rewardWicketPoint;
  dynamic rewardFiveWicketsPoint;
  dynamic name;
  dynamic perRun;
  dynamic perFour;
  dynamic perSix;
  String perStrikeRate;
  dynamic manOfTheMatchCatch;
  String runout;
  dynamic runoutStump;
  dynamic lbw;
  dynamic bowled;
  dynamic perWicket;
  dynamic perDotBall;
  String runsPerOver5;

  ManOfTheMatch1({
//    this.eligibilityPoint,
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
    this.runsPerOver5,
  });

  factory ManOfTheMatch1.fromJson(Map<String, dynamic> json) => ManOfTheMatch1(
//    eligibilityPoint: json["eligibilityPoint"] == null ? "0":json["eligibilityPoint"],
    type: json["type"],
    rewardSixesPoint: json["rewardSixesPoint"],
    rewardFoursPoint: json["rewardFoursPoint"],
    rewardStrikeRatePoint: json["rewardStrikeRatePoint"],
    rewardWicketPoint: json["rewardWicketPoint"],
    rewardFiveWicketsPoint: json["rewardFiveWicketsPoint"],
    name: json["Name"],
    perRun: json["perRun"] == null ? 0.0 : json["perRun"].toDouble(),
    perFour: json["perFour"] == null ? 0.0 :json["perFour"].toDouble(),
    perSix: json["perSix"],
    perStrikeRate: json["perStrikeRate"],
    manOfTheMatchCatch: json["catch"],
    runout: json["runout"],
    runoutStump: json["runoutStump"],
    lbw: json["lbw"],
    bowled: json["bowled"],
    perWicket: json["perWicket"],
    perDotBall: json["perDotBall"]== null ? 0.0 : json["perDotBall"].toDouble(),
    runsPerOver5: json["runsPerOver5"] == null ? "0" : json["runsPerOver5"],
  );

  Map<String, dynamic> toJson() => {
//    "eligibilityPoint": eligibilityPoint,
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
    "runsPerOver5": runsPerOver5 == null ? null : runsPerOver5,
  };
}

class Teamdata1 {
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

  Teamdata1({
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

  factory Teamdata1.fromJson(Map<String, dynamic> json) => Teamdata1(
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
  Batsman batsman;
  Bowler bowler;
  Batsman wicketKeeper;
  AllRounder allRounder;
  ManOfTheMatch manOfTheMatch;
  Batsman superStriker;
  dynamic fantasyWinningPoint;
  List<Map<String, FantasyWinningPlayersPoint>> fantasyWinningPlayersPoint;
  double totalPoints;
  int bt;
  int bw;
  double wk;
  double ar;
  double sp;
  double ss;
  dynamic ext;
  int p1;
  int p2;
  double p3;
  int p4;
  int p5;
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
    this.bt,
    this.bw,
    this.wk,
    this.ar,
    this.sp,
    this.ss,
    this.ext,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
    this.teamdata,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    batsman: Batsman.fromJson(json["Batsman"]),
    bowler: Bowler.fromJson(json["Bowler"]),
    wicketKeeper: Batsman.fromJson(json["WicketKeeper"]),
    allRounder: AllRounder.fromJson(json["AllRounder"]),
    manOfTheMatch: ManOfTheMatch.fromJson(json["ManOfTheMatch"]),
    superStriker: Batsman.fromJson(json["SuperStriker"]),
    fantasyWinningPoint: json["FantasyWinningPoint"],
    fantasyWinningPlayersPoint: List<Map<String, FantasyWinningPlayersPoint>>.from(json["FantasyWinningPlayersPoint"].map((x) => Map.from(x).map((k, v) => MapEntry<String, FantasyWinningPlayersPoint>(k, FantasyWinningPlayersPoint.fromJson(v))))),
    totalPoints: json["totalPoints"].toDouble(),
    bt: json["bt"],
    bw: json["bw"],
    wk: json["wk"].toDouble(),
    ar: json["ar"].toDouble(),
    sp: json["sp"].toDouble(),
    ss: json["ss"].toDouble(),
    ext: json["ext"],
    p1: json["p1"],
    p2: json["p2"],
    p3: json["p3"].toDouble(),
    p4: json["p4"],
    p5: json["p5"],
    teamdata: Teamdata.fromJson(json["teamdata"]),
  );

  Map<String, dynamic> toJson() => {
    "Batsman": batsman.toJson(),
    "Bowler": bowler.toJson(),
    "WicketKeeper": wicketKeeper.toJson(),
    "AllRounder": allRounder.toJson(),
    "ManOfTheMatch": manOfTheMatch.toJson(),
    "SuperStriker": superStriker.toJson(),
    "FantasyWinningPoint": fantasyWinningPoint,
    "FantasyWinningPlayersPoint": List<dynamic>.from(fantasyWinningPlayersPoint.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
    "totalPoints": totalPoints,
    "bt": bt,
    "bw": bw,
    "wk": wk,
    "ar": ar,
    "sp": sp,
    "ss": ss,
    "ext": ext,
    "p1": p1,
    "p2": p2,
    "p3": p3,
    "p4": p4,
    "p5": p5,
    "teamdata": teamdata.toJson(),
  };
}

class AllRounder {
  String eligibiltyPoint;
  String type;
  dynamic name;
  double perRun;
  double perFour;
  int perSix;
  String perStrikeRate;
  int perWicket;
  double perDotBall;
  String runsPerOver4;
  String rewardStrikeRatePoint;
  int allRounderCatch;
  String runout;
  int runoutStump;
  int lbw;
  int bowled;
  String runsPerOver3;
  int rewardFoursPoint;
  String moreRuns1;

  AllRounder({
    this.eligibiltyPoint,
    this.type,
    this.name,
    this.perRun,
    this.perFour,
    this.perSix,
    this.perStrikeRate,
    this.perWicket,
    this.perDotBall,
    this.runsPerOver4,
    this.rewardStrikeRatePoint,
    this.allRounderCatch,
    this.runout,
    this.runoutStump,
    this.lbw,
    this.bowled,
    this.runsPerOver3,
    this.rewardFoursPoint,
    this.moreRuns1,
  });

  factory AllRounder.fromJson(Map<String, dynamic> json) => AllRounder(
    eligibiltyPoint: json["eligibiltyPoint"],
    type: json["type"],
    name: json["Name"],
    perRun: json["perRun"].toDouble(),
    perFour: json["perFour"].toDouble(),
    perSix: json["perSix"],
    perStrikeRate: json["perStrikeRate"],
    perWicket: json["perWicket"],
    perDotBall: json["perDotBall"].toDouble(),
    runsPerOver4: json["runsPerOver4"] == null ? null : json["runsPerOver4"],
    rewardStrikeRatePoint: json["rewardStrikeRatePoint"] == null ? null : json["rewardStrikeRatePoint"],
    allRounderCatch: json["catch"] == null ? null : json["catch"],
    runout: json["runout"] == null ? null : json["runout"],
    runoutStump: json["runoutStump"] == null ? null : json["runoutStump"],
    lbw: json["lbw"] == null ? null : json["lbw"],
    bowled: json["bowled"] == null ? null : json["bowled"],
    runsPerOver3: json["runsPerOver3"] == null ? null : json["runsPerOver3"],
    rewardFoursPoint: json["rewardFoursPoint"] == null ? null : json["rewardFoursPoint"],
    moreRuns1: json["moreRuns1"] == null ? null : json["moreRuns1"],
  );

  Map<String, dynamic> toJson() => {
    "eligibiltyPoint": eligibiltyPoint,
    "type": type,
    "Name": name,
    "perRun": perRun,
    "perFour": perFour,
    "perSix": perSix,
    "perStrikeRate": perStrikeRate,
    "perWicket": perWicket,
    "perDotBall": perDotBall,
    "runsPerOver4": runsPerOver4 == null ? null : runsPerOver4,
    "rewardStrikeRatePoint": rewardStrikeRatePoint == null ? null : rewardStrikeRatePoint,
    "catch": allRounderCatch == null ? null : allRounderCatch,
    "runout": runout == null ? null : runout,
    "runoutStump": runoutStump == null ? null : runoutStump,
    "lbw": lbw == null ? null : lbw,
    "bowled": bowled == null ? null : bowled,
    "runsPerOver3": runsPerOver3 == null ? null : runsPerOver3,
    "rewardFoursPoint": rewardFoursPoint == null ? null : rewardFoursPoint,
    "moreRuns1": moreRuns1 == null ? null : moreRuns1,
  };
}

class Batsman {
  String eligibility;
  String type;
  dynamic name;
  double perRun;
  double perFour;
  int perSix;
  String perStrikeRate;
  int batsmanCatch;
  String runout;
  int runoutStump;
  int lbw;
  double bowled;
  int perWicket;
  double perDotBall;
  String runsPerOver2;
  String runsPerOver4;
  String rewardBowlingPoint;
  String runsPerOver1;
  String eligibilityPoints;

  Batsman({
    this.eligibility,
    this.type,
    this.name,
    this.perRun,
    this.perFour,
    this.perSix,
    this.perStrikeRate,
    this.batsmanCatch,
    this.runout,
    this.runoutStump,
    this.lbw,
    this.bowled,
    this.perWicket,
    this.perDotBall,
    this.runsPerOver2,
    this.runsPerOver4,
    this.rewardBowlingPoint,
    this.runsPerOver1,
    this.eligibilityPoints,
  });

  factory Batsman.fromJson(Map<String, dynamic> json) => Batsman(
    eligibility: json["eligibility"] == null ? null : json["eligibility"],
    type: json["type"] == null ? null : json["type"],
    name: json["Name"],
    perRun: json["perRun"] == null ? null : json["perRun"].toDouble(),
    perFour: json["perFour"] == null ? null : json["perFour"].toDouble(),
    perSix: json["perSix"] == null ? null : json["perSix"],
    perStrikeRate: json["perStrikeRate"] == null ? null : json["perStrikeRate"],
    batsmanCatch: json["catch"] == null ? null : json["catch"],
    runout: json["runout"] == null ? null : json["runout"],
    runoutStump: json["runoutStump"] == null ? null : json["runoutStump"],
    lbw: json["lbw"] == null ? null : json["lbw"],
    bowled: json["bowled"] == null ? null : json["bowled"].toDouble(),
    perWicket: json["perWicket"] == null ? null : json["perWicket"],
    perDotBall: json["perDotBall"] == null ? null : json["perDotBall"].toDouble(),
    runsPerOver2: json["runsPerOver2"] == null ? null : json["runsPerOver2"],
    runsPerOver4: json["runsPerOver4"] == null ? null : json["runsPerOver4"],
    rewardBowlingPoint: json["rewardBowlingPoint"] == null ? null : json["rewardBowlingPoint"],
    runsPerOver1: json["runsPerOver1"] == null ? null : json["runsPerOver1"],
    eligibilityPoints: json["eligibilityPoints"] == null ? null : json["eligibilityPoints"],
  );

  Map<String, dynamic> toJson() => {
    "eligibility": eligibility == null ? null : eligibility,
    "type": type == null ? null : type,
    "Name": name,
    "perRun": perRun == null ? null : perRun,
    "perFour": perFour == null ? null : perFour,
    "perSix": perSix == null ? null : perSix,
    "perStrikeRate": perStrikeRate == null ? null : perStrikeRate,
    "catch": batsmanCatch == null ? null : batsmanCatch,
    "runout": runout == null ? null : runout,
    "runoutStump": runoutStump == null ? null : runoutStump,
    "lbw": lbw == null ? null : lbw,
    "bowled": bowled == null ? null : bowled,
    "perWicket": perWicket == null ? null : perWicket,
    "perDotBall": perDotBall == null ? null : perDotBall,
    "runsPerOver2": runsPerOver2 == null ? null : runsPerOver2,
    "runsPerOver4": runsPerOver4 == null ? null : runsPerOver4,
    "rewardBowlingPoint": rewardBowlingPoint == null ? null : rewardBowlingPoint,
    "runsPerOver1": runsPerOver1 == null ? null : runsPerOver1,
    "eligibilityPoints": eligibilityPoints == null ? null : eligibilityPoints,
  };
}

class Bowler {
  String eligibility;
  String type;
  dynamic name;
  int bowlerCatch;
  String runout;
  int runoutStump;
  int lbw;
  double bowled;
  int perWicket;
  double perDotBall;
  String runsPerOver2;

  Bowler({
    this.eligibility,
    this.type,
    this.name,
    this.bowlerCatch,
    this.runout,
    this.runoutStump,
    this.lbw,
    this.bowled,
    this.perWicket,
    this.perDotBall,
    this.runsPerOver2,
  });

  factory Bowler.fromJson(Map<String, dynamic> json) => Bowler(
    eligibility: json["eligibility"],
    type: json["type"],
    name: json["Name"],
    bowlerCatch: json["catch"] == null ? null : json["catch"],
    runout: json["runout"] == null ? null : json["runout"],
    runoutStump: json["runoutStump"] == null ? null : json["runoutStump"],
    lbw: json["lbw"] == null ? null : json["lbw"],
    bowled: json["bowled"] == null ? null : json["bowled"].toDouble(),
    perWicket: json["perWicket"] == null ? null : json["perWicket"],
    perDotBall: json["perDotBall"] == null ? null : json["perDotBall"].toDouble(),
    runsPerOver2: json["runsPerOver2"] == null ? null : json["runsPerOver2"],
  );

  Map<String, dynamic> toJson() => {
    "eligibility": eligibility,
    "type": type,
    "Name": name,
    "catch": bowlerCatch == null ? null : bowlerCatch,
    "runout": runout == null ? null : runout,
    "runoutStump": runoutStump == null ? null : runoutStump,
    "lbw": lbw == null ? null : lbw,
    "bowled": bowled == null ? null : bowled,
    "perWicket": perWicket == null ? null : perWicket,
    "perDotBall": perDotBall == null ? null : perDotBall,
    "runsPerOver2": runsPerOver2 == null ? null : runsPerOver2,
  };
}

class FantasyWinningPlayersPoint {
  dynamic name;
  String eligibility;
  String type;
  double perRun;
  double perFour;
  int perSix;
  String perStrikeRate;
  int fantasyWinningPlayersPointCatch;
  String runout;
  int runoutStump;
  int lbw;
  double bowled;
  int perWicket;
  double perDotBall;
  String runsPerOver2;
  String runsPerOver4;
  String rewardBowlingPoint;
  String runsPerOver1;
  String eligibilityPoints;
  String runsPerOver5;

  FantasyWinningPlayersPoint({
    this.name,
    this.eligibility,
    this.type,
    this.perRun,
    this.perFour,
    this.perSix,
    this.perStrikeRate,
    this.fantasyWinningPlayersPointCatch,
    this.runout,
    this.runoutStump,
    this.lbw,
    this.bowled,
    this.perWicket,
    this.perDotBall,
    this.runsPerOver2,
    this.runsPerOver4,
    this.rewardBowlingPoint,
    this.runsPerOver1,
    this.eligibilityPoints,
    this.runsPerOver5,
  });

  factory FantasyWinningPlayersPoint.fromJson(Map<String, dynamic> json) => FantasyWinningPlayersPoint(
    name: json["Name"],
    eligibility: json["eligibility"] == null ? null : json["eligibility"],
    type: json["type"] == null ? null : json["type"],
    perRun: json["perRun"] == null ? null : json["perRun"].toDouble(),
    perFour: json["perFour"] == null ? null : json["perFour"].toDouble(),
    perSix: json["perSix"] == null ? null : json["perSix"],
    perStrikeRate: json["perStrikeRate"] == null ? null : json["perStrikeRate"],
    fantasyWinningPlayersPointCatch: json["catch"] == null ? null : json["catch"],
    runout: json["runout"] == null ? null : json["runout"],
    runoutStump: json["runoutStump"] == null ? null : json["runoutStump"],
    lbw: json["lbw"] == null ? null : json["lbw"],
    bowled: json["bowled"] == null ? null : json["bowled"].toDouble(),
    perWicket: json["perWicket"] == null ? null : json["perWicket"],
    perDotBall: json["perDotBall"] == null ? null : json["perDotBall"].toDouble(),
    runsPerOver2: json["runsPerOver2"] == null ? null : json["runsPerOver2"],
    runsPerOver4: json["runsPerOver4"] == null ? null : json["runsPerOver4"],
    rewardBowlingPoint: json["rewardBowlingPoint"] == null ? null : json["rewardBowlingPoint"],
    runsPerOver1: json["runsPerOver1"] == null ? null : json["runsPerOver1"],
    eligibilityPoints: json["eligibilityPoints"] == null ? null : json["eligibilityPoints"],
    runsPerOver5: json["runsPerOver5"] == null ? null : json["runsPerOver5"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "eligibility": eligibility == null ? null : eligibility,
    "type": type == null ? null : type,
    "perRun": perRun == null ? null : perRun,
    "perFour": perFour == null ? null : perFour,
    "perSix": perSix == null ? null : perSix,
    "perStrikeRate": perStrikeRate == null ? null : perStrikeRate,
    "catch": fantasyWinningPlayersPointCatch == null ? null : fantasyWinningPlayersPointCatch,
    "runout": runout == null ? null : runout,
    "runoutStump": runoutStump == null ? null : runoutStump,
    "lbw": lbw == null ? null : lbw,
    "bowled": bowled == null ? null : bowled,
    "perWicket": perWicket == null ? null : perWicket,
    "perDotBall": perDotBall == null ? null : perDotBall,
    "runsPerOver2": runsPerOver2 == null ? null : runsPerOver2,
    "runsPerOver4": runsPerOver4 == null ? null : runsPerOver4,
    "rewardBowlingPoint": rewardBowlingPoint == null ? null : rewardBowlingPoint,
    "runsPerOver1": runsPerOver1 == null ? null : runsPerOver1,
    "eligibilityPoints": eligibilityPoints == null ? null : eligibilityPoints,
    "runsPerOver5": runsPerOver5 == null ? null : runsPerOver5,
  };
}

class ManOfTheMatch {
  String eligibilityPoint;
  String type;
  String rewardSixesPoint;
  String rewardFoursPoint;
  dynamic rewardStrikeRatePoint;
  String rewardWicketPoint;
  dynamic rewardFiveWicketsPoint;
  dynamic name;
  dynamic perRun;
  dynamic perFour;
  dynamic perSix;
  String perStrikeRate;
  dynamic manOfTheMatchCatch;
  String runout;
  dynamic runoutStump;
  dynamic lbw;
  dynamic bowled;
  dynamic perWicket;
  dynamic perDotBall;
  String runsPerOver5;
  String runsPerOver4;

  ManOfTheMatch({
    this.eligibilityPoint,
    this.type,
    this.rewardWicketPoint,
    this.name,
    this.perRun,
    this.perFour,
    this.perSix,
    this.perStrikeRate,
    this.perWicket,
    this.perDotBall,
    this.runsPerOver4,
  });

  factory ManOfTheMatch.fromJson(Map<String, dynamic> json) => ManOfTheMatch(
    eligibilityPoint: json["eligibilityPoint"] == null ? null : json["eligibilityPoint"],
    type: json["type"] == null ? null : json["type"],
    rewardWicketPoint: json["rewardWicketPoint"] == null ? null : json["rewardWicketPoint"],
    name: json["Name"],
    perRun: json["perRun"] == null ? null : json["perRun"].toDouble(),
    perFour: json["perFour"] == null ? null : json["perFour"],
    perSix: json["perSix"] == null ? null : json["perSix"],
    perStrikeRate: json["perStrikeRate"] == null ? null : json["perStrikeRate"],
    perWicket: json["perWicket"] == null ? null : json["perWicket"],
    perDotBall: json["perDotBall"] == null ? null : json["perDotBall"],
    runsPerOver4: json["runsPerOver4"] == null ? null : json["runsPerOver4"],
  );

  Map<String, dynamic> toJson() => {
    "eligibilityPoint": eligibilityPoint == null ? null : eligibilityPoint,
    "type": type == null ? null : type,
    "rewardWicketPoint": rewardWicketPoint == null ? null : rewardWicketPoint,
    "Name": name,
    "perRun": perRun == null ? null : perRun,
    "perFour": perFour == null ? null : perFour,
    "perSix": perSix == null ? null : perSix,
    "perStrikeRate": perStrikeRate == null ? null : perStrikeRate,
    "perWicket": perWicket == null ? null : perWicket,
    "perDotBall": perDotBall == null ? null : perDotBall,
    "runsPerOver4": runsPerOver4 == null ? null : runsPerOver4,
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

