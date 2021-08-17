import 'package:flutter/material.dart';
import 'package:treecommerce/src/pages/home_page.dart';
import 'package:treecommerce/src/pages/login_page.dart';
import 'package:treecommerce/src/provider/provider.dart';
 
void main() => runApp(MyApp());

final global_color = Colors.teal[300];
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Tree commerce',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
          primaryColor: global_color, 
          iconTheme: IconThemeData(
            color: global_color
          ), 
          buttonColor: global_color,
        ),
      ),
    );
  }
}