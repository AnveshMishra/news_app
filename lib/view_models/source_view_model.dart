
import 'package:news_project/models/news_article.dart';

class SourceViewModel{

  final Source _source;

  SourceViewModel({required Source source}): _source = source;

  String? get id {
    return _source.id;
  }

  String get name {
    return _source.name;
  }
}