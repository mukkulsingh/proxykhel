import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';
import 'savedpref.model.dart';

class  CreateTeamModel{

  final AsyncMemoizer _memoizer = AsyncMemoizer();


  static int _batsMan;
  static int _bowler;
  static int _wicketKeeper;
  static int _allRounder;
  static int _starPlayer;
  static int _xPlayer;
  static List _superFive=[];

  static CreateTeamModel _instance;
  static CreateTeamModel get instance{
    if(_instance == null){
      _instance = new CreateTeamModel();
    }
    return _instance;
  }

  static int credit=100;

  int getCredit(){
    return credit;
  }



  Future getMatchTeam(String url, String matchId, String team1name, String team2name) async {
    return this._memoizer.runOnce(()async{
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
    });

  }


  void setBatsman(int id){
    _batsMan = id;
  }

  void setBowler(int id){
    _bowler = id;
  }

  void setWicketKeeper(int id){
    _wicketKeeper = id;
  }

  void setAllRounder(int id){
    _allRounder = id;
  }

  void setStarPlayer(int id){
    _starPlayer = id;
  }

  void setXPlayer(int id){
    _xPlayer = id;
  }

  void setSuperFive(List array){
    _superFive=array;
  }

  int getBatsman(){
    return _batsMan;
  }


  Future<dynamic> saveTeam(
      int matchId,
      int contestId,
      int credit,
      String country1,
      String country2,
      ) async {


    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/Createteam.php",body: json.encode(
        {
          "sportId":"1",
          "matchId":matchId,
          "contestId":contestId,
          "userId":userId,
          "batsman":_batsMan,
          "bowler":_bowler,
          "allrounder":_allRounder,
          "wicketkeeper":_wicketKeeper,
          "manofthematch":_starPlayer,
          "superstriker":_xPlayer,
          "credit":credit,
          "player_session":_superFive
        }
    ),
    headers: {'contect-type':'application/json'});
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
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
  List<AllRounder> bowler;
  List<AllRounder> supperSticker;
  List<AllRounder> allRounder;
  List<AllRounder> batsman;
  List<AllRounder> wicketKeeper;

  Data({
    this.bowler,
    this.supperSticker,
    this.allRounder,
    this.batsman,
    this.wicketKeeper,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    bowler: new List<AllRounder>.from(json["Bowler"].map((x) => AllRounder.fromJson(x))),
    supperSticker: new List<AllRounder>.from(json["supperSticker"].map((x) => AllRounder.fromJson(x))),
    allRounder: new List<AllRounder>.from(json["AllRounder"].map((x) => AllRounder.fromJson(x))),
    batsman: new List<AllRounder>.from(json["Batsman"].map((x) => AllRounder.fromJson(x))),
    wicketKeeper: new List<AllRounder>.from(json["WicketKeeper"].map((x) => AllRounder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Bowler": new List<dynamic>.from(bowler.map((x) => x.toJson())),
    "supperSticker": new List<dynamic>.from(supperSticker.map((x) => x.toJson())),
    "AllRounder": new List<dynamic>.from(allRounder.map((x) => x.toJson())),
    "Batsman": new List<dynamic>.from(batsman.map((x) => x.toJson())),
    "WicketKeeper": new List<dynamic>.from(wicketKeeper.map((x) => x.toJson())),
  };
}

class AllRounder {
  String id;
  String playerName;
  String country;
  String imageUrl;
  String credit;
  String teamname;
  bool isSelected;

  AllRounder({
    this.id,
    this.playerName,
    this.country,
    this.imageUrl,
    this.credit,
    this.teamname,
    this.isSelected,
  });

  factory AllRounder.fromJson(Map<String, dynamic> json) => new AllRounder(
    id: json["id"],
    playerName: json["playerName"],
    country: json["country"],
    imageUrl: json["imageURL"] == null ? null : json["imageURL"],
    credit: json["credit"],
    teamname: json["teamname"],
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "playerName": playerName,
    "country": country,
    "imageURL": imageUrl == null ? null : imageUrl,
    "credit": credit,
    "teamname": teamname,
    "isSelected":isSelected,
  };
}

enum Country { CHEPAUK_SUPER_GILLIES, DINDIGUL_DRAGONS }

final countryValues = new EnumValues({
  "Chepauk Super Gillies": Country.CHEPAUK_SUPER_GILLIES,
  "Dindigul Dragons": Country.DINDIGUL_DRAGONS
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

