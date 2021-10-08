import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:treecommerce/src/utilerias/validators.dart';

class SearchBloc with Validators{

  final _searchingController = BehaviorSubject<String>();

  Stream<String> get searchingStream => _searchingController.stream.transform(isEmpty);

  Function(String) get changeSearching => _searchingController.sink.add;

  String get searching => _searchingController.value;

  dispose(){
    _searchingController?.close();
  }
  
}