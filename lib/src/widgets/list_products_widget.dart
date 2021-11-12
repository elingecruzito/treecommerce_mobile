import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/product_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/card_product_widget.dart';

class ListProductsWidget extends StatefulWidget {
  
  ListProductsWidget({ @required this.future });

  Future<List<ProductosModel>> future;

  @override
  _ListProductsWidgetState createState() => _ListProductsWidgetState();
}

class _ListProductsWidgetState extends State<ListProductsWidget> {
  ProductService _productService;

  UserPreferences _preferences;

  @override
  Widget build(BuildContext context) {

    _preferences = Provider.userPreferences(context);
    _productService = Provider.productService(context);

    return Container(
      child: FutureBuilder(
        future: this.widget.future,
        builder: (BuildContext context, AsyncSnapshot<List<ProductosModel>> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
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
      child: Stack(
        children: [
          CardProduct(producto: data),
          Positioned(
            right: 10.0,
            top: 0.0,
            child: IconButton(
              icon: Icon(
                !data.favorite ? Icons.favorite_border_outlined : Icons.favorite, 
                color: Colors.blue,
                size: 20.0,
              ), onPressed: () async{
                var value = !data.favorite ? 1 : 0;
                bool result = await _productService.setFavoriteValue(_preferences, data.id, value);
                if( result ){
                  setState(() => data.favorite = !data.favorite);
                }
                
              },
            ), 
          ),
        ]
      ),
    );
  }
}