import 'package:flutter/material.dart';
import 'package:html_parse/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.redAccent,
      ),
      home: new HomePage(title: ''),
    );
  }
}

