import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class LauncherPage extends StatefulWidget {
  LauncherPage({Key key}) : super(key: key);

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  UserPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _getInitialRoute();
  }

  @override
  Widget build(BuildContext context) {

    _preferences = Provider.userPreferences(context);

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  
  _getInitialRoute(){

    Timer(Duration(seconds: 5), () {
      if( _preferences.userExist() ){
        Navigator.pushReplacementNamed(context, "login");
      }else{
        Navigator.pushReplacementNamed(context, "home");
      }
    });

  }

}