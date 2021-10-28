import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class WatchedService{
  Directions _directions = new Directions();

  Future<List<ProductosModel>> getWatchedList(UserPreferences _preferences) async {

    return await petition(
      Directions().path_watched_list,{
      'token' : _preferences.token
    }).then((value) {
      if(value.code == 200)
        return productosListModelFromJson(value.body);
      return null;
    });
    
  }

  Future<ProductosModel> addLastView(UserPreferences _preferences, int _product)async {

    return await petition(
      Directions().path_watched_add,{
      'token' : _preferences.token,
      'id' : _product.toString()
    }).then((value) {
      if(value.code == 200)
        return productosModelFromJson(value.body);
      return null;
    });
    
  }
}