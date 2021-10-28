import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/buys_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/buys_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/card_view_widget.dart';
import 'package:treecommerce/src/widgets/image_product_widget.dart';

class BuysPage extends StatefulWidget {

  @override
  _BuysPageState createState() => _BuysPageState();
}

class _BuysPageState extends State<BuysPage> {

  BuysServices _buysServices;
  UserPreferences _preferences;

  @override
  Widget build(BuildContext context) {

    _buysServices = Provider.buysServices(context);
    _preferences = Provider.userPreferences(context);


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
        future: _buysServices.list(_preferences),
        builder: (BuildContext context, AsyncSnapshot<List<BuysModel>> snapshot){
          if( !snapshot.hasData ){
            return getLoader();
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

    return CardView(
      titleCard: _item.createdAt,
      contentCard: GestureDetector(
        onTap: () => print( _item.toJson() ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageProductWidget(id_product: _item.idProduct),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 
                    _item.name,
                    style: TextStyle(
                      fontSize: 15.0
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text( 
                    _item.status,
                    style: TextStyle(
                      color: _item.idStatus == 5 || _item.idStatus == 0 ? Colors.red : Colors.grey
                    ),
                  ),
                ],
              ),
            )
          ]
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () => print('Notificacion #${_item.id}'),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border(
    //         top: getBorder(),
    //         bottom: getBorder(),
    //       )
    //     ),
    //     padding: EdgeInsets.all(20.0),
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         ImageProductWidget(id_product: _item.idProduct),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text( 
    //                 _item.name,
    //                 style: TextStyle(
    //                   fontSize: 15.0
    //                 ),
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //               Text( 
    //                 _item.status,
    //                 style: TextStyle(
    //                   color: _item.idStatus == 5 || _item.idStatus == 0 ? Colors.red : Colors.grey
    //                 ),
    //               ),
    //               Text(
    //                 // parseDate(_item.dateCreated),
    //                 parseDate(DateTime.parse(_item.createdAt)),
    //                 style: TextStyle(color: Colors.grey[700]),
    //               )
    //             ],
    //           ),
    //         )
    //       ]
    //     )
    //   ),
    // );
  }
}