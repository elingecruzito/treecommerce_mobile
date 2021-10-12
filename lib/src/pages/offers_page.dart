import 'package:flutter/material.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/offers_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';
import 'package:treecommerce/src/widgets/list_products_widget.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({ Key key }) : super(key: key);

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  OffersService _service;
  UserPreferences _userPreferences;

  @override
  Widget build(BuildContext context) {

    _service = Provider.offersService(context);
    _userPreferences = Provider.userPreferences(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCustom(),
      appBar: simpleAppBar(context, 'Ofertas'),
      body: ListProductsWidget(future: _service.getOffersList(_userPreferences)),
    );
  }
}