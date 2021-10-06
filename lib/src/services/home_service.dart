import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class HomeService{

  Future<List> carousel() async{
    return await petitionGet(Directions().path_carrucel).then((value){
        return value.body;
    } 
    );
  }

  Future<ProductosModel> lastView(UserPreferences _preferences) async{
    return await petition(Directions().path_last_view, {
      'token' : _preferences.token
    }).then((value){
      return productosModelFromJson(value.body);
    });
  }

  Future<List<ProductosModel>> onSale(UserPreferences _preferences) async{
    return await petition(Directions().path_offers, {
      'token' : _preferences.token
    }).then((value){
      return productosListModelFromJson(value.body);
    });
  }

  Future<List<ProductosModel>> inspirated(UserPreferences _preferences) async{
    return await petition(Directions().path_inspirated, {
      'token' : _preferences.token
    }).then((value){
      return productosListModelFromJson(value.body);
    });
  }

  Future<List<ProductosModel>> history(UserPreferences _preferences) async{
    return await petition(Directions().path_history, {
      'token' : _preferences.token
    }).then((value){
      return productosListModelFromJson(value.body);
    });
  }

}