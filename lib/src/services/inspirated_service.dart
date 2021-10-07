import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class InspiratedService{

  Directions _directions = new Directions();

  Future<List<ProductosModel>> getOffersList(UserPreferences _preferences) async {

    return await petition(
      Directions().path_inspirated_list,{
      'token' : _preferences.token
    }).then((value) {
      return productosListModelFromJson(value.body);
    });
    
  }
}