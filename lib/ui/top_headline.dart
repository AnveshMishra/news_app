
import 'package:flutter/material.dart';
import 'package:news_project/ui/widgets/country_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../view_models/news_article_list_view_model.dart';
import '../view_models/source_list_view_model.dart';
import 'widgets/filter_bottom_sheet.dart';
import 'widgets/news_list_body.dart';

class TopHeadlineUI extends StatelessWidget {
  const TopHeadlineUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SourceListViewModel source = Provider.of<SourceListViewModel>(context);
    NewsArticleListViewModel articleViewModel =
    Provider.of<NewsArticleListViewModel>(context);
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showModalBottomSheet(context: context, builder: (_){
        return FilterBottomSheet(source: source,newsArticleVm: articleViewModel,);
      },shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.filter_alt_outlined,color: Colors.white,),
          ),
          articleViewModel.isFilterApplied?Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                height: 6,
                width: 6,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle
                ),
              ),
            ),
          ):const SizedBox()
        ],
      ),),
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: Text("MyNEWS",style: Theme.of(context).textTheme.headline1,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: ()=>showModalBottomSheet(context: context, builder: (_){
                return CountryBottomSheet(newsArticleVm: articleViewModel,);
              },shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("LOCATION",style: textTheme.headline4,),
                  Row(
                    children:  [
                      const Icon(Icons.location_on_sharp,size: 16,),
                      const SizedBox(height: 4,),
                      Text("${articleViewModel.selectedLocation.name}",style: textTheme.headline4,)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: const NewListBody(),
    );
  }
}
