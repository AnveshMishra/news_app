import 'package:flutter/cupertino.dart';
import 'package:news_project/value/enums.dart';

import '../models/news_article.dart';
import '../service/api_services/ApiService.dart';
import 'news_article_view_model.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel() {
    _addScrollListener();
  }

  List<NewsArticleViewModel> searchedArticle = [];
  ScrollController scrollController = ScrollController();
  int _page = 1;
  final int _pageSize = 10;
  String searchString = "";
  bool hasNext = false;
  PageState pageState = PageState.idle;
  String errorString = "";

  _fetchEveryThing() async {
    Map<String, dynamic> queryParms = {
      'q':searchString,
      "page":_page.toString(),
      "pageSize":_pageSize.toString(),
    };
    List<NewsArticle> newsArticle;
    try {
      newsArticle = await ApiService.fetchEveryThing(queryParms);
      searchedArticle.addAll(newsArticle
          .map((news) => NewsArticleViewModel(newsArticle: news))
          .toList());
      if(searchedArticle.isEmpty){
        pageState = PageState.empty;
      }else{
        pageState = PageState.completed;
      }
      if(searchedArticle.length>10){
        hasNext = false;
      }else{
        hasNext = true;
      }
    } catch (e) {
      pageState = PageState.error;
      errorString = e.toString();
    }
    notifyListeners();
  }

  getSearchResponse(String searchQuery) {
    if(searchString!=searchQuery){
      searchedArticle.clear();
      pageState = PageState.loading;
      notifyListeners();
      _page = 1;
      searchString = searchQuery;
      _fetchEveryThing();
    }
  }

  _addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        _page = _page + 1;
        _fetchEveryThing();
      }
    });
  }
}
