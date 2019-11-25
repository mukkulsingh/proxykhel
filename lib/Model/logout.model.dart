import 'package:shared_preferences/shared_preferences.dart';
import './../Constants/slideTransitions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutModel{
  static LogoutModel _instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static LogoutModel get instance{
    if(_instance == null){
      _instance = new LogoutModel();
    }
    return _instance;
  }

  void logoutRequest() async {
    final pref = await SharedPreferences.getInstance();
      _googleSignIn.disconnect();
      _googleSignIn.signOut();
    pref.clear();
  }
}

