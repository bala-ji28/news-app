import 'dart:convert';
import 'package:http/http.dart';
import '../model/news_model.dart';

class ApiService {
  String url =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=53a50f5439804a24bb422eacf072a580';
  Future<List<News>> fetchNews() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<News> newsData =
          body.map((dynamic item) => News.fromJson(item)).toList();
      return newsData;
    } else {
      throw ("No News");
    }
  }
}
