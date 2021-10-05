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
          // FadeInImage(
          //   placeholder: AssetImage('assets/img/no-image.jpg'),
          //   image: NetworkImage('https://coca-colafemsa.com/wp-content/uploads/2019/11/2.png'),
          //   fit: BoxFit.cover,
          //   height: 120.0,
          // ),
          _galery(),
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

  Widget _galery() {
    return FutureBuilder(
      future: _galeryService.getGalery(producto.id == 0 ? 1 : producto.id),
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
    );
  }
}