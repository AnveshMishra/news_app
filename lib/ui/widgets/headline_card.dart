import 'package:flutter/material.dart';
import 'package:news_project/ui/news_detail_page.dart';
import 'package:news_project/view_models/news_article_view_model.dart';

import 'get_image.dart';
import 'package:timeago/timeago.dart' as timeago;


class HeadlineCard extends StatelessWidget {
  final NewsArticleViewModel article;

  const HeadlineCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewsDetails(articleViewModel: article,),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 6),
        child: Card(
          color: Colors.white,
          shadowColor: Colors.grey.shade400,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        article.source.name,
                        style: theme.textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        article.title,
                        style: theme.textTheme.headline3,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        timeago.format(DateTime.parse(article.publishAt ?? "")),
                        style: theme.textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Hero(
                    tag: (article.imageUrl != null &&
                        article.imageUrl != "null")
                        ? article.imageUrl!
                        : article.description,
                    child: GetImage(articleViewModel:article)
                  ),
                  margin: const EdgeInsets.all(8),
                  color: Colors.black,
                  height: 100,
                  width: 100,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
