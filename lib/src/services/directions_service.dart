import 'package:treecommerce/src/model/directions_model.dart';
import 'package:treecommerce/src/model/estados_model.dart';
import 'package:treecommerce/src/model/municipios_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class DirectionsService{

  Future<List<DirectionsModel>> getListDirections(UserPreferences _preferences) async{
    return await petition(Directions().path_directions_list, {
      'token' : _preferences.token
    }).then((value){
      if(value.code == 200)
        return directionsListModelFromJson(value.body);
      return null;
    });
  }

  Future<List<EstadoModel>> getStates(UserPreferences _preferences) async{
    return await petition(Directions().path_estados_list, {
      'token' : _preferences.token
    }).then((value){
      if(value.code == 200)
        return estadoListModelFromJson(value.body);
      return null;
    });
  }

  Future<List<MunicipiosModel>> getCountrys(UserPreferences _preferences, int state) async{
    return await petition(Directions().path_municipios_list, {
      'token' : _preferences.token,
      'id_estado' : state.toString()
    }).then((value){
      if(value.code == 200)
        return municipiosListModelFromJson(value.body);
      return null;
    });
  }

}