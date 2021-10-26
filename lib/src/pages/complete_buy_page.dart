import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/buy_arguments_model.dart';
import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/buys_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class CompleteBuyPage extends StatefulWidget {
  CompleteBuyPage({Key key}) : super(key: key);

  @override
  _CompleteBuyPageState createState() => _CompleteBuyPageState();
}

class _CompleteBuyPageState extends State<CompleteBuyPage> {
  
  UserPreferences _preferences;
  final _sizeIcons = 25.0;
  final _border = BorderSide(
    width: 0.5,
    color: Colors.grey[300],
    style: BorderStyle.solid
  );
  BuyArguments _arguments;
  BuysServices _buysServices;

  @override
  Widget build(BuildContext context) {

    
    _preferences = Provider.userPreferences(context);
    _arguments = ModalRoute.of(context).settings.arguments as BuyArguments;
    _buysServices = Provider.buysServices(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar tu compra', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: _sizeIcons
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _product(),
              _direction(),
              _total_cost(),
              _submit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _product() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      decoration: BoxDecoration(
        color: Colors.teal[300],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _renderImage(),
            Text(_arguments.product.name, style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
            Text('Cantidad: ${ _preferences.count }', style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget _renderImage(){
    
    final _galeryService = Provider.galeryService(context);

    return FutureBuilder(
      future: _galeryService.getCover(_arguments.product.id),
      builder: (BuildContext context, AsyncSnapshot<GaleryModel> snapshot){
        if( snapshot.hasData ){
          return Image.network(
            snapshot.data.path, 
            fit: BoxFit.cover, 
            height: 120.0,
            loadingBuilder: (context, child, loadingProgress){
              if( loadingProgress == null){
                return child;
              }else{
                return Image.asset(
                  'assets/img/no-image.jpg',
                  fit: BoxFit.cover, 
                  height: 120.0,
                );
              }
            },
            errorBuilder: (context, error, stackTrace) =>
              Image.asset(
                  'assets/img/no-image.jpg',
                  fit: BoxFit.cover, 
                  height: 120.0,
                )
          );
        }
        return Image.asset(
          'assets/img/no-image.jpg',
          fit: BoxFit.cover, 
          height: 120.0,
        );
      }
    );
  }

  Widget _direction() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: _border
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.local_shipping_outlined, size: 35.0, color: Colors.grey),
          SizedBox(height: 10.0),
          Text(
            'C.P. ${_arguments.direction.cp}',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text('${_arguments.direction.address} - C.P. ${ _arguments.direction.cp } - ${_arguments.direction.state}, ${_arguments.direction.country}', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
          SizedBox(height: 10),
          Text('${_arguments.direction.person} - ${ _arguments.direction.phone }', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _total_cost() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: _border
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.attach_money_rounded, size: 35.0, color: Colors.grey),
          SizedBox(height: 10.0),
          Text('Paga \$${ moneyFormat(( _arguments.product.price * _preferences.count)) }', style: TextStyle(fontSize: 15.0)),
          SizedBox(height: 10.0),
          Text('No demores en pagar, solo podemos reservarte stock cuando el pago se acredite', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center)
        ],
      ),
    );
  }

  Widget _submit() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: RaisedButton(
        color: Colors.teal[300],
        child: Container(
          padding: EdgeInsets.all(13.0),
          child: Center(child: Text('Confirmar Compra', style: TextStyle(color: Colors.white))),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 0.0,
        onPressed: () async {
          showDialog(
            context: context,
            builder: (buildcontext) {
              return Center(child: CircularProgressIndicator());
            }
          );
          final _sale = await _buysServices.add_buy(
            _preferences, 
            _arguments.product.id, 
            _preferences.count, 
            _arguments.direction.id
          );

          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
        },
      ),
    );
  }

  
}