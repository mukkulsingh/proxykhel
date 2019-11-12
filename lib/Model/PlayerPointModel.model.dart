import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proxykhel/Model/savedpref.model.dart';

class PlayerPointModel{

  static PlayerPointModel _instance;

  static PlayerPointModel get instance{
    if(_instance == null){
      _instance = new PlayerPointModel();
    }
    return _instance;
  }

  static String _matchId;
  static String _contestId="20095";
  String name;
  double perRun;
  double perFour;
  int perSix;
  String perStrikeRate;
  String moreRuns1;
  double playerpoint;
  int id;
  int datumCatch;
  String runout;
  int runoutStump;
  int lbw;
  double bowled;
  int perWicket;
  double perDotBall;
  String runsPerOver4;
  String runsPerOver2;
  String runsPerOver6;
  String runsPerOver7;
  String runsPerOver5;
  String runsPerOver1;
  dynamic maidenOver;



  void setMatchId(String matchId){_matchId = matchId;}
  void setContestId(String contestId){_contestId = contestId;}
  void setName(String _name){name = _name;}
  void setPerRun(double _perRun){perRun = _perRun;}
  void setPerFOur(double _perFour){perFour = _perFour;}
  void setPerSix(int _perSix){perSix = _perSix;}
  void setPerStrikeRate(String _perStrikeRate){perStrikeRate = _perStrikeRate;}
  void setMoreRuns(String _moreRuns){moreRuns1 = _moreRuns;}
  void setPlayerPoint(double _playerPoint){playerpoint = _playerPoint;}
  void setId(int _id){id = _id;}
  void setDatumCatch(int _datumCatch){datumCatch = _datumCatch;}
  void setRunOut(String _runOut){runout = _runOut;}
  void setRunOutStump(int _runOutStump){runoutStump = _runOutStump;}
  void setLbw(int _lbw){lbw = _lbw;}
  void setBowled(double _bowled){bowled = _bowled;}
  void setPerWicket(int _perWicket){perWicket = _perWicket;}
  void setPerDotBall(double _perDotBall){perDotBall = _perDotBall;}
  void setRunsPerOver1(String _runsPerOver1){runsPerOver1 = _runsPerOver1;}
  void setRunsPerOver2(String _runsPerOver2){runsPerOver2 = _runsPerOver2;}
//  void setRunsPerOver3(String _runsPerOver3){runsPerOver3 = _runsPerOver3;}
  void setRunsPerOver4(String _runsPerOver4){runsPerOver4 = _runsPerOver4;}
  void setRunsPerOver5(String _runsPerOver5){runsPerOver5 = _runsPerOver5;}
  void setRunsPerOver6(String _runsPerOver6){runsPerOver6 = _runsPerOver6;}
  void setRunsPerOver7(String _runsPerOver7){runsPerOver7 = _runsPerOver7;}



  get getName{
   if(name == null){
     print("here");
     name = "";
     return name;
   }
   return name;
  }
  get getPerRun{
    if(perRun == null){
      perRun =0.0;
      return perRun;
    }
    return perRun;
  }
  get getPerFour  {
    if(perFour == null){
      perFour = 0;
      return perFour;
    }
    return perFour;
  }
  get getPerSix{
    if(perSix == null){
      perSix = 0;
      return perSix;
    }
    return perSix;
  }
  get getPerStrikeRate{
   if(perStrikeRate == null){
     perStrikeRate = "0.0";
     return perStrikeRate;
   }
   return perStrikeRate;
  }
  get getMoreRuns=>moreRuns1;
  get getPlayerpoint=>playerpoint;
  get getId=>id;
  get getDatumBranch=>datumCatch;
  get getRunOut{
    if(runout == null){
      runout = "0";
      return runout;
    }
    return runout;
  }
  get getBowled{
    if(bowled == null){
    bowled = 0;
    return bowled;
    }
    return bowled;
  }
  get getPerWicket{
    if(perWicket == null){
      perWicket = 0;
      return perWicket;
    }
    return perWicket;
  }
  get getPerDotBall{
    if(perDotBall == null){
      perDotBall = 0;
      return perDotBall;
    }
    return perDotBall;
  }

  get getMaidenOver{
    if(maidenOver == null){
      maidenOver = 0;
      return maidenOver;
    }
    return maidenOver;
  }

  get getEconomyRate{

  }

  get getCatch{
    if(datumCatch == null){
      datumCatch = 0;
      return datumCatch;
    }
    return datumCatch;
  }

  get getRunOuts{
    if(runout == null){
      runout = "0";
      return runout;
    }
    return runout;
  }

  get getRunOutStump{
    if(runoutStump == null){
      runoutStump = 0;
      return runoutStump;
    }
    return runoutStump;
  }

  get getLbw{
    if(lbw == null){
      lbw = 0;
      return lbw;
    }
    return lbw;
  }

  get getRunsPerOver1=>runsPerOver1;
  get getRunsPerOver2=>runsPerOver2;
//  get getRunsPerOver3=>runsPerOver3;
  get getRunsPerOver4=>runsPerOver4;
  get getRunsPerOver5=>runsPerOver5;
  get getRunsPerOver6=>runsPerOver6;
  get getRunsPerOver7=>runsPerOver7;

  get getMachId=>_matchId;
  get getContestId=>_contestId;



