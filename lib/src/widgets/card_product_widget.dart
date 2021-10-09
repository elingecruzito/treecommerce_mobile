import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/services/galery_service.dart';

class CardProduct extends StatelessWidget {
  
  CardProduct({ @required this.producto });

  ProductosModel producto;
  GaleryService _galeryService;

  @override
  Widget build(BuildContext context) {

    _galeryService = new GaleryService();

    final _border = BorderSide(
      width: 0.5,
      color: Colors.grey[300],
      style: BorderStyle.solid
    );

    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'product', arguments: producto),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: _border,
            bottom: _border
          ),
        ),
        child: Row(
          children: [
            _renderImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( 
                  this.producto.name,
                  style: TextStyle(
                    fontSize: 15.0
                  ),
                ), 
                _price(),
                
              ],
            )
          ]
        ),
      ),
    );

  }

  Widget _renderImage(){

    return FutureBuilder(
      future: _galeryService.getCover(producto.id),
      builder: (BuildContext context, AsyncSnapshot<GaleryModel> snapshot){
        if( snapshot.hasData ){
          return Image.network(
            snapshot.data.path, 
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
          );
        }
        return Image.asset(
          'assets/img/no-image.jpg',
          fit: BoxFit.cover, 
          height: 120.0,
        );
      }
    );
  }

  Widget _price() {
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