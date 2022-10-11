import 'package:flutter/material.dart';
import 'package:news_api/controller/news_controller.dart';
import 'package:news_api/utils/api_status.dart';

import '../models/news_model.dart';

class ViewModel extends ChangeNotifier{

  List<Articles>_newsList=[];
  List<Articles>get newsList=>_newsList;

  bool _isLoading=true;
  bool get isLoading=>_isLoading;

  String?_error;
  String? get Error=>_error;

  setLoading(bool loading)async{
    _isLoading=loading;
    notifyListeners();
  }

  setNewsDataModel(List<Articles> nesModel)async{
    _newsList=nesModel;
    setLoading(false);
    notifyListeners();
  }

  ViewModel(){
    getNewsData();
  }


  getNewsData()async{
    var response=await NewsController.fetchHeadline();
    if(response is Success){
      setNewsDataModel(response.response as List<Articles>);
      notifyListeners();
    }if(response is Failure){
      _error=response.response.toString();
      notifyListeners();
    }
    notifyListeners();
  }

}