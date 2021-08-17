import 'package:flutter/material.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _padding_lr = 20.0;
  final _padding_tb = 250.0;

  @override
  Widget build(BuildContext context) {
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
                  _fieldUserLogin(),
                  SizedBox(height: 10.0),
                  _fieldPasswordLogin(),
                  SizedBox(height: 10.0),
                  _buttomSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldUserLogin() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Usuario: ',
              errorText: 'Usuario incorrecto!',
            ),
            onChanged: null,
          ),
        );
      },
    );
  }

  Widget _fieldPasswordLogin() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key),
              labelText: 'Contrasena: ',
              errorText: 'Contrasena incorrecta!',
            ),
            onChanged: null,
          ),
        );
      },
    );
  }

  Widget _buttomSubmit() {
    return StreamBuilder(
      stream: null,
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
          onPressed: (){}
        );
      }
    );
  }


}