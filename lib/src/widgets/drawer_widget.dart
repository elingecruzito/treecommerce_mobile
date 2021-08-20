import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  
  DrawerCustom({ @required this.decoration });

  Decoration decoration;

  final _border = BorderSide(
      width: 0.5,
      color: Colors.grey[300],
      style: BorderStyle.solid
    );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _items(),
          )
        ),
      ),
    );
  }

  List<Widget> _items(){
    List<Widget> _items = new List<Widget>();
    _items.add( _headerDrawer() );

    menuOptions().forEach( (opt) { 
      _items.add(
        GestureDetector(
          onTap: ()=> print("Ir a ${ opt["route"] }...!"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: _border,
              )
            ),
            child: Row(
              children: [
                Icon(opt["icon"], color: Colors.black),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    opt["title"],
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
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
                  'Hola Andres Garcia',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600
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
        "route" : "shop"
      },
      {
        "title" : "Fravoritos",
        "icon" : Icons.favorite_border_outlined,
        "route" : "favorites"
      },
      {
        "title" : "Ofertas",
        "icon" : Icons.local_offer_outlined,
        "route" : "onSale"
      },
      {
        "title" : "Historial",
        "icon" : Icons.access_alarms_outlined,
        "route" : "history"
      },
      {
        "title" : "Mi cuenta",
        "icon" : Icons.person_outline,
        "route" : "user"
      },
    ];
  }
}