import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageStateWidget extends StatelessWidget {
  final String lottieFileName, messageText;

  const PageStateWidget(
      {Key? key, required this.lottieFileName, required this.messageText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 200
            ),
            child: Lottie.asset("assets/images/$lottieFileName", animate: true),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          messageText,
          textAlign: TextAlign.center,
          style: textTheme.headline2,
        )
      ],
    );
  }
}
