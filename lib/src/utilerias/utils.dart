import 'package:flutter/material.dart';

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