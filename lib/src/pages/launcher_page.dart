import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/messages.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class LauncherPage extends StatefulWidget {
  LauncherPage({Key key}) : super(key: key);

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    _getInitialRoute();

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  
  _getInitialRoute() async{

    final _homeService = Provider.homeService(context);
    final result = await _homeService.launcher();
    if( result != null){
      final _preferences = Provider.userPreferences(context);
      if( _preferences.userExist() ){
        Navigator.pushReplacementNamed(context, "login");
      }else{
        Navigator.pushReplacementNamed(context, "home");
      }
    }else{
      final _messages = Provider.messages(context);
      errorAlert(context, _messages.TITLE_ERROR, _messages.LAUNCHER_ERROR);
    }

  }

}