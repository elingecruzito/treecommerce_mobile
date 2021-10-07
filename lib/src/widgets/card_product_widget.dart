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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: _border,
          bottom: _border
        ),
      ),
      child: Row(
        children: [
          Image.network(
            producto.path, 
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
                this.producto.name,
                style: TextStyle(
                  fontSize: 15.0
                ),
              ), 
              Text( 
                "\$ ${ producto.price }",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
                )
              )
            ],
          )
        ]
      ),
    );

  }

}