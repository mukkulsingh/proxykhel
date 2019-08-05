class ProfileModel{
  static ProfileModel _instance;
  static ProfileModel get instance {
    if(_instance == null){
      _instance = new ProfileModel();
    }
    return _instance;
  }

}