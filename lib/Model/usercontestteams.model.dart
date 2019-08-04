import 'dart:convert';
import 'package:http/http.dart' as http;
import 'savedpref.model.dart';
class UserContestTeams{
  static UserContestTeams _instance;
  static UserContestTeams get instance {
    if(_instance == null){
      _instance = new UserContestTeams();
    }
    return _instance;
  }

  Future getUserContestTeams(String url, int matchId, int contestId) async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post(url,body: {
      "type":"getUserTeams",
      "matchId":matchId.toString(),
      "contestId":contestId.toString(),
      "userId":userId,
    });

    if(response.statusCode == 200){

    }
    else{
      return null;
    }
  }

}


UsersTeam usersTeamFromJson(String str) => UsersTeam.fromJson(json.decode(str));

String usersTeamToJson(UsersTeam data) => json.encode(data.toJson());

class UsersTeam {
  bool success;
  List<Datum> data;

  UsersTeam({
    this.success,
    this.data,
  });

  factory UsersTeam.fromJson(Map<String, dynamic> json) => new UsersTeam(
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
