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
      if(value.code == 200)
        return buysModelFromJson(value.body);
      return null;
    });
  }

  Future<List<BuysModel>> list(UserPreferences _preferences) async{
    return await petition(Directions().path_buys_list, {
      'token' : _preferences.token,
    }).then((value){
      if(value.code == 200)
        return buysListModelFromJson(value.body);
      return null;
    });
  }

}