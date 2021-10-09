import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';

class GaleryService{

  Future<List<GaleryModel>> getGalery(id_product) async{
    return await petition(Directions().path_galery, {
      'product' : id_product.toString()
    }).then((value){
      return galeryListModelFromJson(value.body);
    });
  }

  Future<GaleryModel> getCover(id_product) async{
    return await petition(Directions().path_cover, {
      'product' : id_product.toString()
    }).then((value){
      return galeryModelFromJson(value.body);
    });
  }

}