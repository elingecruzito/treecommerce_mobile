import 'dart:async';
import 'dart:math';

import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/services/home_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class HomeBloc{

  final ProductosModel _productosModel = ProductosModel();
  final random = new Random();
  List<ProductosModel> _list = new List<ProductosModel>();

  HomeService _homeService;

  _init(){
    if( _homeService == null){
      _homeService = new HomeService();
    }
  }

  List<ProductosModel> getTestProducts(int count){
    if( _list.length > 0 ){
      _list.clear();
    }

    for(int i = 0; i < 3; i++ ){
      _list.add(new ProductosModel(
        id: i,
        name: "Producto " + (i + 1).toString(), 
        price: random.nextInt(999).toDouble(),
        unity: random.nextInt(999),
        description: "Esta es una descripcion...", 
        // g01Imagens: "https://coca-colafemsa.com/wp-content/uploads/2019/11/2.png"
      ));
    }

    return _list;

  }

  Future<List<ProductosModel>> getOnSale() async{

    return getTestProducts(3);
  }

  Future<ProductosModel> getLastView(UserPreferences _preferences) async{

    _init();
    return _homeService.lastView(_preferences).then((value){
      return value;
    });

  }

  Future<List<ProductosModel>> inspiratedOnLastView() async{
    
    return getTestProducts(3);

  }

  Future<List<ProductosModel>> historyViews() async{
    
    return getTestProducts(3);

  }
}