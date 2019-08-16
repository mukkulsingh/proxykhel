import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';

class UpcomingMatchModel{

  AsyncMemoizer _memoizer = new AsyncMemoizer();

  static UpcomingMatchModel _instance;

  static UpcomingMatchModel get instance{
    if(_instance == null){
      _instance = new UpcomingMatchModel();
    }
    return _instance;
  }

  Future<MatchData> fetchUpcomingMatch() async {
    http.Response response = await http.post("https://www.proxykhel.com/android/upcomingmatch.php",
        body: {
          "type":"getMatches"
        });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']== 'true' ){
        MatchData matchData = matchDataFromJson(response.body);
        return matchData;
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


MatchData matchDataFromJson(String str) => MatchData.fromJson(json.decode(str));

String matchDataToJson(MatchData data) => json.encode(data.toJson());

class MatchData {
  String success;
  List<MatchDatum> matchData;
  String msg;

  MatchData({
    this.success,
    this.matchData,
    this.msg,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) => new MatchData(
    success: json["success"],
    matchData: new List<MatchDatum>.from(json["matchData"].map((x) => MatchDatum.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "matchData": new List<dynamic>.from(matchData.map((x) => x.toJson())),
    "msg": msg,
  };
}

class MatchDatum {
  String id;
  String uniqueId;
  String team2;
  String team1;
  String matchType;
  String matchDateTime;
  String dateTimeGmt;
  DateTime matchDate;
  String squad;
  String matchStarted;
  String tossWinnerTeam;
  String winnerTeam;
  String manOfTheMatch;
  String status;
  String visibility;
  DateTime insertDatetime;
  DateTime updatedDatetime;
  String ipAddress;
  String matchFinished;
  String description;
  String matchDatumTeam2Name;
  String matchDatumTeam1Name;
  String team2Image;
  String team1Image;
  String team1Name;
  String team2Name;

  MatchDatum({
    this.id,
    this.uniqueId,
    this.team2,
    this.team1,
    this.matchType,
    this.matchDateTime,
    this.dateTimeGmt,
    this.matchDate,
    this.squad,
    this.matchStarted,
    this.tossWinnerTeam,
    this.winnerTeam,
    this.manOfTheMatch,
    this.status,
    this.visibility,
    this.insertDatetime,
    this.updatedDatetime,
    this.ipAddress,
    this.matchFinished,
    this.description,
    this.matchDatumTeam2Name,
    this.matchDatumTeam1Name,
    this.team2Image,
    this.team1Image,
    this.team1Name,
    this.team2Name,
  });

  factory MatchDatum.fromJson(Map<String, dynamic> json) => new MatchDatum(
    id: json["id"],
    uniqueId: json["unique_id"],
    team2: json["team_2"],
    team1: json["team_1"],
    matchType: json["matchType"],
    matchDateTime: json["matchDateTime"],
    dateTimeGmt: json["dateTimeGMT"],
    matchDate: DateTime.parse(json["matchDate"]),
    squad: json["squad"],
    matchStarted: json["matchStarted"],
    tossWinnerTeam: json["tossWinnerTeam"],
    winnerTeam: json["winnerTeam"],
    manOfTheMatch: json["manOfTheMatch"],
    status: json["status"],
    visibility: json["visibility"],
    insertDatetime: DateTime.parse(json["insertDatetime"]),
    updatedDatetime: DateTime.parse(json["updatedDatetime"]),
    ipAddress: json["ipAddress"],
    matchFinished: json["matchFinished"],
    description: json["description"],
    matchDatumTeam2Name: json["team_2_name"],
    matchDatumTeam1Name: json["team_1_name"],
    team2Image: json["team_2_image"],
    team1Image: json["team_1_image"],
    team1Name: json["team1name"],
    team2Name: json["team2name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unique_id": uniqueId,
    "team_2": team2,
    "team_1": team1,
    "matchType": matchType,
    "matchDateTime": matchDateTime,
    "dateTimeGMT": dateTimeGmt,
    "matchDate": "${matchDate.year.toString().padLeft(4, '0')}-${matchDate.month.toString().padLeft(2, '0')}-${matchDate.day.toString().padLeft(2, '0')}",
    "squad": squad,
    "matchStarted": matchStarted,
    "tossWinnerTeam": tossWinnerTeam,
    "winnerTeam": winnerTeam,
    "manOfTheMatch": manOfTheMatch,
    "status": status,
    "visibility": visibility,
    "insertDatetime": insertDatetime.toIso8601String(),
    "updatedDatetime": updatedDatetime.toIso8601String(),
    "ipAddress": ipAddress,
    "matchFinished": matchFinished,
    "description": description,
    "team_2_name": matchDatumTeam2Name,
    "team_1_name": matchDatumTeam1Name,
    "team_2_image": team2Image,
    "team_1_image": team1Image,
    "team1name": team1Name,
    "team2name": team2Name,
  };
}
