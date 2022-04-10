import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/ui/widgets/headline_card.dart';
import 'package:news_project/ui/widgets/loading_widget.dart';
import 'package:news_project/ui/widgets/search_bar.dart';
import 'package:news_project/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

import '../value/constants.dart';
import '../value/enums.dart';
import '../view_models/news_article_view_model.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  late SearchViewModel vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = Provider.of<SearchViewModel>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text("Search"),
        ),
      ),
      body: Consumer<SearchViewModel>(
        builder: (BuildContext context, value, Widget? child) {
          return Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Flexible(
                  flex: 0,
                  child: SearchBar(
                    isSearchReadOnly: false,
                    onChangedCallBack: (String query) {
                      value.getSearchResponse(query);
                    },
                  )),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                child: SizedBox(
                  child:getWidgetsAccordingToState(value),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget getWidgetsAccordingToState(SearchViewModel searchViewModel) {
    switch (searchViewModel.pageState) {
      case PageState.loading:
        return const PageStateWidget(
          lottieFileName: Constants.loaderFile,
          messageText: "Loading ...",
        );
      case PageState.completed:
        return ListView.builder(
          controller: searchViewModel.scrollController,
          itemBuilder: (context, index) {
            if (index < searchViewModel.searchedArticle.length) {
              NewsArticleViewModel article =
                  searchViewModel.searchedArticle[index];
              return HeadlineCard(
                key: ValueKey(article.title),
                article: article,
              );
            } else {
              return searchViewModel.hasNext
                  ? const CupertinoActivityIndicator(
                      radius: 24,
                    )
                  : const SizedBox();
            }
          },
          itemCount: searchViewModel.searchedArticle.length + 1,
        );
      case PageState.error:
        return PageStateWidget(
          lottieFileName: Constants.errorFile,
          messageText: searchViewModel.errorString,
        );
      case PageState.empty:
        return const PageStateWidget(
          lottieFileName: Constants.noResults,
          messageText: "No news found",
        );
      default:
        return const SizedBox();
    }
  }
}
