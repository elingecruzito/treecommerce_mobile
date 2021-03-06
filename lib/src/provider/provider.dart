import 'package:flutter/cupertino.dart';
import 'package:treecommerce/src/bloc/direction_bloc.dart';
import 'package:treecommerce/src/bloc/login_bloc.dart';
import 'package:treecommerce/src/bloc/product_bloc.dart';
import 'package:treecommerce/src/bloc/search_bloc.dart';
import 'package:treecommerce/src/services/buys_service.dart';
import 'package:treecommerce/src/services/directions_service.dart';
import 'package:treecommerce/src/services/galery_service.dart';
import 'package:treecommerce/src/services/home_service.dart';
import 'package:treecommerce/src/services/inspirated_service.dart';
import 'package:treecommerce/src/services/login_service.dart';
import 'package:treecommerce/src/services/notifications_service.dart';
import 'package:treecommerce/src/services/offers_service.dart';
import 'package:treecommerce/src/services/product_service.dart';
import 'package:treecommerce/src/services/providers_service.dart';
import 'package:treecommerce/src/services/search_service.dart';
import 'package:treecommerce/src/services/valorations_service.dart';
import 'package:treecommerce/src/services/watched_service.dart';
import 'package:treecommerce/src/utilerias/messages.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class Provider extends InheritedWidget {

  final _loginBloc = new LoginBloc();
  final _searchBloc = new SearchBloc();
  final _userPreferences = new UserPreferences();
  final _messages = new Messages();
  final _productBloc = new ProductBloc();
  final _directionBloc = new DirectionBloc();

  final _galeryService = new GaleryService();
  final _homeService = new HomeService();
  final _inspiratedService = new InspiratedService();
  final _loginService = new LoginService();
  final _offersService = new OffersService();
  final _productService = new ProductService();
  final _providerService = new ProvidersService();
  final _searchService = new SearchService();
  final _valorationsService = new ValorationsService();
  final _watchedService = new WatchedService();
  final _directionsService = new DirectionsService();
  final _buysService = new BuysServices();
  final _notificationsService = new NotificationsService();

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

  static SearchBloc searchBloc(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._searchBloc;

  static UserPreferences userPreferences(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._userPreferences;

  static ProductBloc productBloc(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._productBloc;

  static DirectionBloc directionBloc(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._directionBloc;

//-------------------------------------------------------------------------------------------------------

  static GaleryService galeryService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._galeryService;

  static HomeService homeService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._homeService;

  static InspiratedService inspiratedService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._inspiratedService;
  
  static LoginService loginService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._loginService;

  static OffersService offersService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._offersService;

  static ProductService productService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._productService;
  
  static ProvidersService providersService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._providerService;

  static SearchService searchService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._searchService;

  static ValorationsService valorationsService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._valorationsService;
  
  static WatchedService watchedService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._watchedService;

  static DirectionsService directionsService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._directionsService;

  static BuysServices buysServices(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._buysService;

  static NotificationsService notificationsService(BuildContext context)
    => context.dependOnInheritedWidgetOfExactType<Provider>()._notificationsService;

}