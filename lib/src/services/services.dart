import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:treecommerce/src/model/request_get_model.dart';
import 'package:treecommerce/src/model/request_model.dart';
import 'package:treecommerce/src/utilerias/directions.dart';



Future<RequestModel> petition(String path, Map<String, String> params) async {

  final client = RetryClient(http.Client());
  http.Response resp;
  try{
    resp = await client.post( Uri.http(Directions().url_server, path, params) );
  }catch(e){
    print(e.toString());
  }finally{
    client.close();
  }
  print('Code: ${resp.statusCode} | POST: ${Directions().url_server + path} | Params: ${ params.toString() }');

  if( resp != null ){
    if(resp.statusCode == 200){
      return requestModelFromJson(resp.body);
    }
  }

  return new RequestModel(code: resp.statusCode, message: 'El servidor ha encontrado una situación que no sabe cómo manejarla', body: "[]");
}

Future<RequestGetModel> petitionGet(String path) async{

  final client = RetryClient(http.Client());
  http.Response resp;
  try{
    resp = await client.get( Uri.http(Directions().url_server, path) );
  }catch(e){
    print(e.toString());
  }finally{
    client.close();
  }
  print('Code: ${resp.statusCode} | GET: ${Directions().url_server + path}');
if( resp != null ){
    if(resp.statusCode == 200){
      return requestGetModelFromJson(resp.body);
    }
  }

  return new RequestGetModel(code: resp.statusCode, message: 'El servidor ha encontrado una situación que no sabe cómo manejarla', body: []);

}