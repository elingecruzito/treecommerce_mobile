import 'package:flutter/material.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/inspirated_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';
import 'package:treecommerce/src/widgets/list_products_widget.dart';

class InspiratedPage extends StatefulWidget {
  const InspiratedPage({ Key key }) : super(key: key);

  @override
  _InspiratedPageState createState() => _InspiratedPageState();
}

class _InspiratedPageState extends State<InspiratedPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  InspiratedService _service;
  UserPreferences _userPreferences;

  @override
  Widget build(BuildContext context) {

    _service = Provider.inspiratedService(context);
    _userPreferences = Provider.userPreferences(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCustom(),
      appBar: simpleAppBar(context, 'Inpirado en lo ultimo que viste'),
      body: ListProductsWidget(future: _service.getOffersList(_userPreferences)),
    );
  }
}