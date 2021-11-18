import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treecommerce/src/bloc/direction_bloc.dart';
import 'package:treecommerce/src/model/estados_model.dart';
import 'package:treecommerce/src/model/municipios_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/directions_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AddDirectionPage extends StatefulWidget {
  @override
  _AddDirectionPageState createState() => _AddDirectionPageState();
}

class _AddDirectionPageState extends State<AddDirectionPage> {

  DirectionBloc _directionBloc;
  UserPreferences _preferences;
  DirectionsService _directionsService;
  
  int _stateValue = 0;
  int _countryValue = 0;

  TextStyle _style;

  @override
  Widget build(BuildContext context) {

    _directionBloc = Provider.directionBloc(context);
    _preferences = Provider.userPreferences(context);
    _directionsService = Provider.directionsService(context);

    return Scaffold(
      appBar: simpleAppBar(context, 'Nueva direccion'),
      body: SafeArea(
        child: _addForm(),
      ),
    );
  }

  Widget _addForm() {

    _style = TextStyle(
      color: Colors.teal[700],
    );

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          _fieldState(),
          SizedBox(height: 10.0),
          _fieldCountry(),
          _fieldAddress(),
          SizedBox(height: 10.0),
          _fieldCp(),
          SizedBox(height: 10.0),
          _fieldPhone(),
          SizedBox(height: 10.0),
          _fieldPerson(),
          SizedBox(height: 10.0),
          _buttomSubmit()
        ],
      ),
    );
  }

  Widget _fieldState() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Estado: ', style: _style),
        FutureBuilder(
          future: _directionsService.getStates(_preferences),
          builder: (BuildContext context, AsyncSnapshot<List<EstadoModel>> snapshotResult){
            if( snapshotResult.hasData ){
              return DropdownButton(
                isExpanded: true,
                hint: Text('Selecciona un estado...'),
                value: _stateValue == 0 ? snapshotResult.data.first.id : _stateValue,
                items: snapshotResult.data.map((EstadoModel state){
                  return DropdownMenuItem(
                    value: state.id,
                    child: Text(state.estado)
                  );
                }).toList(),
                onChanged: (value) => setState(() { 
                  _stateValue = value; 
                  _countryValue = 0; 
                }),
              );
            }else{
              return getLoader();
            }
          }
        ),
      ],
    );
  }

  Widget _fieldCountry() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Municipio: ', style: _style),
        FutureBuilder(
          future: _directionsService.getCountrys(_preferences, _stateValue == 0 ? 1 : _stateValue),
          builder: (BuildContext context, AsyncSnapshot<List<MunicipiosModel>> snapshotResult){
            if( snapshotResult.hasData ){
              return DropdownButton(
                isExpanded: true,
                hint: Text('Selecciona un municipio...'),
                value: _countryValue == 0 ? snapshotResult.data.first.id : _countryValue,
                items: snapshotResult.data.map((MunicipiosModel country){
                  return DropdownMenuItem(
                    value: country.id,
                    child: Text(country.municipio)
                  );
                }).toList(),
                onChanged: (value) => setState(() { _countryValue = value; }),
              );
            }else{
              return getLoader();
            }
          }
        ),
      ],
    );
  }

  Widget _fieldAddress() {
    return StreamBuilder(
      stream: _directionBloc.addressStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              errorText: snapshot.error,
              labelText: 'Direccion: ',
              labelStyle: _style
            ),
            onChanged: _directionBloc.changeAddress,
          ),
        );
      },
    );
  }

  Widget _fieldCp() {
    return StreamBuilder(
      stream: _directionBloc.cpStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              errorText: snapshot.error,
              labelText: 'C.P: ',
              labelStyle: _style
            ),
            onChanged: _directionBloc.changeCp
          ),
        ); 
      }
    );
  }

  Widget _fieldPhone() {
    return StreamBuilder(
      stream: _directionBloc.phoneStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            keyboardType: TextInputType.phone,
            inputFormatters: [
              MaskedInputFormatter('###-###-##-##')
            ],
            decoration: InputDecoration(
              errorText: snapshot.error,
              labelText: 'Telefono: ',
              labelStyle: _style
            ),
            onChanged: _directionBloc.changePhone
          ),
        ); 
      }
    );
  }

  Widget _fieldPerson() {
    return StreamBuilder(
      stream: _directionBloc.personStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              errorText: snapshot.error,
              labelText: 'Persona que recibe: ',
              labelStyle: _style
            ),
            onChanged: _directionBloc.changePerson
          ),
        ); 
      }
    );
  }

  Widget _buttomSubmit() {
    return StreamBuilder<Object>(
      stream: _directionBloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
            child: Center(child: Text('Guardar direccion', style: TextStyle(color: Colors.white))),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          onPressed: () {
            print('Envio...!');
          }
        );
      }
    );
  }


}