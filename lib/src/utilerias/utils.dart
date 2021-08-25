import 'package:flutter/material.dart';

final _decorationGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Colors.teal[300],
      Colors.teal[200],
      Colors.teal[100],
      Colors.white
    ]
  )
);

final _border = BorderSide(
  width: 0.5,
  color: Colors.grey[300],
  style: BorderStyle.solid
);

void errorAlert(BuildContext context,String title, String txt) {
  showDialog(
    context: context,
    builder: (buildcontext) {
      return AlertDialog(
        title: Text(title),
        content: Text(txt),
        actions: <Widget>[
          RaisedButton(
            child: Text("Aceptar", style: TextStyle(color: Colors.white),),
            onPressed: (){ Navigator.of(context).pop(); },
          )
        ],
      );
    }
  );
}

BoxDecoration getDecorationGradient() => _decorationGradient;

BorderSide getBorder() => _border;

AppBar appBarSearch(BuildContext context){

  final double _sizeIcons = 25.0;
  
  return AppBar(
      backgroundColor: Colors.teal[300],
      title: _buscador(context),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: _sizeIcons
      ),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined, color: Colors.white), 
          onPressed: () => Navigator.pushNamed(context, 'error'),
          iconSize: _sizeIcons,
        )
      ],
    );
}

Widget _buscador(BuildContext context){

  final _width = MediaQuery.of(context).size.width;

  return InkWell(
    onTap: () => Navigator.pushNamed(context, 'search'),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        color: Colors.white,
        width: _width,
        height: 32.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.search_outlined, color: Colors.grey, size: 15.0),
              SizedBox(width: 5.0),
              Text("Buscar en TreeCommerse", style: TextStyle(color: Colors.grey, fontSize: 12.0))
            ]
          ),
        )
      ),
    ),
  );
}