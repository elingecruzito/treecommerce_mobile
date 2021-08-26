import 'package:flutter/material.dart';
import 'package:treecommerce/src/bloc/notifications_bloc.dart';
import 'package:treecommerce/src/model/notifications_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  NotificationsBloc _notificationsBloc;

  @override
  Widget build(BuildContext context) {

    _notificationsBloc = Provider.notificationsBloc(context);

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
    return Container(
      child: FutureBuilder(
        future: _notificationsBloc.getNotifications(),
        builder: (BuildContext context, AsyncSnapshot<List<NotificationsModel>> snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
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
          Image.network(data.g02Imagen, width: 70.0),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.g02Title,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    data.g02Desc, 
                    style: TextStyle(
                      fontSize: 12.0
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
}