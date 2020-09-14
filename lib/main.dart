import 'package:flutter/material.dart';
import 'package:prueba_gbp2/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba GBP',
      home: HomePage(),
    );
  }
}