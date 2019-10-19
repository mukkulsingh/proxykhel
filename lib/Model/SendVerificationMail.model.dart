import 'package:http/http.dart' as http;
import 'dart:convert';


class SendVerficationMail{
  static SendVerficationMail _instance;
  static SendVerficationMail get instance{
    if(_instance == null){
      _instance = new SendVerficationMail();
    }
    return _instance;
  }

  static String _email;
  void setEmail(String email){_email = email;}
  get getEmail=>_email;

  Future sendVerificationMail() async{
    http.Response response = await http.post("https://www.proxykhel.com/android/sendverificationmail.php",
      body: {
      "type":"EmailVerificationKyc",
        "emailId":_email,
      }
    );

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      if(res['success'] == true){
        return true;
      }
      else{
        return false;
      }
    }
  }
}