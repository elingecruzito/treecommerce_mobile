import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treecommerce/src/bloc/search_bloc.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/search_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/list_products_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String text = "";
  SearchService _service;
  UserPreferences _preferences;

  @override
  Widget build(BuildContext context) {

    final _searchingBloc = Provider.searchBloc(context);
    _preferences = Provider.userPreferences(context);
    _service = new SearchService();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          size: 25.0
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        backgroundColor: Colors.white,
        title: _appBarSearch(_searchingBloc),
      ),
      body:  SafeArea(
        child: _listSearch()
      ),
    );
  }

  Widget _appBarSearch(SearchBloc _searchingBloc) {

    return Container(
      child: StreamBuilder(
        stream: _searchingBloc.searchingStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar en TreeCommerce ',
              ),
              onChanged: (text){
                setState(() {
                  this.text = text;                  
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _listSearch() {

    if( this.text == "" ){
      return Container();
    }
    return ListProductsWidget(future: _service.getListProducts(_preferences, this.text));
  }
}