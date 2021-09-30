import 'package:treecommerce/src/bloc/login_bloc.dart';
import 'package:treecommerce/src/model/request_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';

import 'package:http/http.dart' as http;

class LoginService{

  Directions _directions = new Directions();

  Future<RequestModel> authentificate(LoginBloc _loginBloc) async {

    return await petition(
      Directions().path_authentificate, 
      {
        'email': _loginBloc.user,
        'password': _loginBloc.password ,
      }
    ).then((value) {
      return value;
    });
    
  }

}