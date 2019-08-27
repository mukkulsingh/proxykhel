import 'package:http/http.dart' as http;
import 'dart:convert';


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


}