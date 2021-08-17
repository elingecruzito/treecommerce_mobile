import 'package:flutter/material.dart';
import 'package:treecommerce/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree commerce',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage()
      },
      theme: ThemeData(
        primaryColor: Colors.greenAccent[300]
      ),
    );
  }
}