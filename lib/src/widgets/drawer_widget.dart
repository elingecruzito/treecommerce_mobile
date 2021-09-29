import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treecommerce/src/model/user_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';


class DrawerCustom extends StatefulWidget {

  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {

  final Decoration decoration = getDecorationGradient();
  final _color_font = Colors.black54;
  UserPreferences _preferences;

  final _border = BorderSide(
      width: 0.5,
      color: Colors.grey[300],
      style: BorderStyle.solid
    );

  @override
  Widget build(BuildContext context) {

    _preferences = Provider.userPreferences(context);

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _items(context),
          )
        ),
      ),
    );
  }

  List<Widget> _items(BuildContext context){
    List<Widget> _items = new List<Widget>();
    _items.add( _headerDrawer() );

    menuOptions().forEach( (opt) { 
      _items.add(
        GestureDetector(
          onTap: ()=> Navigator.pushNamed(context, opt['route']),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: _border,
              )
            ),
            child: Row(
              children: [
                Icon(opt["icon"], color: _color_font),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    opt["title"],
                    style: TextStyle(fontWeight: FontWeight.w600, color: _color_font),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined, 
                      color: _color_font, 
                      size: 10.0
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });

    return _items;
  } 

  Widget _headerDrawer(){

    return DrawerHeader(
      decoration: this.decoration,
      child: Row(
        children: [
          Image.asset('assets/img/empty-user.png', width: 50.0),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hola ' + _preferences.name,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: _color_font,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Map<String, Object>> menuOptions(){
    return [
      {
        "title" : "Inicio",
        "icon" : Icons.home_outlined,
        "route" : "home"
      },
      {
        "title" : "Buscar",
        "icon" : Icons.search_outlined,
        "route" : "search"
      },
      {
        "title" : "Notificaciones",
        "icon" : Icons.notifications_active_outlined,
        "route" : "notifications"
      },
      {
        "title" : "Mis compras",
        "icon" : Icons.shopping_cart_outlined,
        "route" : "buys"
      },
      {
        "title" : "Fravoritos",
        "icon" : Icons.favorite_border_outlined,
        "route" : "error"
      },
      {
        "title" : "Ofertas",
        "icon" : Icons.local_offer_outlined,
        "route" : "error"
      },
      {
        "title" : "Historial",
        "icon" : Icons.access_alarms_outlined,
        "route" : "error"
      },
      {
        "title" : "Mi cuenta",
        "icon" : Icons.person_outline,
        "route" : "account"
      },
    ];
  }

}