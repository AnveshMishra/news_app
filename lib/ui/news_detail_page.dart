import 'package:flutter/material.dart';
import 'package:news_project/ui/webview.dart';
import 'package:news_project/ui/widgets/get_image.dart';
import 'package:news_project/view_models/news_article_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsDetails extends StatelessWidget {
  final NewsArticleViewModel articleViewModel;

  const NewsDetails({Key? key, required this.articleViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Hero(
                  tag: (articleViewModel.imageUrl != null &&
                      articleViewModel.imageUrl != "null")
                      ? articleViewModel.imageUrl!
                      : articleViewModel.description,
                  child: GetImage(articleViewModel: articleViewModel),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Opacity(
                    opacity: 0.8,
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          articleViewModel.title,
                          style: textTheme.headline1?.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          articleViewModel.source.name,
                          style: textTheme.headline2?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          timeago.format(
                              DateTime.parse(articleViewModel.publishAt ?? "")),
                          style: textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                        child: Text(
                          articleViewModel.description,
                          style: textTheme.headline3?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                        child: Text(
                          articleViewModel.content,
                          style: textTheme.headline3?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(articleViewModel.url!=null){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppWebView(url: articleViewModel.url!)));
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                "See full story",
                                style: textTheme.headline3?.copyWith(
                                    fontSize: 16,
                                    color: (articleViewModel.url != null)
                                        ? Colors.blue
                                        : Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: (articleViewModel.url != null)
                                    ? Colors.blue
                                    : Colors.grey,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
