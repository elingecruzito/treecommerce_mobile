import 'package:flutter/cupertino.dart';
import 'package:treecommerce/src/bloc/buys_bloc.dart';
import 'package:treecommerce/src/bloc/home_bloc.dart';
import 'package:treecommerce/src/bloc/login_bloc.dart';
import 'package:treecommerce/src/bloc/notifications_bloc.dart';
import 'package:treecommerce/src/bloc/search_bloc.dart';
import 'package:treecommerce/src/utilerias/messages.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class Provider extends InheritedWidget {

  final _loginBloc = new LoginBloc();
  final _homeBloc = new HomeBloc();
  final _searchBloc = new SearchBloc();
  final _notificationsBloc = new NotificationsBloc();
  final _buysBloc = new BuysBloc();
  final _userPreferences = new UserPreferences();

  final _messages = new Messages();

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

  static Messages messages(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._messages;

  static LoginBloc loginBloc(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;

  static HomeBloc homeBloc(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._homeBloc;

  static SearchBloc searchBloc(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._searchBloc;

  static NotificationsBloc notificationsBloc(BuildContext context) 
    => context.dependOnInheritedWidgetOfExactType<Provider>()._notificationsBloc;
  
  static BuysBloc buysBloc(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._buysBloc;

  static UserPreferences userPreferences(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._userPreferences;

}