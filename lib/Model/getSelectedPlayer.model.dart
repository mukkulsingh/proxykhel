import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proxykhel/Model/contestdetail.model.dart';

class GetSelectedPlayerModel{
  
  static GetSelectedPlayerModel _instance;
  
  static GetSelectedPlayerModel get instance{
    if(_instance == null){
      _instance = new GetSelectedPlayerModel();
    }
    return _instance;
  }
  
  Future getSelectedPlayer(String teamId) async {
    print(teamId);
    print(ContestDetailModel.instance.getTeam1Name());
    print(ContestDetailModel.instance.getTeam2Name());
    http.Response response = await http.post("https://www.proxykhel.com/android/GetSelectedPlayers.php",body: {
      "type":"getSelectedPlayers",
      "teamId":teamId,
      "country1name":ContestDetailModel.instance.getTeam1Name(),
      "country2name":ContestDetailModel.instance.getTeam2Name()
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      print(res);
      if(res['success']==true){
        return getSelectedPlayerDetailFromJson(response.body);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }
  
}

GetSelectedPlayerDetail getSelectedPlayerDetailFromJson(String str) => GetSelectedPlayerDetail.fromJson(json.decode(str));

String getSelectedPlayerDetailToJson(GetSelectedPlayerDetail data) => json.encode(data.toJson());

class GetSelectedPlayerDetail {
  bool success;
  Data data;

  GetSelectedPlayerDetail({
    this.success,
    this.data,
  });

  factory GetSelectedPlayerDetail.fromJson(Map<String, dynamic> json) => GetSelectedPlayerDetail(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Ar bt;
  Ar bw;
  Ar wk;
  Ar ar;
  Ar sp;
  Ar ss;
  Ar p1;
  Ar p2;
  Ar p3;
  Ar p4;
  Ar p5;

  Data({
    this.bt,
    this.bw,
    this.wk,
    this.ar,
    this.sp,
    this.ss,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bt: Ar.fromJson(json["bt"]),
    bw: Ar.fromJson(json["bw"]),
    wk: Ar.fromJson(json["wk"]),
    ar: Ar.fromJson(json["ar"]),
    sp: Ar.fromJson(json["sp"]),
    ss: Ar.fromJson(json["ss"]),
    p1: Ar.fromJson(json["p1"]),
    p2: Ar.fromJson(json["p2"]),
    p3: Ar.fromJson(json["p3"]),
    p4: Ar.fromJson(json["p4"]),
    p5: Ar.fromJson(json["p5"]),
  );

  Map<String, dynamic> toJson() => {
    "bt": bt.toJson(),
    "bw": bw.toJson(),
    "wk": wk.toJson(),
    "ar": ar.toJson(),
    "sp": sp.toJson(),
    "ss": ss.toJson(),
    "p1": p1.toJson(),
    "p2": p2.toJson(),
    "p3": p3.toJson(),
    "p4": p4.toJson(),
    "p5": p5.toJson(),
  };
}

class Ar {
  String id;
  String playerName;
  String credit;
  String team;

  Ar({
    this.id,
    this.playerName,
    this.credit,
    this.team,
  });

  factory Ar.fromJson(Map<String, dynamic> json) => Ar(
    id: json["id"],
    playerName: json["playerName"],
    credit: json["credit"],
    team: json["team"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "playerName": playerName,
    "credit": credit,
    "team": team,
  };
}


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
