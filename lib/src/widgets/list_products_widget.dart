import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

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
              Image.network(
                data.path, 
                fit: BoxFit.cover, 
                height: 120.0,
                loadingBuilder: (context, child, loadingProgress){
                  if( loadingProgress == null){
                    return child;
                  }else{
                    return Image.asset(
                      'assets/img/no-image.jpg',
                      fit: BoxFit.cover, 
                      height: 120.0,
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) =>
                  Image.asset(
                      'assets/img/no-image.jpg',
                      fit: BoxFit.cover, 
                      height: 120.0,
                    )
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
                  _price(data),
                ],
              )
            ],
          ),
        ]
      ),
    );

  }

  Widget _price(ProductosModel producto) {
    if(producto.porcentage > 0 ){
      return Row(
        children: [
          Text( 
            "\$ ${ producto.total }",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0
            )
          ),
          Text(
            " ${ producto.porcentage }% OFF",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.lightGreen[700]
            ),
          )
        ],
      );
    }else{
      return Text( 
        "\$ ${ producto.price }",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        )
      );
    }
  }
}