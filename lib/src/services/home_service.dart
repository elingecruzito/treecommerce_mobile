import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'dart:convert';

class HomeService{

  Future<dynamic> launcher() async{
    return await petition(Directions().path_launcher, {
      'token' : 'MqmaWWM7XxMdsd8V2y9srAu2gwbEyW5SrJz4PKqX2hWbvBDPMJqGg'
    }).then((value){
      if(value.code == 200)
        return json.decode(value.body);
      return null;
    });
  }

  Future<List> carousel() async{
    return await petitionGet(Directions().path_carrucel).then((value){
        if(value.code == 200)
          return value.body;
        return null;
    });
  }

  Future<ProductosModel> lastView(UserPreferences _preferences) async{
    return await petition(Directions().path_last_view, {
      'token' : _preferences.token
    }).then((value){
      if(value.code == 200)
        return productosModelFromJson(value.body);
      return null;
    });
  }

  Future<List<ProductosModel>> onSale(UserPreferences _preferences) async{
    return await petition(Directions().path_offers, {
      'token' : _preferences.token
    }).then((value){
      if(value.code == 200)
        return productosListModelFromJson(value.body);
      return null;
    });
  }

  Future<List<ProductosModel>> inspirated(UserPreferences _preferences) async{
    return await petition(Directions().path_inspirated, {
      'token' : _preferences.token
    }).then((value){
      if(value.code == 200)
        return productosListModelFromJson(value.body);
      return null;
    });
  }

  Future<List<ProductosModel>> history(UserPreferences _preferences) async{
    return await petition(Directions().path_history, {
      'token' : _preferences.token
    }).then((value){
      if(value.code == 200)
        return productosListModelFromJson(value.body);
      return null;
    });
  }

}