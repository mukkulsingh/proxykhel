import 'package:http/http.dart' as http;
import 'dart:convert';
import 'savedpref.model.dart';

class NotificationModel{

  static NotificationModel _instance;

  static NotificationModel get instance{
    if(_instance == null){
      _instance = new NotificationModel();
    }
    return _instance;
  }
  
  Future<NotificationDetail> getNotifications() async {
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/notification.php",body: {
      "type":"getNotifications",
      "userId":userId
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success']==true){
        return notificationDetailFromJson(response.body);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }  
}

NotificationDetail notificationDetailFromJson(String str) => NotificationDetail.fromJson(json.decode(str));

String notificationDetailToJson(NotificationDetail data) => json.encode(data.toJson());

class NotificationDetail {
  bool success;
  String count;
  List<Notif> notif;

  NotificationDetail({
    this.success,
    this.count,
    this.notif,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) => new NotificationDetail(
    success: json["success"],
    count: json["count"],
    notif: new List<Notif>.from(json["notif"].map((x) => Notif.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "notif": new List<dynamic>.from(notif.map((x) => x.toJson())),
  };
}

class Notif {
  String id;
  String userId;
  String role;
  String title;
  String description;
  String flag;
  String status;
  String notificationBy;
  String created;
  dynamic readTime;

  Notif({
    this.id,
    this.userId,
    this.role,
    this.title,
    this.description,
    this.flag,
    this.status,
    this.notificationBy,
    this.created,
    this.readTime,
  });

  factory Notif.fromJson(Map<String, dynamic> json) => new Notif(
    id: json["id"],
    userId: json["user_id"],
    role: json["role"],
    title: json["title"],
    description: json["description"],
    flag: json["flag"],
    status: json["status"],
    notificationBy: json["notification_by"],
    created: json["created"],
    readTime: json["read_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "role": role,
    "title": title,
    "description": description,
    "flag": flag,
    "status": status,
    "notification_by": notificationBy,
    "created": created,
    "read_time": readTime,
  };
}

enum ReadTimeEnum { THE_20190524080213, THE_19700101000000, EMPTY }

final readTimeEnumValues = new EnumValues({
  "": ReadTimeEnum.EMPTY,
  "1970/01/01 00:00:00": ReadTimeEnum.THE_19700101000000,
  "2019/05/24 08:02:13": ReadTimeEnum.THE_20190524080213
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
