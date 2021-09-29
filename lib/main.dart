import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treecommerce/src/pages/buys_page.dart';
import 'package:treecommerce/src/pages/error_page.dart';
import 'package:treecommerce/src/pages/home_page.dart';
import 'package:treecommerce/src/pages/launcher_page.dart';
import 'package:treecommerce/src/pages/list_products_page.dart';
import 'package:treecommerce/src/pages/login_page.dart';
import 'package:treecommerce/src/pages/notifications_page.dart';
import 'package:treecommerce/src/pages/search_page.dart';
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
        initialRoute: "launcher",
        routes: {
          'launcher' : (BuildContext context) => LauncherPage(),
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'search' : (BuildContext context) => SearchPage(),
          'error' : (BuildContext context) => ErrorPage(),
          'list' : (BuildContext context) => ListProductsPage(),
          'notifications' : (BuildContext context) => NotificationsPage(),
          'buys' : (BuildContext context) => BuysPage(),
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