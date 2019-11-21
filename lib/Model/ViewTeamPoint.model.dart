import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ViewTeam.model.dart';

class ViewTeamPointModel{
  static ViewTeamPointModel _instance;

  static ViewTeamPointModel get instance{
    if(_instance == null){
      _instance = new ViewTeamPointModel();
    }
    return _instance;
  }

  static String _teamId;

  void setTeamId(String teamId){_teamId = teamId;}
  get getTeamId=>_teamId;

  Future getViewTeam()async{
    http.Response response = await http.post("https://www.proxykhel.com/android/ViewTeam.php",body: {
      "type":"getViewTeam",
      "teamId":_teamId.toString(),
    });

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return viewTeamDetailsFromJson(response.body);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }
}


