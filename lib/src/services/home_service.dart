
import 'package:treecommerce/src/model/request_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';

class HomeService{

  Future<RequestModel> carousel(){
    return petition(Directions().path_carrucel, null);
  }

}