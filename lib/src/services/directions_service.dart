import 'package:treecommerce/src/model/directions_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class DirectionsService{

  Future<List<DirectionsModel>> getListDirections(UserPreferences _preferences) async{
    return await petition(Directions().path_directions_list, {
      'token' : _preferences.token
    }).then((value){
      return directionsListModelFromJson(value.body);
    });
  }

}