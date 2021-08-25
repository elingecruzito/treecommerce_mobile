import 'dart:async';
import 'dart:math';

import 'package:treecommerce/src/model/productos_model.dart';

class SearchBloc{

  List<ProductosModel> _list = new List<ProductosModel>();
  final random = new Random();

  List<ProductosModel> getTestProducts(int count){
    if( _list.length > 0 ){
      _list.clear();
    }

    for(int i = 0; i < count; i++ ){
      _list.add(new ProductosModel(
        g01Id: i,
        g01Name: "Producto " + (i + 1).toString(), 
        g01Precio: "\$ ${ random.nextInt(999).toDouble() }",
        g01Descripcion: "Esta es una descripcion...", 
        g01Imagens: "https://coca-colafemsa.com/wp-content/uploads/2019/11/2.png"
      ));
    }

    return _list;

  }

  Future<List<ProductosModel>> searchItems(String _search) async{

    return getTestProducts(Random().nextInt(99));

  }
}