import 'dart:math';

import 'package:treecommerce/src/model/buys_model.dart';

class BuysBloc{

  String getState(int _state){

      String _result = "Cancelado";

      final _listStates = [
        { 'c01_state' : 1, 'c01_desc': "Comprado" },
        { 'c01_state' : 2, 'c01_desc': "Preparando" },
        { 'c01_state' : 3, 'c01_desc': "En camino" },
        { 'c01_state' : 4, 'c01_desc': "Entregado" },
        { 'c01_state' : 5, 'c01_desc': "Cancelado" },
      ];

      _listStates.forEach((item) {
        if( item['c01_state'] == _state ){
          _result = item['c01_desc'];
        }
      });

      return _result;
    }

  Future<List<BuysModel>> getBuys(int userid) async{

    final _buys = List<BuysModel>.generate(
      Random().nextInt(99), 
      (index) => BuysModel(
        g03Id: index,
        g03State: Random().nextInt(6),
        g02Date: DateTime.now(),
        g01Id: Random().nextInt(99)
      )
    );

    return _buys;
  }

}