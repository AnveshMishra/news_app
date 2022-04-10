import 'dart:convert';

import 'package:news_project/models/news_article.dart';
import 'package:news_project/value/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<NewsArticle>> fetchTopHeadlines(
      Map<String, dynamic> queryParameters) async {
    if (!queryParameters.containsKey("apiKey")) {
      queryParameters["apiKey"] = Constants.apiKey;
    }
    final uri =
    Uri.https(Constants.baseUrl, '/v2/top-headlines', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map responseMap = json.decode(response.body);
      Iterable articleList = responseMap["articles"];
      return articleList
          .map((article) => NewsArticle.fromJSON(article))
          .toList();
    } else {
      throw _handleError(response);
    }
  }

  static Future<List<Source>> fetchSources() async {
    Map<String, dynamic> queryParameters = {};
    queryParameters["apiKey"] = Constants.apiKey;
    final uri = Uri.https(
        Constants.baseUrl, '/v2/top-headlines/sources', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map responseMap = json.decode(response.body);
      Iterable sources = responseMap["sources"];
      return sources.map((source) => Source.fromJSON(source)).toList();
    } else {
      throw _handleError(response);
    }
  }

  static Future<List<NewsArticle>> fetchEveryThing(
      Map<String, dynamic> queryParameters) async {
    if (!queryParameters.containsKey("apiKey")) {
      queryParameters["apiKey"] = Constants.apiKey;
    }
    final uri =
    Uri.https(Constants.baseUrl, '/v2/everything', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map responseMap = json.decode(response.body);
      Iterable articleList = responseMap["articles"];
      return articleList
          .map((article) => NewsArticle.fromJSON(article))
          .toList();
    } else {
      throw _handleError(response);
    }
  }

  static String _handleError(http.Response response) {
    Map responseMap = jsonDecode(response.body);
    switch (response.statusCode) {
      case 400:
        return "400 - Bad Request \n ${responseMap["message"]}";
      case 401:
        return "401 - Unauthorized \n ${responseMap["message"]}";
      case 429:
        return "429 - Too Many Requests \n ${responseMap["message"]}";
      case 500:
      default:
        return "500 - Server Error \n ${responseMap["message"]}";
    }
  }
}