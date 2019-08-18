import 'package:shared_preferences/shared_preferences.dart';
class SavedPref{
  static SavedPref _instance;
  static SavedPref get instance{
    if(_instance == null){
      _instance = new SavedPref();
    }
    return _instance;
  }

  Future<String> getUserId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("userId");
  }

  Future<String> getUsername() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("username");
  }

  Future<String> getEmailId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('emailId');
  }

  Future<String> getFullName() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('fullName');
  }

}
