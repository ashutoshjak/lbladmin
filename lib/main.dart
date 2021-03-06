import 'package:flutter/material.dart';
import 'package:lbladmin/pages/bottomnav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LBL Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyBottomNavigationBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

