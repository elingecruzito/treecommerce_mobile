import 'package:flutter/material.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/watched_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';
import 'package:treecommerce/src/widgets/list_products_widget.dart';

class WatchedProductsPage extends StatefulWidget {
  WatchedProductsPage({Key key}) : super(key: key);

  @override
  _WatchedProductsPageState createState() => _WatchedProductsPageState();
}

class _WatchedProductsPageState extends State<WatchedProductsPage> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  WatchedService _service;
  UserPreferences _userPreferences;

  @override
  Widget build(BuildContext context) {
    
    _service = Provider.watchedService(context);
    _userPreferences = Provider.userPreferences(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCustom(),
      appBar: simpleAppBar(context, 'Historial'),
      body: ListProductsWidget(future: _service.getWatchedList(_userPreferences)),
    );
  }
  
}