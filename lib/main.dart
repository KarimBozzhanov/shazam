import 'package:flutter/material.dart';
import 'features/main/views/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shaiqa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff4d194d),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xff4d194d)
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0
        )
      ),
      home: const MainPage()
    );
  }
}