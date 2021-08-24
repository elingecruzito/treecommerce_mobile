import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/working.png'),
          Text(
            'In working...',
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.grey
            ),
          )
        ],
      )
    );
  }
}