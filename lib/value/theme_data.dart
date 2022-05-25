import 'package:flutter/material.dart';
import 'package:news_project/value/colors.dart';

final themeData = ThemeData(
  useMaterial3: true,
    primarySwatch: Colors.blue,
    textTheme: TextTheme(
      headline1: const TextStyle(
        color: Colors.white,
        letterSpacing: 0.40,
        fontFamily: "HelveticaNeue-Medium",
        fontSize: 20,
      ),
      headline2: TextStyle(
        color: Colors.grey.shade700,
        fontFamily: "HelveticaNeue_Italic",
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
      headline3: TextStyle(
        color: Colors.grey.shade800,
        fontFamily: "HelveticaNeue",
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
        height: 1.5,
        fontSize: 14,
      ),
      headline4: const TextStyle(
        color: Colors.white,
        letterSpacing: 0.6,
        fontFamily: "HelveticaNeueLight",
        fontSize: 12,
      ),
      headline6: const TextStyle(
        color: Colors.grey,
        fontFamily: "HelveticaNeueLight",
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
        fontSize: 10,
      ),
    ),
    scaffoldBackgroundColor: AppColors.appWhiteColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor:AppColors.appBlueColor),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.appBlueColor,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        letterSpacing: 0.40,
        fontFamily: "HelveticaNeue-Medium",
        fontSize: 20,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      side: MaterialStateBorderSide.resolveWith(
              (_) =>  BorderSide(width: 1, color: AppColors.appGreyColor)),
      fillColor: MaterialStateProperty.all(Colors.white),
      checkColor: MaterialStateProperty.all(Colors.blueAccent),
    ),
    unselectedWidgetColor: AppColors.appGreyColor);//grey
