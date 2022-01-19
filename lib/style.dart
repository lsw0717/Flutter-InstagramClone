import 'package:flutter/material.dart';

var text1 = TextStyle(color: Colors.black);
var text2 = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);

var theme = ThemeData(
    textTheme: TextTheme(bodyText2: text2),
    appBarTheme: AppBarTheme(
        elevation: 1,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 25.0),
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black)),
    iconTheme: IconThemeData(color: Colors.black),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white));
