class NewsArticle {
  final String? title, description, urlToImage, url,publishedAt,content;
  final Source source;

  NewsArticle(
      {required this.title,
      required this.content,
      required this.description,
      required this.urlToImage,
      required this.url,
      required this.publishedAt,
      required this.source});

  factory NewsArticle.fromJSON(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'],
      source: Source.fromJSON(json['source']),
      publishedAt: json['publishedAt'], content: json['content'],
    );
  }
}

class Source {
  final String? id;
  final String name;

  Source({required this.id, required this.name});

  factory Source.fromJSON(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }
}
