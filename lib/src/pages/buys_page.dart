import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treecommerce/src/bloc/buys_bloc.dart';
import 'package:treecommerce/src/model/buys_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class BuysPage extends StatefulWidget {

  @override
  _BuysPageState createState() => _BuysPageState();
}

class _BuysPageState extends State<BuysPage> {

  BuysBloc _buysBloc;

  @override
  Widget build(BuildContext context) {

    _buysBloc = Provider.buysBloc(context);


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Mis compras',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0
          ),
        ),
      ),
      body: _listNotifications(),
    );
  }

  Widget _listNotifications() {
    return Container(
      child: FutureBuilder(
        future: _buysBloc.getBuys( Random().nextInt(999) ),
        builder: (BuildContext context, AsyncSnapshot<List<BuysModel>> snapshot){
          if( !snapshot.hasData ){
            return CircularProgressIndicator();
          }else{
            List<BuysModel> _items = snapshot.data;
            return ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index){
                return _itemBuy(_items[index]);
              }
            );
          }
        },
      ),
    );
  }

  Widget _itemBuy(BuysModel _item) {
    return GestureDetector(
      onTap: () => print('Notificacion #${_item.g03Id}'),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: getBorder(),
            bottom: getBorder(),
          )
        ),
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network('https://coca-colafemsa.com/wp-content/uploads/2019/11/2.png', width: 70.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( 
                  _buysBloc.getState(_item.g03State),
                  style: TextStyle(
                    color: _item.g03State == 5 || _item.g03State == 0 ? Colors.red : Colors.grey
                  ),
                ),
                Text(
                  parseDate(_item.g02Date),
                  style: TextStyle(color: Colors.grey[700]),
                )
              ],
            )
          ]
        )
      ),
    );
  }
}