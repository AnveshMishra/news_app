import 'package:flutter/material.dart';
import 'package:news_project/ui/no_internet_screen.dart';
import 'package:news_project/ui/top_headline.dart';
import 'package:news_project/view_models/internet_connection_checker.dart';
import 'package:news_project/view_models/news_article_list_view_model.dart';
import 'package:news_project/view_models/source_list_view_model.dart';
import 'package:provider/provider.dart';

import 'value/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InternetConnectionCheckerProvider(),
      child: const MaterialAppWithInternetConnectionListener(),
    );
  }
  }


class MaterialAppWithInternetConnectionListener extends StatelessWidget {
  const MaterialAppWithInternetConnectionListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var internetConnection = Provider.of<InternetConnectionCheckerProvider>(context);

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeData,
      home: (internetConnection.isDeviceConnected)?MultiProvider(providers: [
        ChangeNotifierProvider(create:(_)=>NewsArticleListViewModel(),),
        ChangeNotifierProvider(create: (_)=>SourceListViewModel())
      ],
        child: const TopHeadlineUI(),):const NoInternetScreen(),
    );
  }
}


