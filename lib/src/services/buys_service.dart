import 'package:treecommerce/src/model/buys_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class BuysServices{

  Future<BuysModel> add_buy(UserPreferences _preferences, int product, int count, int direction) async{
    return await petition(Directions().path_buys_add, {
      'token' : _preferences.token,
      'product' : product.toString(),
      'count' : count.toString(),
      'direction' : direction.toString(),
    }).then((value){
      return buysModelFromJson(value.body);
    });
  }

}