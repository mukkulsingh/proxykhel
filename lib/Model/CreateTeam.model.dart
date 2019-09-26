import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proxykhel/Model/savedpref.model.dart';


class CreateTeamModel{

 static CreateTeamModel _instance;

 static CreateTeamModel get instance{
   if(_instance == null){
     _instance = new CreateTeamModel();
   }
   return _instance;
 }
 static bool _isBatsman=true;
 static bool _isBowler=false;
 static bool _isWicketee=false;
 static bool _isAllRounder=false;
 static bool _isStarPlayer=false;
 static bool _isXPlayer=false;
 static bool _isSuperFive=false;
 static bool _isChosenPlayer=false;

 static int _playerType=1;

 List allPlayers=[];
 List batsman=[];
 List bowler=[];
 List allRounder=[];
 List wicketKeeper=[];
 List starPlayer=[];
 List xPlayer=[];
 List superFive=[];
 List chosenPlayer=[];

 void resetAll() {
   _isBatsman = false;
   _isBowler = false;
   _isWicketee = false;
   _isAllRounder = false;
   _isStarPlayer = false;
   _isXPlayer = false;
   _isSuperFive = false;
   _isChosenPlayer = false;
 }

 void setBatsman(bool isBatsman){_isBatsman = isBatsman; }
 void setBowler(bool isBowler){_isBowler = isBowler;}
 void setWicketee(bool isWicketee){_isWicketee = isWicketee;}
 void setAllRounder(bool isAllRounder){_isAllRounder = isAllRounder;}
 void setStarPlayer(bool starPlayer){_isStarPlayer = starPlayer;}
 void setXPlayer(bool xPlayer){_isXPlayer = xPlayer;}
 void setSuperFive(bool superFive){_isSuperFive = superFive;}
 void setChosenPlayer(bool choosenPlayer){_isChosenPlayer = choosenPlayer;}
 void setPlayerType(int playerType){_playerType = playerType;}

 get getBowler=>_isBowler;
 get getBatsman=>_isBatsman;
 get getWicketee=>_isWicketee;
 get getAllRounder=>_isAllRounder;
 get getStarPlayer=>_isStarPlayer;
 get getXPlayer=>_isXPlayer;
 get getSuperFive=>_isSuperFive;
 get getChosenPlayer=>_isChosenPlayer;

 get getPlayerType=>_playerType;
 get getAllPlayerList=>allPlayers;
 get getAllRounderList=>allRounder;
 get getBatsmanList=>batsman;
 get getBowlerList =>bowler;
 get getWicketKeeperList=>wicketKeeper;
 get getStarPlayerList=>starPlayer;
 get getXPlayerList=>xPlayer;
 get getSuperFiveList=>superFive;
 get getChosenPlayerList=>chosenPlayer;

 int getPlayerColor(int playerIndex, String groupName) {
   for (int i = 0; i < chosenPlayer.length; i++) {
     if (int.parse(chosenPlayer[i]['playerIndex']) == playerIndex &&
         chosenPlayer[i]['groupName'] == groupName)
       return 2;
     else if (int.parse(chosenPlayer[i]['playerIndex']) == playerIndex)
       return 1;
   }
   return 0;
 }

 int getTeamPlayerCount(String teamName){
   int count=0;
   for(int i=0;i<chosenPlayer.length;i++)
     if(chosenPlayer[i]['teamName'] == teamName)count++;
     return count;
 }


 int getPlayerCount(String groupName) {
   int count = 0;
   for (int i = 0; i < chosenPlayer.length; i++)
     if (chosenPlayer[i]['groupName'] == groupName) count++;
   return count;
 }

 double getTotalCreditOfTeam() {
   double credit = 0;
   for (int i = 0; i < chosenPlayer.length; i++)
     credit += double.parse(
         allPlayers[int.parse(chosenPlayer[i]['playerIndex'])].credit);
   return credit;
 }

 int selectPlayer(List playerList, int playerIndex, String groupName,
     String teamName,int allowedSelection,int allowedTeamPlayer) {
   int colorCode = getPlayerColor(playerIndex, groupName);

   if (colorCode == 2) {
     for (int i = 0; i < chosenPlayer.length; i++) {
       if (playerIndex == int.parse(chosenPlayer[i]['playerIndex'])) {
         chosenPlayer.removeAt(i);
       }
     }
     //     deselect player
     return 0;
   } else if (colorCode == 1) {
//     Player already selected
     return 3;
   } else {
     if (allowedSelection == getPlayerCount(groupName)) {
       // show("that this many batsman already selected");
       return 2;
     }
     else if(allowedTeamPlayer == getTeamPlayerCount(teamName)){
       //show allowed selection for one team exhausted
       return 5;
     }
     else if (getTotalCreditOfTeam() +
         double.parse(allPlayers[playerIndex].credit) >
         100) {
       //show('credit limit exeed');
       return 4;
     } else {
       //show('select that player and add it into chosenPlayer');
       Map playerMap = new Map();
       playerMap['playerId'] = allPlayers[playerIndex].id;
       playerMap['playerIndex'] = playerIndex.toString();
       playerMap['groupName'] = groupName;
       playerMap['teamName'] = teamName;
       chosenPlayer.add(playerMap);
       return 1;
//       setState(() {});
     }
   }
 }

