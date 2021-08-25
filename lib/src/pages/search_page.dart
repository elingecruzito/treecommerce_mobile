import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  int _numItems = 0;
  final Random _random = new Random();

  Size _size;
  final _pageController = new PageController(
    initialPage: 0,
    viewportFraction: 0.5,
  );

  @override
  Widget build(BuildContext context) {

    _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          size: 25.0
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        backgroundColor: Colors.white,
        title: _appBarSearch(),
      ),
      body:  SafeArea(
        child: _listSearch()
      ),
    );
  }

  Widget _appBarSearch() {

    return Container(
      child: StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar en TreeCommerce ',
              ),
              onChanged: null,
            ),
          );
        },
      ),
    );
  }

  Widget _listSearch() {

    final items = List<String>.generate(10, (i) => "Item ${ i + 1}");

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'list'),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10.0,),
                  Text(
                    items[index],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}