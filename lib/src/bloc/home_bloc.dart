import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:treecommerce/src/model/productos_model.dart';

class HomeBloc{

  final ProductosModel _productosModel = ProductosModel();
  final random = new Random();

  Future<List<ProductosModel>> getOnSale() async{

    List<ProductosModel> _list = new List<ProductosModel>();

    for(int i = 0; i < 10; i++ ){
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

  ProductosModel getLastView(){

    int _id = random.nextInt(999);
    
    return new ProductosModel(
        g01Id: _id,
        g01Name: "Producto ${ _id }", 
        g01Precio: "\$ ${ random.nextInt(999).toDouble() }",
        g01Descripcion: "Esta es una descripcion...", 
        g01Imagens: "https://coca-colafemsa.com/wp-content/uploads/2019/11/2.png"
    );
  }

}