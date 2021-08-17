import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home', style: TextStyle(color: Colors.white))),
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.white), 
            onPressed: () => print('Shopping car!')
          )
        ],
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}