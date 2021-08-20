import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:treecommerce/src/model/productos_model.dart';

class HomeBloc{

  final ProductosModel _productosModel = ProductosModel();
  final random = new Random();
  List<ProductosModel> _list = new List<ProductosModel>();

  List<ProductosModel> getTestProducts(int count){
    if( _list.length > 0 ){
      _list.clear();
    }

    for(int i = 0; i < 3; i++ ){
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

  Future<List<ProductosModel>> getOnSale() async{

    return getTestProducts(3);
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

  Future<List<ProductosModel>> inspiratedOnLastView() async{
    
    return getTestProducts(3);

  }

  Future<List<ProductosModel>> historyViews() async{
    
    return getTestProducts(3);

  }

}