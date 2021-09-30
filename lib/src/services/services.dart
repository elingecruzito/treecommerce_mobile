import 'package:http/http.dart' as http;
import 'package:treecommerce/src/model/request_model.dart';
import 'package:treecommerce/src/utilerias/directions.dart';

Future<RequestModel> petition(String path, Map<String, String> params) async {
  final resp = await http.post( Uri.http(Directions().url_server, path, params) );

   if(resp.statusCode == 200){
      return requestModelFromJson(resp.body);
    }else{
      
      return new RequestModel(code: 500, message: 'El servidor ha encontrado una situación que no sabe cómo manejarla');
    }
}