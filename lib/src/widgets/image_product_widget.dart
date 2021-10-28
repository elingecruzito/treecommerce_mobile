import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/provider/provider.dart';

class ImageProductWidget extends StatelessWidget {

  ImageProductWidget({ @required this.id_product});

  int id_product;

  @override
  Widget build(BuildContext context) {

    final _galeryService = Provider.galeryService(context);

    return FutureBuilder(
      future: _galeryService.getCover(id_product),
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
}