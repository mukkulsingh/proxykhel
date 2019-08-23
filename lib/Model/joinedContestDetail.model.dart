import 'dart:convert';
import './savedpref.model.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
class JoinedContestModel{

  AsyncMemoizer _memoizer = new AsyncMemoizer();
  
  static JoinedContestModel _instance;
  
  static JoinedContestModel get instance{
    if(_instance == null){
      _instance = new JoinedContestModel();
    }
    return _instance;
  }
  
  Future getJoinedContestDetail() async {
    return _memoizer.runOnce(()async{
      String userId = await SavedPref.instance.getUserId();

      http.Response response = await http.post("https://www.proxykhel.com/android/joinedmatches.php",body: {"type":"getJoinedContest","userId":userId});
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
    });
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
  String uniqueId;
  String team2;
  String team1;
  String matchType;
  DateTime matchDateTime;
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
  int joinedContest;
  bool allContest;
  String datumTeam2Name;
  String datumTeam1Name;
  String team2Image;
  String team1Image;
  String team1Name;
  String team2Name;

  Datum({
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
    this.joinedContest,
    this.allContest,
    this.datumTeam2Name,
    this.datumTeam1Name,
    this.team2Image,
    this.team1Image,
    this.team1Name,
    this.team2Name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
    id: json["id"],
    uniqueId: json["unique_id"],
    team2: json["team_2"],
    team1: json["team_1"],
    matchType: json["matchType"],
    matchDateTime: DateTime.parse(json["matchDateTime"]),
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
    joinedContest: json["joined_contest"],
    allContest: json["all_contest"],
    datumTeam2Name: json["team_2_name"],
    datumTeam1Name: json["team_1_name"],
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
    "matchDateTime": matchDateTime.toIso8601String(),
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
    "joined_contest": joinedContest,
    "all_contest": allContest,
    "team_2_name": datumTeam2Name,
    "team_1_name": datumTeam1Name,
    "team_2_image": team2Image,
    "team_1_image": team1Image,
    "team1name": team1Name,
    "team2name": team2Name,
  };
}