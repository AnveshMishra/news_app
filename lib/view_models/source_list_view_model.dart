
import 'package:flutter/foundation.dart';
import 'package:news_project/service/api_services/ApiService.dart';
import 'package:news_project/view_models/source_view_model.dart';

import '../models/news_article.dart';

class SourceListViewModel extends ChangeNotifier{

  List<SourceViewModel> source = [];

  SourceListViewModel(){
    _getSource();
  }

  _getSource()async{
    List<Source> _sourceList =  await ApiService.fetchSources();
    source = _sourceList.map((element) => SourceViewModel(source: element)).toList();
    update();
  }

  update(){
    notifyListeners();
  }


}