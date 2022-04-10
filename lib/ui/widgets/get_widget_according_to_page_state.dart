
import 'package:flutter/cupertino.dart';

import '../../value/constants.dart';
import '../../value/enums.dart';
import '../../view_models/news_article_list_view_model.dart';
import '../../view_models/news_article_view_model.dart';
import 'headline_card.dart';
import 'loading_widget.dart';

class GetWidgetAccordingToPageState extends StatelessWidget {
  final NewsArticleListViewModel articleViewModel;
  const GetWidgetAccordingToPageState({Key? key, required this.articleViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(articleViewModel.pageState){
      case PageState.loading:
        return const PageStateWidget(
          lottieFileName: Constants.loaderFile,
          messageText: "Loading ...",
        );
      case PageState.completed:
        return ListView.builder(
          controller: articleViewModel.scrollController,
          itemBuilder: (context, index) {
            if (index < articleViewModel.article.length) {
              NewsArticleViewModel article =
              articleViewModel.article[index];
              return HeadlineCard(
                article: article,
              );
            } else {
              return articleViewModel.hasNext
                  ? const CupertinoActivityIndicator()
                  : const SizedBox();
            }
          },
          itemCount: articleViewModel.article.length + 1,
        );
      case PageState.error:
        return  PageStateWidget(
          lottieFileName: Constants.errorFile,
          messageText: articleViewModel.errorString,
        );
      case PageState.empty:
        return  const PageStateWidget(
          lottieFileName: Constants.noResults,
          messageText: "No news found",
        );
      default:
        return const SizedBox();
    }
  }
}
