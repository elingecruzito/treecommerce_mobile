import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/image_product_widget.dart';

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

    return InkWell(
      onTap: () {
        Provider.userPreferences(context).setCount(1);
        Navigator.pushNamed(context, 'product', arguments: producto);
      },
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
            ImageProductWidget(id_product: producto.id),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 
                    this.producto.name,
                    style: TextStyle(
                      fontSize: 15.0
                    ),
                    overflow: TextOverflow.ellipsis,
                  ), 
                  _price(),
                  
                ],
              ),
            )
          ]
        ),
      ),
    );

  }

  Widget _price() {
    if(producto.porcentage > 0 ){
      return Row(
        children: [
          Text( 
            "\$ ${ moneyFormat(producto.total) }",
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
        "\$ ${ moneyFormat(producto.price) }",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        )
      );
    }
  }

  

}