 Future getMatchTeam(String matchId, String team1name, String team2name) async {

     http.Response response = await http.post("https://www.proxykhel.com/android/Createteam.php",body: {
       "type":"getTeam",
       "matchId":matchId,
       "team1name":team1name,
       "team2name":team2name,
     });
     if(response.statusCode == 200){
       final res = json.decode(response.body);
       if(res['success']==true){
          CreateTeamDetails createTeamDetails = createTeamDetailsFromJson(response.body);
          allPlayers=[];
          batsman=[];
          bowler=[];
          allRounder=[];
          wicketKeeper=[];
          starPlayer=[];
          xPlayer=[];
          superFive=[];
          chosenPlayer=[];

          allPlayers = createTeamDetails.data.supperSticker;

          for (int i = 0; i < createTeamDetails.data.batsman.length; i++) {
            for (int j = 0; j < allPlayers.length; j++) {
              if (createTeamDetails.data.batsman[i].id == allPlayers[j].id) {
                batsman.add(j);
              }
            }
          }

          for (int i = 0; i < createTeamDetails.data.bowler.length; i++) {
            for (int j = 0; j < allPlayers.length; j++) {
              if (createTeamDetails.data.bowler[i].id == allPlayers[j].id) {
                bowler.add(j);
              }
            }
          }
          for (int i = 0; i < createTeamDetails.data.wicketKeeper.length; i++) {
            for (int j = 0; j < allPlayers.length; j++) {
              if (createTeamDetails.data.wicketKeeper[i].id == allPlayers[j].id) {
                wicketKeeper.add(j);
              }
            }
          }
          for (int i = 0; i < createTeamDetails.data.allRounder.length; i++) {
            for (int j = 0; j < allPlayers.length; j++) {
              if (createTeamDetails.data.allRounder[i].id == allPlayers[j].id) {
                allRounder.add(j);
              }
            }
          }
          for (int i = 0; i < createTeamDetails.data.supperSticker.length; i++) {
            for (int j = 0; j < allPlayers.length; j++) {
              if (createTeamDetails.data.supperSticker[i].id == allPlayers[j].id) {
                starPlayer.add(j);
              }
            }
          }

          for (int i = 0; i < createTeamDetails.data.supperSticker.length; i++) {
            for (int j = 0; j < allPlayers.length; j++) {
              if (createTeamDetails.data.supperSticker[i].id == allPlayers[j].id) {
                xPlayer.add(j);
              }
            }
          }
          for (int i = 0; i < createTeamDetails.data.supperSticker.length; i++) {
            for (int j = 0; j < allPlayers.length; j++) {
              if (createTeamDetails.data.supperSticker[i].id == allPlayers[j].id) {
                superFive.add(j);
              }
            }
          }

          return createTeamDetailsFromJson(response.body);
       }
       else{
         return null;
       }
     }else{
       return null;
     }

 }

 Future<dynamic> saveTeam(
     String matchId,
     String contestId,
     String creadit,
     String country1,
     String country2,
     ) async {



    int batsmanId,bowlerId,WKId, allrounderId,starplayerId,xplayerId;

    List superFive=[];

   String userId = await SavedPref.instance.getUserId();
   for(int i=0;i<CreateTeamModel.instance.getChosenPlayerList.length;i++){
     if(chosenPlayer[i]['groupName'] == 'Batsman'){
        batsmanId = int.parse(chosenPlayer[i]['playerId']);
     }
     else if(chosenPlayer[i]['groupName'] == 'Bowler'){
        bowlerId = int.parse(chosenPlayer[i]['playerId']);

     }
     else if(chosenPlayer[i]['groupName'] == 'Wicket Keeper'){
        WKId = int.parse(chosenPlayer[i]['playerId']);

     }
     else if(chosenPlayer[i]['groupName'] == 'All Rounder'){
        allrounderId = int.parse(chosenPlayer[i]['playerId']);

     }
     else if(chosenPlayer[i]['groupName'] == 'Star Player'){
        starplayerId = int.parse(chosenPlayer[i]['playerId']);

     }
     else if(chosenPlayer[i]['groupName'] == 'X Player'){
        xplayerId = (int.parse(chosenPlayer[i]['playerId']));

     }
     else if(chosenPlayer[i]['groupName'] == 'Super Five'){
       superFive.add(int.parse(chosenPlayer[i]['playerId']));

     }
   }
   http.Response response = await http.post("https://www.proxykhel.com/android/Createteam.php",
       body: {
         "type":"saveTeam",
         "matchId":matchId.toString(),
         "contestId":contestId.toString(),
         "userId":userId.toString(),
         "batsman":batsmanId.toString(),
         "bowler":bowlerId.toString(),
         "allrounder":allrounderId.toString(),
         "wicketkeeper":WKId.toString(),
         "manofthematch":starplayerId.toString(),
         "superstriker":xplayerId.toString(),
         "credit":creadit.toString(),
         "player_session":superFive.toString()
       }
   );
   if(response.statusCode == 200){
     final res = json.decode(response.body);
     if(res['success']=='true' && res['msg']=='ok'){
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

