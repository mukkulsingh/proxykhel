class ContestData{
//  String id;
//  String matchId;
//  String winnersAmt;
//  String maxTeam;
//  String totlaJoin;
//  String winner;
//  String proxyPercentage;
//  String singleEntry;
//  String multiEntry;
//  String winingAmtVary;
//  String opponent;
//  String contestCancel;
//  String entryfee;

  String id;
  String sportId;
  String contestName;
  String matchId;
  String contestAmt;
  String winnersAmt;
  String maxTeam;
  String totlaJoin;
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

  ContestData({
//     this.id,
//     this.matchId,
//     this.winnersAmt,
//      this.maxTeam,
//    this.totlaJoin,
//    this.winner,
//     this.proxyPercentage,
//      this.singleEntry,
//     this.multiEntry,
//     this.winingAmtVary,
//     this.opponent,
//     this.contestCancel,
//     this.entryfee,

    this.id,
    this.sportId,
    this.contestName,
    this.matchId,
    this.contestAmt,
    this.winnersAmt,
    this.maxTeam,
    this.totlaJoin,
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
}

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