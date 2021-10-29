import 'package:flutter/material.dart';
import 'package:treecommerce/src/pages/account_page.dart';
import 'package:treecommerce/src/pages/buy_directions_page.dart';
import 'package:treecommerce/src/pages/buy_page.dart';
import 'package:treecommerce/src/pages/buys_page.dart';
import 'package:treecommerce/src/pages/complete_buy_page.dart';
import 'package:treecommerce/src/pages/error_page.dart';
import 'package:treecommerce/src/pages/home_page.dart';
import 'package:treecommerce/src/pages/inspirated_page.dart';
import 'package:treecommerce/src/pages/launcher_page.dart';
import 'package:treecommerce/src/pages/offers_page.dart';
import 'package:treecommerce/src/pages/product_page.dart';
import 'package:treecommerce/src/pages/watched_products_page.dart';
import 'package:treecommerce/src/pages/login_page.dart';
import 'package:treecommerce/src/pages/notifications_page.dart';
import 'package:treecommerce/src/pages/search_page.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final _userPreferences = new UserPreferences();
  await _userPreferences.initPrefs();
  runApp(MyApp());
}

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
          'notifications' : (BuildContext context) => NotificationsPage(),
          'buys' : (BuildContext context) => BuysPage(),
          'account' : (BuildContext context) => AccountPage(),
          'watched' : (BuildContext context) => WatchedProductsPage(),
          'offers' : (BuildContext context) => OffersPage(),
          'inspirated' : (BuildContext context) => InspiratedPage(),
          'product' : (BuildContext context) => ProductPage(),
          'buy_directions' : (BuildContext context) => BuyDirectionsPage(),
          'complete_buy' : (BuildContext context) => CompleteBuyPage(),
          'buy' : (BuildContext context) => BuyPage(),
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