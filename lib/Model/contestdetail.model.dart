class ContestDetailModel {
  static ContestDetailModel _instance;
  static ContestDetailModel get instance{
    if(_instance == null){
      _instance = new ContestDetailModel();
    }
    return _instance;
  }
}