  Future getPlayerPoint() async {
    String _userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/generalpt.php",body: {
      "type":"getGeneralScore",
      "matchId":_matchId,
      "contestId":_contestId,
      "userId":_userId
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success'] == true){
        return playerPointDetailFromJson(response.body);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }
}

PlayerPointDetail playerPointDetailFromJson(String str) => PlayerPointDetail.fromJson(json.decode(str));

String playerPointDetailToJson(PlayerPointDetail data) => json.encode(data.toJson());

class PlayerPointDetail {
  int star;
  bool success;
  List<Datum> data;

  PlayerPointDetail({
    this.star,
    this.success,
    this.data,
  });

  factory PlayerPointDetail.fromJson(Map<String, dynamic> json) => PlayerPointDetail(
    star: json["star"],
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "star": star,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String name;
  double perRun;
  double perFour;
  int perSix;
  String perStrikeRate;
  String moreRuns1;
  String moreRuns2;
  String moreRuns3;
  String moreRuns4;
  double playerpoint;
  int id;
  int datumCatch;
  String runout;
  int runoutStump;
  int lbw;
  double bowled;
  int perWicket;
  double perDotBall;
  String runsPerOver4;
  String runsPerOver2;
  String runsPerOver6;
  String runsPerOver7;
  String runsPerOver5;
  String runsPerOver1;
  String runsPerOver3;
  dynamic maidenOver;

  Datum({
    this.name,
    this.perRun,
    this.perFour,
    this.perSix,
    this.perStrikeRate,
    this.moreRuns1,
    this.moreRuns2,
    this.moreRuns3,
    this.moreRuns4,
    this.playerpoint,
    this.id,
    this.datumCatch,
    this.runout,
    this.runoutStump,
    this.lbw,
    this.bowled,
    this.perWicket,
    this.perDotBall,
    this.runsPerOver4,
    this.runsPerOver2,
    this.runsPerOver6,
    this.runsPerOver7,
    this.runsPerOver5,
    this.runsPerOver1,
    this.runsPerOver3,
    this.maidenOver,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["Name"],
    perRun: json["perRun"] == null ? null : json["perRun"].toDouble(),
    perFour: json["perFour"] == null ? null : json["perFour"].toDouble(),
    perSix: json["perSix"] == null ? null : json["perSix"],
    perStrikeRate: json["perStrikeRate"] == null ? null : json["perStrikeRate"],
    moreRuns1: json["moreRuns1"] == null ? null : json["moreRuns1"],
    moreRuns2: json["moreRuns2"] == null ? null : json["moreRuns2"],
    moreRuns3: json["moreRuns3"] == null ? null : json["moreRuns3"],
    moreRuns4: json["moreRuns4"] == null ? null : json["moreRuns4"],

    playerpoint: json["playerpoint"].toDouble(),
    id: json["id"],
    datumCatch: json["catch"] == null ? null : json["catch"],
    runout: json["runout"] == null ? null : json["runout"],
    runoutStump: json["runoutStump"] == null ? null : json["runoutStump"],
    lbw: json["lbw"] == null ? null : json["lbw"],
    bowled: json["bowled"] == null ? null : json["bowled"].toDouble(),
    perWicket: json["perWicket"] == null ? null : json["perWicket"],
    perDotBall: json["perDotBall"] == null ? null : json["perDotBall"].toDouble(),
    runsPerOver4: json["runsPerOver4"] == null ? null : json["runsPerOver4"],
    runsPerOver2: json["runsPerOver2"] == null ? null : json["runsPerOver2"],
    runsPerOver6: json["runsPerOver6"] == null ? null : json["runsPerOver6"],
    runsPerOver7: json["runsPerOver7"] == null ? null : json["runsPerOver7"],
    runsPerOver5: json["runsPerOver5"] == null ? null : json["runsPerOver5"],
    runsPerOver1: json["runsPerOver1"] == null ? null : json["runsPerOver1"],
    runsPerOver3: json["runsPerOver3"] == null ? null : json["runsPerOver3"],
    maidenOver: json["maidenOver"] == null ? null : json["maidenOver"],

  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "perRun": perRun == null ? null : perRun,
    "perFour": perFour == null ? null : perFour,
    "perSix": perSix == null ? null : perSix,
    "perStrikeRate": perStrikeRate == null ? null : perStrikeRate,
    "moreRuns1": moreRuns1 == null ? null : moreRuns1,
    "playerpoint": playerpoint,
    "id": id,
    "catch": datumCatch == null ? null : datumCatch,
    "runout": runout == null ? null : runout,
    "runoutStump": runoutStump == null ? null : runoutStump,
    "lbw": lbw == null ? null : lbw,
    "bowled": bowled == null ? null : bowled,
    "perWicket": perWicket == null ? null : perWicket,
    "perDotBall": perDotBall == null ? null : perDotBall,
    "runsPerOver4": runsPerOver4 == null ? null : runsPerOver4,
    "runsPerOver2": runsPerOver2 == null ? null : runsPerOver2,
    "runsPerOver6": runsPerOver6 == null ? null : runsPerOver6,
    "runsPerOver7": runsPerOver7 == null ? null : runsPerOver7,
    "runsPerOver5": runsPerOver5 == null ? null : runsPerOver5,
    "runsPerOver1": runsPerOver1 == null ? null : runsPerOver1,
    "runsPerOver3": runsPerOver3 == null ? null : runsPerOver3,
    "maidenOver":maidenOver==null?null:maidenOver,
  };
}
