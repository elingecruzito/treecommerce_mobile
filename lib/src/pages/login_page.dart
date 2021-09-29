import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treecommerce/src/bloc/login_bloc.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/login_service.dart';
import 'package:treecommerce/src/utilerias/messages.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _padding_lr = 20.0;
  final _padding_tb = 250.0;
  LoginService _loginService;
  Messages _messages;

  @override
  Widget build(BuildContext context) {

    final _loginBloc = Provider.loginBloc(context);
    _loginService = new LoginService();

    _messages = Provider.messages(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(_padding_lr, _padding_tb, _padding_lr, _padding_tb),
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  _fieldUserLogin(_loginBloc),
                  SizedBox(height: 10.0),
                  _fieldPasswordLogin(_loginBloc),
                  SizedBox(height: 10.0),
                  _buttomSubmit(_loginBloc),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldUserLogin(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Usuario: ',
              errorText: snapshot.error,
            ),
            onChanged: loginBloc.changeUser,
          ),
        );
      },
    );
  }

  Widget _fieldPasswordLogin(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key),
              labelText: 'Contrasena: ',
              errorText: snapshot.error,
            ),
            onChanged: loginBloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _buttomSubmit(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
            child: Text('Entrar', style: TextStyle(color: Colors.white)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          onPressed: () {
            if(snapshot.hasData){
              _login(context, loginBloc);
            }else{
              errorAlert(context, _messages.TITLE_ERROR , _messages.LOGIN_ERROR_HASDATA);
            }
          }
        );
      }
    );
  }

  _login(BuildContext context, LoginBloc loginBloc) async {

    final pref = await SharedPreferences.getInstance();
    
    _loginService.authentificate(loginBloc).then( (value){

        if( value != null ){

          pref.setInt("id", value.id);
          pref.setString("name", value.name);
          pref.setString("remember_token", value.rememberToken);

          Navigator.pushReplacementNamed(context, "home");

        }else{

          errorAlert(context, _messages.TITLE_ERROR, _messages.LOGIN_ERROR_AUTHENTIFICATE);

        }
      }
    );
    
  }

  


}