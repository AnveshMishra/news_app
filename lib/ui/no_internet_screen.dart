
import 'package:flutter/material.dart';
import 'package:news_project/ui/widgets/loading_widget.dart';
import 'package:news_project/value/constants.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text("MyNEWS"),
        ),
      ),
      body: const Center(
        child: PageStateWidget(
          messageText: "No internet connection",
          lottieFileName: Constants.noInternetFIle,
        ),
      ),
    );
  }
}
