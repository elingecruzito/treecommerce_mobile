
import 'package:treecommerce/src/model/providers_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class ProvidersService{

  Future<ProvidersModel> getProduct(UserPreferences _preferences, int id) async{
    return await petition(
      Directions().path_privider_product,{
      'token' : _preferences.token,
      'id' : id.toString()
    }).then((value) {
      if(value.code == 200)
        return providersModelFromJson(value.body);
      return null;
    });
  }

}