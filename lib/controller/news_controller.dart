import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:news_api/models/news_model.dart';
import 'package:news_api/utils/api_status.dart';
import 'package:news_api/utils/constants.dart';


class NewsController{

  static Future<Object> fetchHeadline()async{
    try{
      final response=await http.get(Uri.parse(Constants.baseUrl+"country=in&category=sports&par_page=1&apikey="+Constants.apikey)).timeout(Duration(seconds:5));
      if(response.statusCode==200){
        final decode=jsonDecode(response.body);
        List<Articles> articles=(decode['articles'] as List).map((e) => Articles.fromJson(e)).toList();
        return Success(code: 200,response:articles);
      }
      return Failure(code: 102,response:"Invalid Host");
    }on HttpException{
      return Failure(code: 502,response:"Bad Request");
    }on SocketException{
      return Failure(code: 502,response:"No Internet");
    }on TimeoutException{
      return Failure(code: 202,response: "Response TimeOut");
    }on FormatException{
      return Failure(code: 502,response:"Invalid Formate");
    }catch(error){
      return Failure(code: 502,response:error.toString());
    }
  }

}