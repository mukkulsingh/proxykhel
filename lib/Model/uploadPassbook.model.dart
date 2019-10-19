import 'dart:io';

import 'package:proxykhel/Model/savedpref.model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadPassbookModel{
  static UploadPassbookModel _instance;
  static UploadPassbookModel get instance{
    if(_instance == null){
      _instance = new UploadPassbookModel();
    }
    return _instance;
  }

  Future uploadPassbook(var image)async{

    File imageFile = image;
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    String fileName = imageFile.path.split("/").last;
    String userId = await SavedPref.instance.getUserId();
    http.Response response = await http.post("https://www.proxykhel.com/android/uploadPassbook.php",body:{
      "type":"uploadPassbook",
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