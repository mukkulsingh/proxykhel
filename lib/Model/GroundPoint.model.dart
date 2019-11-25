import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proxykhel/Model/LeaderBoard.model.dart';
import 'package:proxykhel/Model/ViewTeam.model.dart';
import 'package:proxykhel/Model/savedpref.model.dart';

class GroundPointModel{

  static GroundPointModel _instance;

  static GroundPointModel get instance{
    if(_instance == null){
      _instance = new GroundPointModel();
    }
    return _instance;
  }
  
  Future getGroundPoint() async {
    String userid  = await SavedPref.instance.getUserId();
    print(LeaderBoardModel.instance.getMatchId);
    print(LeaderBoardModel.instance.getContestId);
    print(ViewTeamModel.instance.getTeamId);

    http.Response response = await http.post("https://www.proxykhel.com/android/score.php",body:{
      "type":"getContestGroundScore",
      "matchId":LeaderBoardModel.instance.getMatchId,
      "contestId":LeaderBoardModel.instance.getContestId,
      "userId":userid,
      "squadId":ViewTeamModel.instance.getTeamId,
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return groundPointDetailFromJson(response.body);
      }else{
        return null;
      }
    }
  }
}


GroundPointDetail groundPointDetailFromJson(String str) => GroundPointDetail.fromJson(json.decode(str));

String groundPointDetailToJson(GroundPointDetail data) => json.encode(data.toJson());

class GroundPointDetail {
  bool success;
  List<Datum> data;

  GroundPointDetail({
    this.success,
    this.data,
  });

  factory GroundPointDetail.fromJson(Map<String, dynamic> json) => GroundPointDetail(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  dynamic totalPoints;
  dynamic bt;
  dynamic bw;
  dynamic wk;
  dynamic ar;
  dynamic sp;
  dynamic ss;
  dynamic ext;
  dynamic p1;
  dynamic p2;
  dynamic p3;
  dynamic p4;
  dynamic p5;

  Datum({
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    totalPoints: json["totalPoints"].toDouble(),
    bt: json["bt"],
    bw: json["bw"].toDouble(),
    wk: json["wk"].toDouble(),
    ar: json["ar"],
    sp: json["sp"],
    ss: json["ss"],
    ext: json["ext"],
    p1: json["p1"],
    p2: json["p2"],
    p3: json["p3"].toDouble(),
    p4: json["p4"].toDouble(),
    p5: json["p5"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
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
  };
}
