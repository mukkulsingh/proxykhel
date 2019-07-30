import './../Model/login.model.dart';

class Controller{

  static Controller _instance;

  static Controller get instance{
    if(_instance == null){
      _instance = new Controller();
    }
    return _instance;
  }

  Future<bool> loginRequest(String url, String username, String password) async {
    if(await Model.instance.logginIn(username, password, url)){
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    return Model.instance.checkIfLoggedIn();
  }
}