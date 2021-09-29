import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treecommerce/src/model/user_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/messages.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({ Key key }) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserPreferences _preferences;
  Messages _messages;

  @override
  Widget build(BuildContext context) {

    _preferences = Provider.userPreferences(context);
    _messages = Provider.messages(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCustom(),
      appBar: simpleAppBar(context, "Account"),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () => showDialog(
              context: context, 
              builder: (buildcontext) {
                return AlertDialog(
                  // title: Text(_messages.TITLE_ALERT_LOGOUT),
                  content: Text(_messages.MESSAGE_ALERT_LOGOUT),
                  actions: [
                    RaisedButton(
                      child: Text("Cancelar", style: TextStyle(color: Colors.white)),
                      onPressed: (){ Navigator.of(context).pop(); },
                    ),
                    RaisedButton(
                      child: Text("Aceptar", style: TextStyle(color: Colors.white)),
                      onPressed: (){ 
                        Navigator.of(context).pop(); 
                        _preferences.destroy();
                        Navigator.pushReplacementNamed(context, "login");
                      },
                    ),
                  ],
                );
              }
            ),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 20.0), child: Icon(Icons.person)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_preferences.name), 
                          Text(_preferences.email)
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0.0,
                    child: Icon(Icons.power_settings_new_outlined)
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