import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/valorations_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class TabBarValorationsWidget extends StatelessWidget {

  TabBarValorationsWidget({ @required this.idProduct });

  int idProduct;

  @override
  Widget build(BuildContext context) {

    final _preferences = Provider.userPreferences(context);
    final _valorationsService = Provider.valorationsService(context);

    return DefaultTabController(
      length: 3, 
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: TabBar(
              tabs: [
                Tab(text: 'Todas'),
                Tab(text: 'Positivas'),
                Tab(text: 'Negativas'),
              ]
            ),
          ),
          Container(
            height: 300.0,
            child: TabBarView(
              children: [
                Container(
                  child: FutureBuilder(
                    future: _valorationsService.getAllValorations(_preferences, idProduct),
                    builder: (BuildContext context, AsyncSnapshot<List<ValorationsModel>> snapshot) {
                      return _renderValorations(snapshot);
                    },
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: _valorationsService.getPositivesValorations(_preferences, idProduct),
                    builder: (BuildContext context, AsyncSnapshot<List<ValorationsModel>> snapshot) {
                      return _renderValorations(snapshot);
                    },
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: _valorationsService.getNegativesValorations(_preferences, idProduct),
                    builder: (BuildContext context, AsyncSnapshot<List<ValorationsModel>> snapshot) {
                      return _renderValorations(snapshot);
                    },
                  ),
                ),
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _renderValorations(AsyncSnapshot<List<ValorationsModel>> snapshot){
    if( snapshot.hasData ){

      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          
          List<Widget> _starts = List<Widget>();
          for (var i = 0; i < 5; i++) {
            if( snapshot.data[index].starts > i ){
              _starts.add(Icon(Icons.star_outlined, color: Colors.blue, size: 15.0));
            }else{
              _starts.add(Icon(Icons.star_outlined, color: Colors.grey, size: 15.0));
            }
          }
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: _starts,
                ),
                Text(
                  snapshot.data[index].comment,
                  style: TextStyle(

                  ),
                )
              ],
            ),
          );
        }
      );
    }else{
      return getLoader();
    }
    
  }
}