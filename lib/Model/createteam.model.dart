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


  Future<CreateTeamDetails> getMatchTeam(String url, String matchId, String team1name, String team2name) async {
    http.Response response = await http.post(url,body: {
      "type":"getTeam",
      "matchId":matchId,
      "team1name":team1name,
      "team2name":team2name,
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return createTeamDetailsFromJson(response.body);
      }
      else{
        return null;
      }
    }else{
      return null;
    }
  }
}


CreateTeamDetails createTeamDetailsFromJson(String str) => CreateTeamDetails.fromJson(json.decode(str));

String createTeamDetailsToJson(CreateTeamDetails data) => json.encode(data.toJson());

class CreateTeamDetails {
  bool success;
  Data data;

  CreateTeamDetails({
    this.success,
    this.data,
  });

  factory CreateTeamDetails.fromJson(Map<String, dynamic> json) => new CreateTeamDetails(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  List<AllRounder> batsman;
  List<AllRounder> supperSticker;
  List<AllRounder> bowler;
  List<AllRounder> allRounder;
  List<AllRounder> wicketKeeper;

  Data({
    this.batsman,
    this.supperSticker,
    this.bowler,
    this.allRounder,
    this.wicketKeeper,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    batsman: new List<AllRounder>.from(json["Batsman"].map((x) => AllRounder.fromJson(x))),
    supperSticker: new List<AllRounder>.from(json["supperSticker"].map((x) => AllRounder.fromJson(x))),
    bowler: new List<AllRounder>.from(json["Bowler"].map((x) => AllRounder.fromJson(x))),
    allRounder: new List<AllRounder>.from(json["AllRounder"].map((x) => AllRounder.fromJson(x))),
    wicketKeeper: new List<AllRounder>.from(json["WicketKeeper"].map((x) => AllRounder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Batsman": new List<dynamic>.from(batsman.map((x) => x.toJson())),
    "supperSticker": new List<dynamic>.from(supperSticker.map((x) => x.toJson())),
    "Bowler": new List<dynamic>.from(bowler.map((x) => x.toJson())),
    "AllRounder": new List<dynamic>.from(allRounder.map((x) => x.toJson())),
    "WicketKeeper": new List<dynamic>.from(wicketKeeper.map((x) => x.toJson())),
  };
}

class AllRounder {
  String id;
  String playerName;
  Country country;
  String imageUrl;
  String credit;
  Teamname teamname;

  AllRounder({
    this.id,
    this.playerName,
    this.country,
    this.imageUrl,
    this.credit,
    this.teamname,
  });

  factory AllRounder.fromJson(Map<String, dynamic> json) => new AllRounder(
    id: json["id"],
    playerName: json["playerName"],
    country: countryValues.map[json["country"]],
    imageUrl: json["imageURL"],
    credit: json["credit"],
    teamname: teamnameValues.map[json["teamname"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "playerName": playerName,
    "country": countryValues.reverse[country],
    "imageURL": imageUrl,
    "credit": credit,
    "teamname": teamnameValues.reverse[teamname],
  };
}

enum Country { KARAIKUDI_KAALAI, LYCA_KOVAI_KINGS }

final countryValues = new EnumValues({
  "Karaikudi Kaalai": Country.KARAIKUDI_KAALAI,
  "Lyca Kovai Kings": Country.LYCA_KOVAI_KINGS
});

enum Teamname { IND, SL }

final teamnameValues = new EnumValues({
  "ind": Teamname.IND,
  "sl": Teamname.SL
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
