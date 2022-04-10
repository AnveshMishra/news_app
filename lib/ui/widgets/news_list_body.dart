import 'package:flutter/material.dart';
import 'package:news_project/ui/widgets/search_bar.dart';
import 'package:provider/provider.dart';
import '../../view_models/news_article_list_view_model.dart';
import 'get_widget_according_to_page_state.dart';

class NewListBody extends StatelessWidget {
  const NewListBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    NewsArticleListViewModel articleViewModel =
        Provider.of<NewsArticleListViewModel>(context);
    return Column(
      children: [
        const SizedBox(
          height: 4,
        ),
        const Flexible(
            flex: 0,
            child: SearchBar(
              isSearchReadOnly: true,
            )),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                "Top Headlines",
                style: textTheme.headline1?.copyWith(
                    color: Colors.black, letterSpacing: 1, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Row(
                children: [
                  Text(
                    "Sort: ",
                    style: textTheme.headline6
                        ?.copyWith(color: Colors.grey.shade900, fontSize: 12),
                  ),
                  Text(
                    articleViewModel.selectedSort,
                    style: textTheme.headline6?.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => <PopupMenuItem>[
                      for (var i in articleViewModel.sortParms)
                        PopupMenuItem(
                          child: Text(
                            "$i",
                            style: textTheme.headline3,
                          ),
                          onTap: () {
                            articleViewModel.fetchNewsAccordingToSort(i);
                          },
                        ),
                    ],
                    icon: const Icon(Icons.arrow_drop_down),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Expanded(
          child: SizedBox(
            child: GetWidgetAccordingToPageState(
              articleViewModel: articleViewModel,
            ),
          ),
        )
      ],
    );
  }
}
