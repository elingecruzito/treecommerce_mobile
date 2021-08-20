import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/productos_model.dart';

class CardProduct extends StatelessWidget {
  
  CardProduct({ @required this.producto });

  ProductosModel producto;

  @override
  Widget build(BuildContext context) {

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
          FadeInImage(
            placeholder: AssetImage('assets/img/no-image.jpg'),
            image: NetworkImage(this.producto.g01Imagens),
            fit: BoxFit.cover,
            height: 120.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( 
                this.producto.g01Name,
                style: TextStyle(
                  fontSize: 15.0
                ),
              ), 
              Text( 
                this.producto.g01Precio, 
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