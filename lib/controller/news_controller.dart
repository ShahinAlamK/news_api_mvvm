import 'package:http/http.dart'as http;
import 'package:news_api/utils/api_status.dart';
import 'package:news_api/utils/constants.dart';


class NewsController{

  static Future fetchHeadline()async{
    try{
      final response=await http.get(Uri.parse(Constants.baseUrl+"country=in&category=sports&par_page=1&apikey="+Constants.apikey));
      if(response.statusCode==200){
        print(response.body);
      }
    }catch(error){
      return Failure(code: 502,response:"Something Wrong");
    }
  }

}