import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/notifications_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  UserPreferences _preferences;

  @override
  Widget build(BuildContext context) {

    _preferences = Provider.userPreferences(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Notificaciones',
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

    final _service = Provider.notificationsService(context);

    return Container(
      child: FutureBuilder(
        future: _service.getNotifications(_preferences),
        builder: (BuildContext context, AsyncSnapshot<List<NotificationsModel>> snapshot){
          if(!snapshot.hasData){
            return getLoader();
          }else{
            List<NotificationsModel> _data = snapshot.data;
            return ListView.builder(
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int index){
                return _itemNotifications(_data[index]);
              }
            );
          }
        }, 
      ),
    );
  }

  Widget _itemNotifications(NotificationsModel data) {
    return Container(
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
          // Image.network(data.g02Imagen, width: 70.0),
          _iconNotification( data.type ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      _typeNotification( data.type )
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    data.message, 
                    style: TextStyle(
                      fontSize: 12.0
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Text(
                      data.createdAt,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _iconNotification(int _type) {
    var _icon = Icons.message;

    switch( _type ){
      case 1:
        _icon = Icons.shopping_cart_outlined ;
      break;

      case 2:
        _icon = Icons.directions_car_outlined;
      break;

      case 3:
        _icon = Icons.wallet_giftcard_outlined ;
      break;

      case 4:
        _icon = Icons.remove_shopping_cart_outlined;
      break;

      case 5:
        _icon = Icons.refresh;
      break;
    }

    return Icon(_icon, color: Colors.grey);
  }

  Widget _typeNotification(int _type) {
    
    String _typeString = "Compra cancelada";
    var _color = Colors.grey;

    switch( _type ){
      case 1:
        _typeString = "Compra realizada";
        _color = Colors.green;
      break;

      case 2:
        _typeString = "Paquete enviado";
        _color = Colors.yellow;
      break;

      case 3:
        _typeString = "Paquete entregado";
        _color = Colors.green;
      break;

      case 4:
        _typeString = "Compra cancelada";
        _color = Colors.red;
      break;

      case 5:
        _typeString = "Compra devuelta";
        _color = Colors.blue;
      break;
    }

    return Text(
      '(${ _typeString })',
      style: TextStyle(
        fontSize: 10.0,
        color: _color,
        fontWeight: FontWeight.bold
      ),
    );
  }
}