import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'savedpref.model.dart';

class InsertBankDetailsModel{
  static InsertBankDetailsModel _instance;
  static InsertBankDetailsModel get instance{
    if(_instance == null){
      _instance = new InsertBankDetailsModel();
    }
    return _instance;
  }

  static String _account;
  static String _ifsc;
  static String _holder;

  void setAccount(String account){_account = account;}
  void setIfsc(String ifsc){_ifsc = ifsc;}
  void setHolder(String Holder){_holder = Holder;}

  get getIfsc =>_ifsc;
  get getHoldr =>_holder;
  get getAccount=>_account;
  
  Future insertBankDetails(var image)async{
    File imageFile = image;
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    String fileName = imageFile.path.split("/").last;
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/uploadBankDetail.php",body:{
      "type":"insertBankDetails",
      "userId":userId,
      "account":_account,
      "ifsc":_ifsc,
      "bankholder":_holder,
      "userId":userId,
      "imageString":base64Image,
      "name":fileName
    });
    if(json.decode(response.body) == true){
      return true;
    }else{
      return false;
    }
  }
}