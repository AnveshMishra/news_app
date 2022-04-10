
import 'package:flutter/material.dart';
import 'package:news_project/view_models/news_article_view_model.dart';

class GetImage extends StatelessWidget {
  final NewsArticleViewModel articleViewModel;
  const GetImage({Key? key, required this.articleViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(articleViewModel.imageUrl !=null && articleViewModel.imageUrl!="null"){
      return  Image.network(
        articleViewModel.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context,_,__){
          return Image.asset("assets/images/breaking-news.jpg",
            fit: BoxFit.cover,);
        },
      );
    }else{
      return Image.asset("assets/images/breaking-news.jpg",
      fit: BoxFit.cover,);
    }
  }
}
