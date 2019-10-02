import 'package:http/http.dart' as http;
import 'dart:convert';


class GetContestTypeMegaModel{
  static GetContestTypeMegaModel _instance;

  static GetContestTypeMegaModel get instance{
    if(_instance == null){
      _instance = new GetContestTypeMegaModel();
    }
    return _instance;
  }

  Future<GetContestTypeMega> getContestMega(String matchId) async {
    http.Response response = await http.post("https://www.proxykhel.com/android/contest.php",body: {"matchId":matchId,"type":"getContestsMega"});
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success'] == true){
        GetContestTypeMega contestList = getContestTypeMegaFromJson(response.body);
        return contestList;
      }else{
        return null;
      }
    }
    else{
      return null;
    }
  }

}

GetContestTypeMega getContestTypeMegaFromJson(String str) => GetContestTypeMega.fromJson(json.decode(str));

String getContestTypeMegaToJson(GetContestTypeMega data) => json.encode(data.toJson());

class GetContestTypeMega {
  bool success;
  List<Datum> data;

  GetContestTypeMega({
    this.success,
    this.data,
  });

  factory GetContestTypeMega.fromJson(Map<String, dynamic> json) => GetContestTypeMega(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String sportId;
  String contestName;
  String matchId;
  String contestAmt;
  String winnersAmt;
  String maxTeam;
  String totlaJoin;
  ContestType contestType;
  String status;
  DateTime insertDatetime;
  String ipAddress;
  String winnerPercentage;
  String loserPercentage;
  String winner;
  String proxyPercentage;
  String singleEntry;
  String multiEntry;
  String winingAmtVary;
  String opponent;
  String contestCancel;
  String distrubution;
  dynamic singleDistrubution;
  dynamic rangeDistrubution;
  String entryfee;
  String cancelOn;

  Datum({
    this.id,
    this.sportId,
    this.contestName,
    this.matchId,
    this.contestAmt,
    this.winnersAmt,
    this.maxTeam,
    this.totlaJoin,
    this.contestType,
    this.status,
    this.insertDatetime,
    this.ipAddress,
    this.winnerPercentage,
    this.loserPercentage,
    this.winner,
    this.proxyPercentage,
    this.singleEntry,
    this.multiEntry,
    this.winingAmtVary,
    this.opponent,
    this.contestCancel,
    this.distrubution,
    this.singleDistrubution,
    this.rangeDistrubution,
    this.entryfee,
    this.cancelOn,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    sportId: json["sportId"],
    contestName: json["contestName"],
    matchId: json["matchId"],
    contestAmt: json["contestAmt"],
    winnersAmt: json["winnersAmt"],
    maxTeam: json["maxTeam"],
    totlaJoin: json["totlaJoin"],
    contestType: contestTypeValues.map[json["contestType"]],
    status: json["status"],
    insertDatetime: DateTime.parse(json["insertDatetime"]),
    ipAddress: json["ipAddress"],
    winnerPercentage: json["winner_percentage"],
    loserPercentage: json["loser_percentage"],
    winner: json["winner"],
    proxyPercentage: json["proxy_percentage"],
    singleEntry: json["single_entry"],
    multiEntry: json["multi_entry"],
    winingAmtVary: json["wining_amt_vary"],
    opponent: json["opponent"],
    contestCancel: json["contest_cancel"],
    distrubution: json["distrubution"],
    singleDistrubution: json["single_distrubution"],
    rangeDistrubution: json["range_distrubution"],
    entryfee: json["entryfee"],
    cancelOn: json["cancel_on"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sportId": sportId,
    "contestName": contestName,
    "matchId": matchId,
    "contestAmt": contestAmt,
    "winnersAmt": winnersAmt,
    "maxTeam": maxTeam,
    "totlaJoin": totlaJoin,
    "contestType": contestTypeValues.reverse[contestType],
    "status": status,
    "insertDatetime": insertDatetime.toIso8601String(),
    "ipAddress": ipAddress,
    "winner_percentage": winnerPercentage,
    "loser_percentage": loserPercentage,
    "winner": winner,
    "proxy_percentage": proxyPercentage,
    "single_entry": singleEntry,
    "multi_entry": multiEntry,
    "wining_amt_vary": winingAmtVary,
    "opponent": opponent,
    "contest_cancel": contestCancel,
    "distrubution": distrubution,
    "single_distrubution": singleDistrubution,
    "range_distrubution": rangeDistrubution,
    "entryfee": entryfee,
    "cancel_on": cancelOn,
  };
}

enum ContestType { MEGA }

final contestTypeValues = EnumValues({
  "Mega": ContestType.MEGA
});

class RangeDistrubutionElement {
  String firstrange;
  String lastrange;
  String winamt;
  String winper;

  RangeDistrubutionElement({
    this.firstrange,
    this.lastrange,
    this.winamt,
    this.winper,
  });

  factory RangeDistrubutionElement.fromJson(Map<String, dynamic> json) => RangeDistrubutionElement(
    firstrange: json["firstrange"],
    lastrange: json["lastrange"],
    winamt: json["winamt"],
    winper: json["winper"],
  );

  Map<String, dynamic> toJson() => {
    "firstrange": firstrange,
    "lastrange": lastrange,
    "winamt": winamt,
    "winper": winper,
  };
}

class SingleDistrubutionElement {
  String rank;
  String winamt;
  String winper;

  SingleDistrubutionElement({
    this.rank,
    this.winamt,
    this.winper,
  });

  factory SingleDistrubutionElement.fromJson(Map<String, dynamic> json) => SingleDistrubutionElement(
    rank: json["rank"],
    winamt: json["winamt"],
    winper: json["winper"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "winamt": winamt,
    "winper": winper,
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
