import 'package:flutter/material.dart';
import 'package:scared_symmetry/views/custom_tab_view.dart';

void main() {
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scripture',
      home: CustomTabView(),
      theme: ThemeData(
        primaryColor: Colors.black,
        hintColor: Colors.red,
        scaffoldBackgroundColor:
            Colors.white, // Dark grey background for scaffold
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        // pageTransitionsTheme: const PageTransitionsTheme(
        //   builders: {
        //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        //   },
        // ),
      ),
    );
  }
}
