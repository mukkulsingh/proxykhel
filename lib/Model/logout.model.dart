import 'package:shared_preferences/shared_preferences.dart';
import './../Constants/slideTransitions.dart';
class LogoutModel{
  static LogoutModel _instance;

  static LogoutModel get instance{
    if(_instance == null){
      _instance = new LogoutModel();
    }
    return _instance;
  }


  void logoutRequest() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

