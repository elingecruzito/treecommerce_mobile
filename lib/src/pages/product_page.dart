import 'package:flutter/material.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/product_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';
import 'package:treecommerce/src/widgets/galery_carrucel_widget.dart';
import 'package:treecommerce/src/widgets/provider_info_widget.dart';
import 'package:treecommerce/src/widgets/stock_widget.dart';
import 'package:treecommerce/src/widgets/tab_bar_valorations_widget.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  UserPreferences _preferences;
  ProductService _service;

  ProductosModel _producto;
  final _sizeIcons = 25.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _producto = ModalRoute.of(context).settings.arguments;
    _service = Provider.productService(context);
    _preferences = Provider.userPreferences(context);

    FutureBuilder(
      future: Provider.watchedService(context).addLastView(_preferences, _producto.id),
      builder: (BuildContext context, AsyncSnapshot<ProductosModel> snapshot) {
        if( snapshot.hasData ){
          print(snapshot.data);
        }
        return ;
      },
    );
    
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text('Producto', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: _sizeIcons
        ),
        actions: [
          IconButton(
            icon: Icon(
              _producto.favorite ? Icons.favorite : Icons.favorite_border_outlined, 
              color: Colors.white
            ), 
            onPressed: () => print(_producto.id),
            iconSize: _sizeIcons,
          ),
          IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.white), 
            onPressed: () => Navigator.pushNamed(context, 'search'),
            iconSize: _sizeIcons,
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white), 
            onPressed: () => Navigator.pushNamed(context, 'error'),
            iconSize: _sizeIcons,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: _view_product(),
        )
      )
    );
  }

  Widget _view_product() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _producto.name,
            style: TextStyle(
              fontSize: 18.0
            ),
          ),
          Text(
            'por ' + _producto.provider,
            style: TextStyle(
              fontSize: 10.0
            ),
          ),
          SizedBox(height: 5.0),
          _valoration(),
          SizedBox(height: 5.0),
          GaleryCarrucelWidget(productId: _producto.id),
          _price(),
          SizedBox(height: 15.0),
          StockWidget(productosModel: _producto),
          SizedBox(height: 5.0),
          _buttonsShop(),
          SizedBox(height: 5.0),
          _moreProducts(),
          SizedBox(height: 5.0),
          ProviderInfoWidget(idProduct: _producto.id),
          SizedBox(height: 15.0),
          _description(),
          SizedBox(height: 15.0),
          _valorations(),
        ],
      ),
    );
  }

  Widget _valoration() {

    final _starts = _producto.valorarion.round();

    List<Widget> _valorationStarts = List<Widget>.generate(
      _starts, 
      (index) => Icon(Icons.star_outlined, color: Colors.blue, size: 15.0)
    );

    for (var i = 0; i < (5 - _starts); i++) {
      _valorationStarts.add(
        Icon(Icons.star_outlined, color: Colors.grey, size: 15.0)
      );
    }

    _valorationStarts.add(
      Text(
        '(${ _producto.count_valoration })',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0
        ),
      )
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _valorationStarts,
    );
  }
  
  Widget _price() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Si precio si cuenta con un descuento
        _producto.porcentage > 0 ?
        Text(
          '\$${ _producto.price }',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            decoration: TextDecoration.lineThrough,
          ),
        ) : Text(''),
        //Precio total
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$ ${_producto.total} ',
              style: TextStyle(
                fontSize: 25.0
              ),
            ),
            //Si cuenta con un descuento se imprime el porcentaje
            _producto.porcentage > 0 ? 
            Text(
              '${ _producto.porcentage }% OFF',
              style: TextStyle(
                color: Colors.lightGreen[700]
              ),
            ) : Text('')
          ],
        ),
        Text('IVA incluido'),
      ],
    );
  }

  Widget _buttonsShop() {
    return Column(
      children: [
        RaisedButton(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(13.0),
            child: Center(child: Text('Comprar ahora', style: TextStyle(color: Colors.white))),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          onPressed: () => print('Comprar ${ _producto.name }!'),
        ),
        RaisedButton(
          color: Colors.teal[100],
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(13.0),
            child: Center(child: Text('Agregar a carrito', style: TextStyle(color: Colors.teal[300]))),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          onPressed: () => print('Comprar ${ _producto.name }!'),
        ),
      ],
    );
  }

  Widget _moreProducts() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Text(
          'Mas publicaciones del vendedor',
          style: TextStyle(
            fontSize: 18.0
          ),
        ),
        SizedBox(height: 10.0),
        getListProducts( _service.getProductByProvider(_preferences, _producto.id) ),
        _watchMore('Ver mas productos del vendedor', ()=> print('Ver mas productos del vendedor'))
      ],
    );
  }

  Widget _watchMore(String _text, Function _function){
    return InkWell(
      onTap: () => _function,
      child: Container(
        padding: EdgeInsets.all(13.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.grey[350],
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Stack(
          children: [
            Text(
              _text,
              style: TextStyle(
                color: Colors.teal[300]
              ),
            ),
            Positioned(
              child: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.teal[300]), 
              right: 0.0
            )
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.0),
        Text(
          'Descripcion:', 
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          _producto.description,
          style: TextStyle(
            fontSize: 15.0
          ),
        )
      ],
    );
  }

  Widget _valorations() {

    final _starts = _producto.valorarion.round();
    List<Widget> _valorationStarts = List<Widget>();

    _valorationStarts.add(
      Text(
        _producto.valorarion.toStringAsFixed(1),
        style: TextStyle(
          fontSize: 40.0
        ),
      )
    );

    _valorationStarts.add(SizedBox(width: 10.0));

    for (var i = 0; i < 5; i++) {
      if( _starts > i ){
        _valorationStarts.add(Icon(Icons.star_outlined, color: Colors.blue, size: 25.0));
      }else{
        _valorationStarts.add(Icon(Icons.star_outlined, color: Colors.grey, size: 25.0));
      }
      
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opiniones del producto',
          style: TextStyle(
            fontSize: 18.0
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: _valorationStarts
        ),
        TabBarValorationsWidget(idProduct: _producto.id),
        _watchMore('Ver mas opciones', () => print('Ver mas opciones'))
      ],
    );
  }
}