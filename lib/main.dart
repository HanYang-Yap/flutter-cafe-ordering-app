import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/cart_page.dart';

void main() {
  runApp(TwiceApp());
}

class TwiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TWICE Cafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B9D),
          primary: const Color(0xFFFF6B9D),
          background: const Color(0xFFFFF8F8),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F8),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF6B9D),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: HomePage(),
      routes: {
        '/cart': (context) => CartPage(),
      },
    );
  }
}
//
