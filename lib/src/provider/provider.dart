import 'package:flutter/cupertino.dart';
import 'package:treecommerce/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

  final _loginBloc = new LoginBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if( _instancia == null ){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(Provider oldWidget) => true;

  static LoginBloc loginBloc(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;

}