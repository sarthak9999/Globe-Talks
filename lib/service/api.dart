import 'dart:convert';
import 'package:http/http.dart';
import 'package:our_news_app/models/article_model.dart';

//Now let's make the HTTP request services
// this class will alows us to make a simple get http request
// from the API and get the Articles and then return a list of Articles

class ApiService {

  Future<List<NewsResponse>> getNews(endPointUrl) async {
    Response res = await get(endPointUrl);
    
    //first of all let's check that we got a 200 statu code: this mean that the request was a success
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      //this line will allow us to get the different articles from the json file and putting them into a list
      List<NewsResponse> news =
          body.map((dynamic item) => NewsResponse.fromJson(item)).toList();

      return news;
    } else {
      throw ("Can't load the News");
    }
  }
}