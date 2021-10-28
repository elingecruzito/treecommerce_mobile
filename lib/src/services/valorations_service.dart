import 'package:treecommerce/src/model/valorations_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class ValorationsService{

  Future<List<ValorationsModel>> getAllValorations(UserPreferences _preferences, int id) async{
    return await petition(
      Directions().path_valoration_all,{
      'token' : _preferences.token,
      'id' : id.toString()
    }).then((value) {
      if(value.code == 200)
        return valorationsModelFromJson(value.body);
      return null;
    });
  }

  Future<List<ValorationsModel>> getPositivesValorations(UserPreferences _preferences, int id) async{
    return await petition(
      Directions().path_valoration_positives,{
      'token' : _preferences.token,
      'id' : id.toString()
    }).then((value) {
      if(value.code == 200)
        return valorationsModelFromJson(value.body);
      return null;
    });
  }

  Future<List<ValorationsModel>> getNegativesValorations(UserPreferences _preferences, int id) async{
    return await petition(
      Directions().path_valoration_negatives,{
      'token' : _preferences.token,
      'id' : id.toString()
    }).then((value) {
      if(value.code == 200)
        return valorationsModelFromJson(value.body);
      return null;
    });
  }

}