import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
//import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Store Manager',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF232323),
        accentColor: const Color(0xFF06d6a0),
        fontFamily: 'SourceSansPro',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
