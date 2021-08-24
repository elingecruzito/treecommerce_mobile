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