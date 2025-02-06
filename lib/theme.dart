import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.grey, // 앱 주요 색상
    scaffoldBackgroundColor: Colors.white, // 배경 색상
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white, // 앱바 색상
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white), // 앱바 아이콘 색상
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white, // 네비게이션 바 배경색
      selectedItemColor: Colors.black, // 선택된 아이콘 색상
      unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black, // 앱 주요 색상
    scaffoldBackgroundColor: Colors.black, // 배경 색상
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black, // 앱바 색상
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white), // 앱바 아이콘 색상
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black, // 네비게이션 바 배경색
      selectedItemColor: Colors.white, // 선택된 아이콘 색상
      unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
    ),
  );
}
