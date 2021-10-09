import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/galery_service.dart';
import 'package:treecommerce/src/services/product_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/utilerias/utils.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  GaleryService _service;
  UserPreferences _preferences;

  ProductosModel _producto;

  final _sizeIcons = 25.0;

  int _cantidad = 1;

  @override
  Widget build(BuildContext context) {

    _producto = ModalRoute.of(context).settings.arguments;
    _service = new GaleryService();
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
          Text(
            'Stock disponible',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          _stock(),
          _buttonShop(),
          _buttonAddCarShop(),
        ],
      ),
    );
  }

  Widget _valoration() {

    List<Widget> _valorationStarts = List<Widget>.generate(
      _producto.valorarion.round(), 
      (index) => Icon(Icons.star_outlined, color: Colors.blue, size: 15.0)
    );

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
      future: _service.getGalery(_producto.id),
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
    return Container(
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
    );
  }

  Widget _buttonShop() {
    return Container();
  }

  Widget _buttonAddCarShop() {
    return Container();
  }
}