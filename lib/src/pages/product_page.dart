import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/model/providers_model.dart';
import 'package:treecommerce/src/model/valorations_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/galery_service.dart';
import 'package:treecommerce/src/services/product_service.dart';
import 'package:treecommerce/src/services/providers_service.dart';
import 'package:treecommerce/src/services/valorations_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  GaleryService _serviceGalery;
  UserPreferences _preferences;
  ProductService _service;
  ProvidersService _providersService;
  ValorationsService _valorationsService;

  ProductosModel _producto;
  final _sizeIcons = 25.0;
  int _cantidad = 1;

  @override
  Widget build(BuildContext context) {

    _producto = ModalRoute.of(context).settings.arguments;
    _serviceGalery = new GaleryService();
    _service = new ProductService();
    _providersService = new ProvidersService();
    _valorationsService = new ValorationsService();
    _preferences = Provider.userPreferences(context);

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
          _galery(),
          _price(),
          Text('IVA incluido'),
          SizedBox(height: 15.0),
          _stock(),
          SizedBox(height: 5.0),
          _buttonsShop(),
          SizedBox(height: 5.0),
          _moreProducts(),
          SizedBox(height: 5.0),
          _providerInformation(),
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

  Widget _galery() {
    return FutureBuilder(
      future: _serviceGalery.getGalery(_producto.id),
      builder: (BuildContext context, AsyncSnapshot<List<GaleryModel>> snapshot){
        if( !snapshot.hasData ){
          return getLoader();
        }else{
          List<Image> itemList = snapshot.data.map((item) => 
            Image.network(item.path, fit: BoxFit.scaleDown)
          ).toList();
          
          return Container(
            width: double.infinity,
            height: 250.0,
            padding: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Swiper(
                loop: true,
                viewportFraction: 1.0,
                itemBuilder: (BuildContext context, int index){
                  return itemList[index];
                },
                itemCount: itemList.length,
                pagination: new SwiperPagination(
                  builder: new FractionPaginationBuilder(
                    activeColor: Colors.black,
                    color: Colors.grey,
                    fontSize: 10.0, 
                    activeFontSize: 10.0
                  )
                ),
              ),
            )
          );
        }
      }
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
        ) :
        Text(''),
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
            ) :
            Text('')
          ],
        )
      ],
    );
  }

  Widget _stock() {

    if( _producto.unity == 1 ){
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
      onTap: () => print('Agregar mas cantidad!'),
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
                    Text('${ _cantidad }', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10.0),
                    Text('(${_producto.unity} disponibles)', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
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

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.0),
        Text(
          'Descripcion:', 
          style: TextStyle(
            fontSize: 18.0,
            // fontWeight: FontWeight.bold,
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
        InkWell(
          onTap: () => print('Ver mas productos del proveedor'),
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
                  'Ver mas publicaciones del vendedor',
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
        )
      ],
    );
  
  }

  Widget _providerInformation() {

    return FutureBuilder(
      future: _providersService.getProduct(_preferences, _producto.id),
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
              _valorationLight(snapshot.data)
            ],
          );
        }
        return getLoader();
      },
    );
  }

  Widget _valorationLight(ProvidersModel _provider){

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
        _tabBarValorations(),
        InkWell(
          onTap: () => print('Ver mas opiniones'),
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
                  'Ver mas opiniones',
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
        )
      ],
    );
  }

  Widget _tabBarValorations() {

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
                    future: _valorationsService.getAllValorations(_preferences, _producto.id),
                    builder: (BuildContext context, AsyncSnapshot<List<ValorationsModel>> snapshot) {
                      return _renderValorations(snapshot);
                    },
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: _valorationsService.getPositivesValorations(_preferences, _producto.id),
                    builder: (BuildContext context, AsyncSnapshot<List<ValorationsModel>> snapshot) {
                      return _renderValorations(snapshot);
                    },
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: _valorationsService.getNegativesValorations(_preferences, _producto.id),
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