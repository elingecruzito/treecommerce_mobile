import 'package:flutter/material.dart';
import 'package:treecommerce/src/bloc/product_bloc.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/messages.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class StockWidget extends StatefulWidget {

  StockWidget({ @required this.productosModel });

  ProductosModel productosModel;

  @override
  _StockWidgetState createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {

  ProductBloc _productBloc;
  UserPreferences _preferences;

  @override
  Widget build(BuildContext context) {

    _productBloc = Provider.productBloc(context);
    _preferences = Provider.userPreferences(context);

    if( widget.productosModel.unity == 1 ){
      return Container(
        child: Text(
          'Ultimo disponible!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0
          ),
        ),
      );
    }

    return InkWell(
      onTap: () => _modalButtomCantidades(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stock disponible',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Text('Cantidad: ', style: TextStyle(fontSize: 15.0)),
                    Text('${ _preferences.count }', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10.0),
                    Text('(${widget.productosModel.unity} disponibles)', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  ],
                ),
                Positioned(
                  child: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.grey,), 
                  right: 0.0
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _modalButtomCantidades(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 280.0,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0), 
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey[350],
                      style: BorderStyle.solid
                    )
                  ),
                ),
                child: Text(
                  'Elige cantidad', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 15.0
                  )
                )
              ),
              _unidadSelect(1),
              _unidadSelect(2),
              _unidadSelect(3),
              _unidadSelect(4),
              _unidadSelect(5),
              InkWell(
                onTap: (){
                
                  Navigator.of(context).pop();
                  _modalButtomMore(context);
                           
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0), 
                  child: Center(
                    child: Text(
                      'Mas de 5 unidades'
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }, 
    );
  }

  Widget _unidadSelect(int _cant){
    return InkWell(
      onTap: (){
        setState(() {
          Navigator.of(context).pop();
          _preferences.setCount(_cant);         
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0), 
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.grey[350],
              style: BorderStyle.solid
            )
          ),
        ),
        child: Center(
          child: Text(
            '${ _cant } ${ _cant > 1 ? "unidades" : "unidad" }'
          ),
        ),
      ),
    );
  }

  _modalButtomMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180.0,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container( //Title
                width: double.infinity,
                padding: EdgeInsets.all(10.0), 
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey[350],
                      style: BorderStyle.solid
                    )
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elige cantidad', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 15.0
                      )
                    ),
                    Text(
                      '${ widget.productosModel.unity } disponibles',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey
                      ),
                    )
                  ],
                )
              ),// Title
              _fieldCant(),
              _buttomSubmit(),
            ],
          ),
        );
      }, 
    );
  }

  Widget _fieldCant() {
    return StreamBuilder(
      stream: _productBloc.countStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Ingresar cantidad'
            ),
            onChanged: _productBloc.changeCount,
          ),
        );
      },
    );
  }

  Widget _buttomSubmit() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
        child: Text('Aplicar', style: TextStyle(color: Colors.white)),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      onPressed: () {
        
        if( _preferences.count != int.parse( _productBloc.count ) && int.parse( _productBloc.count ) <= widget.productosModel.unity ){
          setState(() => _preferences.setCount( int.parse(_productBloc.count ) ) );
          Navigator.of(context).pop();
        }else if(int.parse( _productBloc.count ) > widget.productosModel.unity){
          errorAlert(context, Messages().TITLE_ERROR, Messages().MESSAGE_ALERT_COUNT);
        }
      }
    );
     
  }
}