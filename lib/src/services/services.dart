import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:treecommerce/src/model/request_get_model.dart';
import 'package:treecommerce/src/model/request_model.dart';
import 'package:treecommerce/src/utilerias/directions.dart';



Future<RequestModel> petition(String path, Map<String, String> params) async {

  final client = RetryClient(http.Client());
  http.Response resp;
  try{
    print(Directions().url_server + path);
    resp = await client.post( Uri.http(Directions().url_server, path, params) );
  }catch(e){
    print(e.toString());
  }finally{
    client.close();
  }

  if( resp != null ){
    if(resp.statusCode == 200){
      return requestModelFromJson(resp.body);
    }
  }

  return new RequestModel(code: 500, message: 'El servidor ha encontrado una situación que no sabe cómo manejarla');
}

Future<RequestGetModel> petitionGet(String path) async{

  final client = RetryClient(http.Client());
  http.Response resp;
  try{
    print(Directions().url_server + path);
    resp = await client.get( Uri.http(Directions().url_server, path) );
  }catch(e){
    print(e.toString());
  }finally{
    client.close();
  }

  if( resp != null ){
    if(resp.statusCode == 200){
      return requestGetModelFromJson(resp.body);
    }
  }

  return new RequestGetModel(code: 500, message: 'El servidor ha encontrado una situación que no sabe cómo manejarla');

}