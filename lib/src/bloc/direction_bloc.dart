import 'package:treecommerce/src/utilerias/validators.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DirectionBloc with Validators{

  final _addressController = BehaviorSubject<String>();
  final _cpController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _personController = BehaviorSubject<String>();

  // Recupera los datos del Stream
  Stream<String> get addressStream => _addressController.stream.transform(isEmpty);
  Stream<String> get cpStream => _cpController.stream.transform(isCp);
  Stream<String> get phoneStream => _phoneController.stream.transform(isPhone);
  Stream<String> get personStream => _personController.stream.transform(isEmpty);

  Stream<bool> get formValidStream => 
    Rx.combineLatest4(
      addressStream, cpStream, phoneStream, personStream, (address, cp, phone, person) => true
    );

  // Inserta valores al stream
  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changeCp => _cpController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changePerson => _personController.sink.add;

  // Obtener el ultimo valor ingresado en los Stream
  String get address => _addressController.value;
  String get cp => _cpController.value;
  String get phone => _phoneController.value;
  String get person => _personController.value;

  dispose() {
    _addressController?.close();
    _cpController?.close();
    _phoneController?.close();
    _personController?.close();
  }

}