import 'package:treecommerce/src/utilerias/validators.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _userController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recupera los datos del Stream
  Stream<String> get userStream => _userController.stream.transform(isEmpty);
  Stream<String> get passwordStream => _passwordController.stream.transform(isEmpty);

  Stream<bool> get formValidStream => 
    Rx.combineLatest2(
      userStream, passwordStream, (user, password) => true
    );

  // Inserta valores al stream
  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el ultimo valor ingresado en los Stream
  String get user => _userController.value;
  String get password => _passwordController.value;

  String get dataLogin => user + " | " + password;

  dispose(){
    _userController?.close();
    _passwordController?.close();
  }

}