import 'dart:math';

import 'package:treecommerce/src/model/notifications_model.dart';

class NotificationsBloc{

  Future<List<NotificationsModel>> getNotifications() async{

    final _items = List<NotificationsModel>.generate(
      Random().nextInt(99), 
      (index) => NotificationsModel(
        g02Id: index,
        g02Title: 'Esta es una notificacion #${index + 1}',
        g02Desc: 'Esta es la descripcion de la notificacion #${index + 1}',
        g02Imagen: 'https://definicion.de/wp-content/uploads/2009/06/producto.png'
      )
    );

    return _items;

  }

}