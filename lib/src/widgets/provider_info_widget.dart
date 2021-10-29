import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/providers_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class ProviderInfoWidget extends StatelessWidget {

  ProviderInfoWidget({ @required this.idProduct });

  int idProduct;
  final _sizeIcons = 25.0;

  @override
  Widget build(BuildContext context) {

    final _providersService = Provider.providersService(context);
    final _preferences = Provider.userPreferences(context);

    return FutureBuilder(
      future: _providersService.getProviderByProduct(_preferences, idProduct),
      builder: (BuildContext context, AsyncSnapshot<ProvidersModel> snapshot) {
        if( snapshot.hasData ){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Text(
                'Informacion del vendedor',
                style: TextStyle(
                  fontSize: 18.0
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.grey, size: _sizeIcons),
                  Column(
                    children: [
                      Text(
                        'Ubicacion',
                        style: TextStyle(
                          color: Colors.black, 
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric( horizontal: _sizeIcons),
                child: Text(
                  snapshot.data.address,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10.0),
              _valorationLight(context, snapshot.data)
            ],
          );
        }
        return getLoader();
      },
    );
  }

  Widget _valorationLight(BuildContext context, ProvidersModel _provider){

    final _sizePage = MediaQuery.of(context).size;
    final _sizeWithSizeBox = 5.0;
    final _withLight = ( _sizePage.width / 5) - ( _sizeWithSizeBox * 4 );

    final _heightActive = 10.0;
    final _heightInactive = 5.0;

    return Row(
      children: [
        Container(
          width: _withLight,
          height: _provider.valoration.round() == 1 ? _heightActive : _heightInactive,
          color: _provider.valoration.round() == 1 ? Colors.red : Colors.red[100],
        ),
        SizedBox(width: _sizeWithSizeBox),
        Container(
          width: _withLight,
          height: _provider.valoration.round() == 2 ? _heightActive : _heightInactive,
          color: _provider.valoration.round() == 2 ? Colors.orange : Colors.orange[100],
        ),
        SizedBox(width: _sizeWithSizeBox),
        Container(
          width: _withLight,
          height: _provider.valoration.round() == 3 ? _heightActive : _heightInactive,
          color: _provider.valoration.round() == 3 ? Colors.yellow : Colors.yellow[100],
        ),
        SizedBox(width: _sizeWithSizeBox),
        Container(
          width: _withLight,
          height: _provider.valoration.round() == 4 ? _heightActive : _heightInactive,
          color: _provider.valoration.round() == 4 ? Colors.lightGreen : Colors.lightGreen[100],
        ),
        SizedBox(width: _sizeWithSizeBox),
        Container(
          width: _withLight,
          height: _provider.valoration.round() == 5 ? _heightActive : _heightInactive,
          color: _provider.valoration.round() == 5 ? Colors.green : Colors.green[100],
        ),
      ]
    );
  }
}