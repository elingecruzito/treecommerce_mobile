import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class SearchService{
  Future<List<ProductosModel>> getListProducts(UserPreferences _preferences, String text) async {

    return await petition(
      Directions().path_search_list,{
      'token' : _preferences.token,
      'searching' : text
    }).then((value) {
      return productosListModelFromJson(value.body);
    });
    
  }
}