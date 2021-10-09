import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/card_product_widget.dart';

class ListProductsWidget extends StatelessWidget {
  
  ListProductsWidget({ @required this.future });

  Future<List<ProductosModel>> future;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder(
        future: this.future,
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
          Positioned(
            right: 10.0,
            top: 5.0,
            child: Icon(
              !data.favorite ? Icons.favorite_border_outlined : Icons.favorite, 
              color: Colors.blue,
              size: 20.0,
            ), 
          ),
          CardProduct(producto: data)
        ]
      ),
    );
  }
}