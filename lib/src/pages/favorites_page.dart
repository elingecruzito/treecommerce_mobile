import 'package:flutter/material.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';
import 'package:treecommerce/src/widgets/list_products_widget.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  Widget build(BuildContext context) {

    final _service = Provider.productService(context);
    final _userPreferences = Provider.userPreferences(context);

    return Scaffold(
      drawer: DrawerCustom(),
      appBar: simpleAppBar(context, 'Favoritos'),
      body: ListProductsWidget(future: _service.getFavoritesProducts(_userPreferences)),
    );
  }
}