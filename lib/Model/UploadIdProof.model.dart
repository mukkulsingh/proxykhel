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
      "type":"uploadIdProofAadhar",
      "userId":userId,
      "imageString":base64Image,
      "name":fileName,
    });
    if(response.statusCode == 200){
      if(response.body != null){
        if(json.decode(response.body) == true){
          return true;
        }else{
          return false;
        }
      }

    }else{
      return false;
    }
  }

  Future uploadPan(var image) async  {
    File imageFile = image;
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    String fileName = imageFile.path.split("/").last;
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/UploadIdProof.php",body: {
      "type":"uploadIdProofPan",
      "userId":userId,
      "imageString":base64Image,
      "name":fileName
    });
    if(response.statusCode == 200){
      if(response.body != null){
        if(json.decode(response.body) == true){
          return true;
        }else{
          return false;
        }
      }

    }else{
      return false;
    }
  }

}