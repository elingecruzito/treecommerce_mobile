import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treecommerce/src/bloc/search_bloc.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';

class ListProductsPage extends StatefulWidget {
  const ListProductsPage({ Key key }) : super(key: key);

  @override
  _ListProductsPageState createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Random _random = new Random();
  SearchBloc _searchBloc;
  Size size;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    _searchBloc = Provider.searchBloc(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCustom(),
      appBar: appBarSearch(context),
      body: _listProducts(),
    );
  }

  Widget _listProducts() {

    return Container(
      child: FutureBuilder(
        future: _searchBloc.searchItems(""),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }else{
            List<ProductosModel> _items = snapshot.data;
            return ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _itemProduct(_items[index]);
              }
            );
          }
        },
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
              !Random().nextBool() ? Icons.favorite_border_outlined : Icons.favorite, 
              color: Colors.blue,
              size: 20.0,
            ), 
          ),
          Row(
            children: [
              FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage('https://coca-colafemsa.com/wp-content/uploads/2019/11/2.png'),
                fit: BoxFit.cover,
                height: 120.0,
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