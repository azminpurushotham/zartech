import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFFFFFFF),
      backgroundColor: const Color(0xFFFFFFFF),
      canvasColor: const Color(0xFFFFFFFF),
      cardColor: const Color(0xFFFFFFFF),
      disabledColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: const Color(0xFFFF0000)),
      fontFamily: 'Gilroy');
}

TextStyle getCardSmallTextStyle(){
  return const TextStyle(
      color: Colors.white70,
      fontFamily: 'Gilroy',
      fontSize: 12);
}

TextStyle getCardMediumTextStyle(){
  return const TextStyle(
      color: Colors.white70,
      fontFamily: 'Gilroy',
      fontWeight: FontWeight.w600,
      fontSize: 15);
}

