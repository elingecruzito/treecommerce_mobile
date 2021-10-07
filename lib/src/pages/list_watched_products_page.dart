import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/galery_service.dart';
import 'package:treecommerce/src/services/watched_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';

class ListWatchedProductsPage extends StatefulWidget {
  ListWatchedProductsPage({Key key}) : super(key: key);

  @override
  _ListWatchedProductsPageState createState() => _ListWatchedProductsPageState();
}

class _ListWatchedProductsPageState extends State<ListWatchedProductsPage> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  WatchedService _service;
  GaleryService _galeryService;
  UserPreferences _userPreferences;

  @override
  Widget build(BuildContext context) {
    
    _service = new WatchedService();
    _galeryService = new GaleryService();
    _userPreferences = Provider.userPreferences(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCustom(),
      appBar: simpleAppBar(context, 'Historial'),
      body: _listProducts(),
    );
  }

  Widget _listProducts() {
    return Container(
      child: FutureBuilder(
        future: _service.getWatchedList(_userPreferences),
        builder: (BuildContext context, AsyncSnapshot<List<ProductosModel>> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return _itemProduct(snapshot.data[index]);
              }
            );
          }
        }
      ),
    );
  }

  Widget _itemProduct(ProductosModel data) {

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: getBorder(),
          top: getBorder()
        )
      ),
      padding: EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            right: 10.0,
            top: 5.0,
            child: Icon(
              data.favorite != 1 ? Icons.favorite_border_outlined : Icons.favorite, 
              color: Colors.blue,
              size: 20.0,
            ), 
          ),
          Row(
            children: [
              FutureBuilder(
                future: _galeryService.getGalery(data.id == 0 ? 1 : data.id),
                builder: (BuildContext context, AsyncSnapshot<List<GaleryModel>> snapshot){
                  if( !snapshot.hasData ){
                    return getLoader();
                  }else{
                    return FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(snapshot.data.first.path),
                      fit: BoxFit.cover,
                      height: 120.0,
                    );
                  }
                }
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 
                    data.name,
                    style: TextStyle(
                      fontSize: 15.0
                    ),
                  ), 
                  Text( 
                    "\$ ${ data.price }",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    )
                  )
                ],
              )
            ],
          ),
        ]
      ),
    );

  }
}