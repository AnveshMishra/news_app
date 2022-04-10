
import 'package:news_project/models/news_article.dart';

class NewsArticleViewModel{

  final NewsArticle _newsArticle;

  NewsArticleViewModel({required NewsArticle newsArticle}): _newsArticle = newsArticle;

  String get title {
    return _newsArticle.title ?? "";
  }

  String get description {
    return _newsArticle.description ?? "";
  }

  String? get imageUrl {
    return _newsArticle.urlToImage;
  }

  String? get url{
    return _newsArticle.url;
  }

  Source get source{
    return _newsArticle.source;
  }

  String? get publishAt{
    return _newsArticle.publishedAt;
  }

  String get content{
    return _newsArticle.content ?? "";
  }
}