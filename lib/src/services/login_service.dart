import 'package:treecommerce/src/bloc/login_bloc.dart';
import 'package:treecommerce/src/model/request_model.dart';
import 'package:treecommerce/src/utilerias/directions.dart';

import 'package:http/http.dart' as http;

class LoginService{

  Directions _directions = new Directions();

  Future<RequestModel> authentificate(LoginBloc _loginBloc) async{

    final resp = await http.post( Uri.http(_directions.url_server, _directions.path_authentificate, {
      'email': _loginBloc.user,
      'password': _loginBloc.password ,
    }) );

    print(resp.body);

    if(resp.statusCode == 200){
      return requestModelFromJson(resp.body);
    }else{
      
      return new RequestModel(code: 500, message: 'El servidor ha encontrado una situación que no sabe cómo manejarla');
    }
  }

}