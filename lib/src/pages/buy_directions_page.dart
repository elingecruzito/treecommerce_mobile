import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/buy_arguments_model.dart';
import 'package:treecommerce/src/model/directions_model.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/directions_service.dart';
import 'package:treecommerce/src/utilerias/messages.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class BuyDirectionsPage extends StatefulWidget {
  const BuyDirectionsPage({ Key key }) : super(key: key);

  @override
  _BuyDirectionsPageState createState() => _BuyDirectionsPageState();
}

class _BuyDirectionsPageState extends State<BuyDirectionsPage> {
  
  final _sizeIcons = 25.0;
  DirectionsService _directionsService;
  UserPreferences _userPreferences;
  int _selected = 0;
  ProductosModel _productosModel;
  List<DirectionsModel> _listDirection;

  @override
  Widget build(BuildContext context) {

    _directionsService = Provider.directionsService(context);
    _userPreferences = Provider.userPreferences(context);

    _productosModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona una direccion', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: _sizeIcons
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, 'add_direction'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _generateList()
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.teal[300],
              child: Container(
                padding: EdgeInsets.all(13.0),
                child: Center(child: Text('Pagar', style: TextStyle(color: Colors.white))),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
              elevation: 0.0,
              onPressed: () => _submit(),
            ),
          ),
         
        ],
      ),
    );
  }

  Widget _generateList() {

    return FutureBuilder(
      future: _directionsService.getListDirections(_userPreferences),
      builder: (BuildContext context, AsyncSnapshot<List<DirectionsModel>> snapshot) {
        if( snapshot.hasData ){
          _listDirection = snapshot.data;
          return Container(
            padding: EdgeInsets.fromLTRB(0, 10.0, 15.0, 0),
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return _item(snapshot.data[index], index);
              }
            ),
          );
        }
        return getLoader();
      },
    );

    
  }

  Widget _item(DirectionsModel data, int index) {
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Radio(
            value: index, 
            groupValue: _selected, 
            onChanged: (int value){
              setState(() {
                _selected = value;              
              });
            }
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100]
              ),
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.person,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('${data.address} - C.P. ${ data.cp } - ${data.state}, ${data.country}'),
                  SizedBox(height: 10),
                  Text('${data.person} - ${ data.phone }'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _submit() {
    if( _selected != 0 ){
      Navigator.pushNamed(context, 'complete_buy', arguments: BuyArguments(_productosModel, _listDirection[_selected]));
    }else{
      errorAlert(context, Messages().TITLE_ERROR, Messages().DIRECTIONS_ERROR_SELECTED);
    }
    
  }
}