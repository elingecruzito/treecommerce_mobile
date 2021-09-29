import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LauncherPage extends StatefulWidget {
  LauncherPage({Key key}) : super(key: key);

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    super.initState();
    _getInitialRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Launcher!!"),
      ),
    );
  }
  
  _getInitialRoute(){

    Timer(Duration(seconds: 5), () async {
      final pref = await SharedPreferences.getInstance();
      if( pref.getKeys().isEmpty ){
        Navigator.pushReplacementNamed(context, "login");
      }else{
        Navigator.pushReplacementNamed(context, "home");
      }
    });

  }

}