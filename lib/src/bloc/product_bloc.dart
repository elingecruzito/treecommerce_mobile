import 'package:treecommerce/src/utilerias/validators.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ProductBloc with Validators{

  final _countController =  BehaviorSubject<String>();

  Stream<String> get countStream => _countController.stream.transform(isEmpty);
  
  Function(String) get changeCount => _countController.sink.add;

  String get count => _countController.value;

  dispose(){
    _countController?.close();
  }

}