import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_project/models/country_model.dart';
import 'package:news_project/models/news_article.dart';
import 'package:news_project/service/location_service/location_utils.dart';
import 'package:news_project/value/enums.dart';
import 'package:news_project/view_models/news_article_view_model.dart';
import '../service/api_services/ApiService.dart';

class NewsArticleListViewModel extends ChangeNotifier {
  List<NewsArticleViewModel> article = [];
  ScrollController scrollController = ScrollController();
  int _page = 1;
  final int _pageSize = 10;
  late CountryModel selectedLocation;
  bool isFilterApplied = false;
  bool hasNext = false;
  List selectedSource = [];
  final List sortParms = ["publishedAt", "relevancy", "popularity"];
  String selectedSort = "publishedAt";
  PageState pageState = PageState.loading;
  String errorString  = "";

  NewsArticleListViewModel() {
    _initializeView();
  }

  _fetchTopHeadline(Map<String, dynamic> queryParms) async {
    queryParms["page"] = _page.toString();
    queryParms['pageSize'] = _pageSize.toString();
    List<NewsArticle> newsArticle;
    try {
      newsArticle = await ApiService.fetchTopHeadlines(queryParms);
      article.addAll(newsArticle
          .map((news) => NewsArticleViewModel(newsArticle: news))
          .toList());
      if (article.isEmpty) {
        pageState = PageState.empty;
      }else{
        pageState = PageState.completed;
      }
      if (article.length < 10) {
        hasNext = false;
      } else {
        hasNext = true;
      }
    }catch (e) {
      pageState = PageState.error;
    }
    notifyListeners();
  }

  _initializeView() async {
    _addScrollListener();
    CountryModel model = await LocationUtils.getPlacemark();
    selectedLocation = model;
    _fetchTopHeadline({"country": model.isoCountryCode});
  }

  _addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        _page = _page + 1;
        Map<String, dynamic> params = _getQueryParams();
        _fetchTopHeadline(params);
      }
    });
  }

  Map<String, dynamic> _getQueryParams() {
    if (!isFilterApplied) {
      return {"country": selectedLocation.isoCountryCode};
    } else {
      String filterSources = "";
      for (var element in selectedSource) {
        filterSources = filterSources + element + ",";
      }
      return {"sources": filterSources, "sortBy": selectedSort};
    }
  }

  _fetchEveryThing(Map<String, dynamic> queryParms) async {
    List<NewsArticle> newsArticle;
    try {
      newsArticle = await ApiService.fetchEveryThing(queryParms);
      article.addAll(newsArticle
          .map((news) => NewsArticleViewModel(newsArticle: news))
          .toList());
      if(article.isEmpty){
        pageState = PageState.empty;
      }else{
        pageState = PageState.completed;
      }
      if (article.length > 10) {
        hasNext = false;
      } else {
        hasNext = true;
      }
    } catch (e) {
      pageState = PageState.error;
    }
    notifyListeners();
  }

  addOrRemoveSources(String sourceName) {
    if (selectedSource.contains(sourceName)) {
      selectedSource.remove(sourceName);
    } else {
      selectedSource.add(sourceName);
    }
    notifyListeners();
  }

  fetchFilteredData() {
    _clearData();
    isFilterApplied = true;
    _fetchEveryThing(_getQueryParams());
  }

  fetchDataBasedOnLocation() {
    _clearData();
    selectedSource.clear();
    isFilterApplied = false;
    _fetchTopHeadline(_getQueryParams());
  }

  fetchNewsAccordingToSort(String sortingParms) {
    selectedSort = sortingParms;
    notifyListeners();
    Map<String, dynamic> queryParams = {};
    if (isFilterApplied) {
      _clearData();
      queryParams = _getQueryParams();
      queryParams["sortBy"] = sortingParms;
      _fetchEveryThing(queryParams);
    } else {
      Fluttertoast.showToast(msg: "Please also select source form filters");
    }
  }

  _clearData() {
    _page = 1;
    article.clear();
    pageState = PageState.loading;
    notifyListeners();
  }

}
