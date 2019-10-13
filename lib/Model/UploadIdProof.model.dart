import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'savedpref.model.dart';
class UploadIdProofModel{
  static UploadIdProofModel _instance;
  static int _type;

  void setType(int type){_type = type;}
  get getType=>_type;
  
  static UploadIdProofModel get instance{
    if(_instance == null){
      _instance = new UploadIdProofModel();
    }
    return _instance;
  }
  
  Future uploadIdProof(var image) async  {
    File imageFile = image;
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    String fileName = imageFile.path.split("/").last;
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/UploadIdProof.php",body: {
      "type":"uploadIdProof",
      "userId":userId,
      "imageString":base64Image,
      "name":fileName,
      "type":_type.toString()
    });
    if(response.statusCode == 200){
      final res = json.decode(response.body);
      print(res);
//      if(res['success']==true){
//        return true;
//      }else{
//        return false;
//      }
    }else{
      return false;
    }
  }
}