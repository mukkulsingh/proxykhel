import 'package:http/http.dart' as http;
import 'dart:convert';

class  CreateTeamModel{
  static CreateTeamModel _instance;
  static CreateTeamModel get instance{
    if(_instance == null){
      _instance = new CreateTeamModel();
    }
    return _instance;
  }


  Future<MatchTeam> getMatchTeam(String url, String matchId, String team1name, String team2name) async {
    http.Response response = await http.post(url,body: {
      "type":"getTeam",
      "matchId":matchId,
      "team1name":team1name,
      "team2name":team2name,
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return matchTeamFromJson(response.body);
      }
      else{
        return null;
      }
    }else{
      return null;
    }
  }
}

MatchTeam matchTeamFromJson(String str) => MatchTeam.fromJson(json.decode(str));

String matchTeamToJson(MatchTeam data) => json.encode(data.toJson());

class MatchTeam {
  bool success;
  Data data;

  MatchTeam({
    this.success,
    this.data,
  });

  factory MatchTeam.fromJson(Map<String, dynamic> json) => new MatchTeam(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Map<String, AllRounder> allRounder;
  Map<String, AllRounder> supperSticker;
  Map<String, AllRounder> bowler;
  Map<String, AllRounder> wicketKeeper;
  Map<String, AllRounder> batsman;

  Data({
    this.allRounder,
    this.supperSticker,
    this.bowler,
    this.wicketKeeper,
    this.batsman,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    allRounder: new Map.from(json["AllRounder"]).map((k, v) => new MapEntry<String, AllRounder>(k, AllRounder.fromJson(v))),
    supperSticker: new Map.from(json["supperSticker"]).map((k, v) => new MapEntry<String, AllRounder>(k, AllRounder.fromJson(v))),
    bowler: new Map.from(json["Bowler"]).map((k, v) => new MapEntry<String, AllRounder>(k, AllRounder.fromJson(v))),
    wicketKeeper: new Map.from(json["WicketKeeper"]).map((k, v) => new MapEntry<String, AllRounder>(k, AllRounder.fromJson(v))),
    batsman: new Map.from(json["Batsman"]).map((k, v) => new MapEntry<String, AllRounder>(k, AllRounder.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "AllRounder": new Map.from(allRounder).map((k, v) => new MapEntry<String, dynamic>(k, v.toJson())),
    "supperSticker": new Map.from(supperSticker).map((k, v) => new MapEntry<String, dynamic>(k, v.toJson())),
    "Bowler": new Map.from(bowler).map((k, v) => new MapEntry<String, dynamic>(k, v.toJson())),
    "WicketKeeper": new Map.from(wicketKeeper).map((k, v) => new MapEntry<String, dynamic>(k, v.toJson())),
    "Batsman": new Map.from(batsman).map((k, v) => new MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class AllRounder {
  String id;
  String playerName;
  Country country;
  String imageUrl;
  String credit;
  Teamname teamname;
  MatchRole matchRole;

  AllRounder({
    this.id,
    this.playerName,
    this.country,
    this.imageUrl,
    this.credit,
    this.teamname,
    this.matchRole,
  });

  factory AllRounder.fromJson(Map<String, dynamic> json) => new AllRounder(
    id: json["id"],
    playerName: json["playerName"],
    country: countryValues.map[json["country"]],
    imageUrl: json["imageURL"],
    credit: json["credit"],
    teamname: teamnameValues.map[json["teamname"]],
    matchRole: matchRoleValues.map[json["matchRole"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "playerName": playerName,
    "country": countryValues.reverse[country],
    "imageURL": imageUrl,
    "credit": credit,
    "teamname": teamnameValues.reverse[teamname],
    "matchRole": matchRoleValues.reverse[matchRole],
  };
}

enum Country { DINDIGUL_DRAGONS, VB_KANCHI_VEERANS }

final countryValues = new EnumValues({
  "Dindigul Dragons": Country.DINDIGUL_DRAGONS,
  "VB Kanchi Veerans": Country.VB_KANCHI_VEERANS
});

enum MatchRole { ALL_ROUNDER, BATSMAN, BOWLER, WICKET_KEEPER }

final matchRoleValues = new EnumValues({
  "AllRounder": MatchRole.ALL_ROUNDER,
  "Batsman": MatchRole.BATSMAN,
  "Bowler": MatchRole.BOWLER,
  "WicketKeeper": MatchRole.WICKET_KEEPER
});

enum Teamname { DD, VKV }

final teamnameValues = new EnumValues({
  "DD": Teamname.DD,
  "VKV": Teamname.VKV
});

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
