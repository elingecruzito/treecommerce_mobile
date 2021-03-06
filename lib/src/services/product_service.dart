import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class ProductService{
  Future<ProductosModel> getProduct(UserPreferences _preferences, int id) async{
    return await petition(
      Directions().path_pruduct,{
      'token' : _preferences.token,
      'id' : id.toString()
    }).then((value) {
      if(value.code == 200)
        return productosModelFromJson(value.body);
      return null;
    });
  }

  Future<List<ProductosModel>> getProductByProvider(UserPreferences _preferences, int id) async{
    return await petition(
      Directions().path_pruduct_by_provider,{
      'token' : _preferences.token,
      'id' : id.toString()
    }).then((value) {
      if(value.code == 200)
        return productosListModelFromJson(value.body);
      return null;
    });
  }

  Future<List<ProductosModel>> getFavoritesProducts(UserPreferences _preferences) async{
    return await petition(
      Directions().path_favorites_products,{
      'token' : _preferences.token,
    }).then((value) {
      if(value.code == 200)
        return productosListModelFromJson(value.body);
      return null;
    });
  }

  Future<bool> setFavoriteValue(UserPreferences _preferences, int id_product, int value) async{
    return await petition(
      Directions().path_product_favorite,{
      'token' : _preferences.token,
      'id_product' : id_product.toString(),
      'value' : value.toString()
    }).then((value) {
      if(value.code == 200)
        return value.body == "1" ? true : false;
      return false;
    });
  }
}