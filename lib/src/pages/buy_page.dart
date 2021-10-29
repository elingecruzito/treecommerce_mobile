import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/buys_model.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/model/providers_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/product_service.dart';
import 'package:treecommerce/src/services/providers_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';
import 'package:treecommerce/src/widgets/image_product_widget.dart';

class BuyPage extends StatelessWidget {

  BuysModel _buy;
  UserPreferences _preferences;
  ProductService _productService;
  ProvidersService _providersService;

  @override
  Widget build(BuildContext context) {

    _buy = ModalRoute.of(context).settings.arguments as BuysModel;
    _preferences = Provider.userPreferences(context);
    _productService = Provider.productService(context);
    _providersService = Provider.providersService(context);

    return Scaffold(
      drawer: DrawerCustom(),
      appBar: simpleAppBar(context, 'Estado de la compra'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _detailsBuy(),
              _infoProduct(),
              _infoPackage(),
              _infoProvider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailsBuy() {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Detalle de la compra', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text(
                '#${ _buy.id } | ${ _buy.createdAt }',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              _line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Producto:', style: TextStyle(color: Colors.grey)),
                  Text('\$${ moneyFormat( double.parse( _buy.cost.toString() ) )}', style: TextStyle(color: Colors.grey))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cantidad:', style: TextStyle(color: Colors.grey)),
                  Text('${ _buy.count }', style: TextStyle(color: Colors.grey))
                ],
              ),
              _line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: TextStyle(color: Colors.grey)),
                  Text('\$${ moneyFormat( double.parse( _buy.total.toString() ) ) }', style: TextStyle(color: Colors.grey))
                ],
              ),
            ],
          ),
        )
      )
    );
  }

  Widget _infoProduct() {

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: FutureBuilder(
          future: _productService.getProduct(_preferences, _buy.idProduct),
          builder: (BuildContext context, AsyncSnapshot<ProductosModel> snapshot) {
            if( snapshot.hasData ){
              final _productInfo = snapshot.data;
              return Container(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _productInfo.name, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis
                          ),
                          SizedBox(height: 10.0),
                          Text(_productInfo.description, style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                    ImageProductWidget(id_product: _buy.idProduct),
                  ],
                ),
              );
            }
            return getLoader();
          },
        ),
      )
    );
  }

  Widget _line() {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[300],
                width: 1.0,
                style: BorderStyle.solid
              )
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _infoPackage() {

    var _color = Colors.grey;
    if( _buy.idStatus == 4 ){
      _color = Colors.green;
    }else if( _buy.idStatus == 5 ){
      _color = Colors.red;
    }

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Detalle del envio', style: TextStyle( fontWeight: FontWeight.bold)),
              _line(),
              Text(_buy.status, style: TextStyle( color: _color , fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text('${ _buy.address } C.P ${ _buy.cp }, ${ _buy.estado }, ${ _buy.municipio }.', style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      )
    );
  }

  Widget _infoProvider() {

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: FutureBuilder(
          future: _providersService.getProviderByProduct(_preferences, _buy.idProduct),
          builder: (BuildContext context, AsyncSnapshot<ProvidersModel> snapshot) {
            if( snapshot.hasData ){
              final _provider = snapshot.data;
              return Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Detalle del proveedor', style: TextStyle(fontWeight: FontWeight.bold)),
                    _line(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nombre:', style: TextStyle(color: Colors.grey)),
                        Text(_provider.name, style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tel:', style: TextStyle(color: Colors.grey)),
                        Text(_provider.phone, style: TextStyle(color: Colors.grey))
                      ],
                    )
                  ],
                ),
              );
            }
            return getLoader();
          },
        ),
      )
    );
  }

  
}