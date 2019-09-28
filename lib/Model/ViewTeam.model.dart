import 'dart:convert';

import 'package:http/http.dart' as http;

class ViewTeamModel{
  static ViewTeamModel _instance;

  static ViewTeamModel get instance{
    if(_instance == null){
      _instance = new ViewTeamModel();
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


ViewTeamDetails viewTeamDetailsFromJson(String str) => ViewTeamDetails.fromJson(json.decode(str));

String viewTeamDetailsToJson(ViewTeamDetails data) => json.encode(data.toJson());

class ViewTeamDetails {
  bool success;
  Data data;

  ViewTeamDetails({
    this.success,
    this.data,
  });

  factory ViewTeamDetails.fromJson(Map<String, dynamic> json) => ViewTeamDetails(
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

  Ar({
    this.id,
    this.playerName,
    this.credit,
  });

  factory Ar.fromJson(Map<String, dynamic> json) => Ar(
    id: json["id"],
    playerName: json["playerName"],
    credit: json["credit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "playerName": playerName,
    "credit": credit,
  };
}
