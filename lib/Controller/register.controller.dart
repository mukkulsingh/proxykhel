import './../Model/register.model.dart';
class Controller{
  static Controller _instance;

  static Controller get instance{
    if(_instance == null){
      _instance = new Controller();
    }
    return _instance;
  }

  Future<String> ifRegistered(String fullName, String emailOrPhone, String password, String url) async {
    int num = await Model.instance.registeringNewUser(fullName, emailOrPhone, password, url);
    String res;
    switch(num){
      case 1:
         res = 'Invalid Phone';
        break;
      case 2:
        res = 'Invalid Email';
        break;
      case 3:
        res = 'user Registered';
        break;
      default:
        res = 'Something Went wrong';
        break;
    }
  }
}