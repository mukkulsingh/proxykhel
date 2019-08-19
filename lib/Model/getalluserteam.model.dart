import 'package:http/http.dart' as http;
import 'dart:convert';
import './../Model/savedpref.model.dart';
import './../Model/contestdetail.model.dart';

class GetAllUserTeamModel{

  static GetAllUserTeamModel _instance;

  static GetAllUserTeamModel get instance {
    if(_instance == null){
      _instance = new GetAllUserTeamModel();
    }
    return _instance;
  }

  Future<GetAllUserTeamDetail>  getAllUserTeam() async {

    String userId = await SavedPref.instance.getUserId();
    String matchId = ContestDetailModel.instance.getMatchId();
    String contestId = ContestDetailModel.instance.getContestId();

    http.Response response = await http.post("https://www.proxykhel.com/android/contest.php",body:{
      "type":"getUserTeam",
      "matchId":matchId,
      "contestId":contestId,
      "userId":userId
    });

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']=='true'){
        return getAllUserTeamDetailFromJson(response.body);
      }
      else{
        return null;
      }
    }
    else{
      return null;
    }
  }

}

GetAllUserTeamDetail getAllUserTeamDetailFromJson(String str) => GetAllUserTeamDetail.fromJson(json.decode(str));

String getAllUserTeamDetailToJson(GetAllUserTeamDetail data) => json.encode(data.toJson());

class GetAllUserTeamDetail {
  String success;
  List<Datum> data;

  GetAllUserTeamDetail({
    this.success,
    this.data,
  });

  factory GetAllUserTeamDetail.fromJson(Map<String, dynamic> json) => new GetAllUserTeamDetail(
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
  int allcount;
  int bowlcount;
  int batcount;
  String starplayer;
  String xplayer;
  int joined;

  Datum({
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
    this.allcount,
    this.bowlcount,
    this.batcount,
    this.starplayer,
    this.xplayer,
    this.joined,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
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
    allcount: json["allcount"],
    bowlcount: json["bowlcount"],
    batcount: json["batcount"],
    starplayer: json["starplayer"],
    xplayer: json["xplayer"],
    joined: json["joined"],
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
    "allcount": allcount,
    "bowlcount": bowlcount,
    "batcount": batcount,
    "starplayer": starplayer,
    "xplayer": xplayer,
    "joined": joined,
  };
}

