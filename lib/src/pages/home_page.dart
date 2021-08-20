import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treecommerce/src/bloc/home_bloc.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/widgets/card_product_widget.dart';
import 'package:treecommerce/src/widgets/card_swiper_widget.dart';
import 'package:treecommerce/src/widgets/card_view_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


    final itemList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ].map((item) => 
            Image.network(item, fit: BoxFit.cover)
          ).toList();

    HomeBloc _homeBloc;
  

  @override
  Widget build(BuildContext context) {

    _homeBloc = Provider.homeBloc(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _customAppBar(),
              _carousel(context),
              _lastView(),
              _onSale(context),
              _inspirated(),
              _history(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customAppBar(){

    final double sizeIcons = 25.0;
    final sizeWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: 50.0,
      color: Colors.teal[300],
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.dehaze, color: Colors.white), 
            onPressed: () => print('Configuration...!'),
            iconSize: sizeIcons
          ),
          _buscador((sizeWidth - (sizeIcons * 4))),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white), 
            onPressed: () => print('Shopping car!'),
            iconSize: sizeIcons,
          )
        ],
      ),
    );
  }

  Widget _buscador(double width){
    return InkWell(
      onTap: () => print("Buscador....!"),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.white,
          width: width,
          height: 32.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.search_outlined, color: Colors.grey, size: 15.0),
                SizedBox(width: 5.0),
                Text("Buscar en TreeCommerse", style: TextStyle(color: Colors.grey, fontSize: 12.0))
              ]
            ),
          )
        ),
      ),
    );
  }

  Widget _carousel(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.teal[300],
            Colors.teal[200],
            Colors.teal[100],
            Colors.white
          ]
        )
      ),
      width: double.infinity,
      height: 200.0,
      padding: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Swiper(
          loop: true,
          autoplay: true,
          viewportFraction: 1.0,
          itemBuilder: (BuildContext context, int index){
            return itemList[index];
          },
          itemCount: itemList.length,
          pagination: new SwiperPagination(
            builder: new DotSwiperPaginationBuilder(
              activeColor: Colors.grey,
              size: 5.0, 
              activeSize: 5.0
            )
          ),
        ),
      )
    );
  }

  Widget _lastView(){

    ProductosModel _lastView = _homeBloc.getLastView();

    return CardView(
      titleCard: "Visto recientemente", 
      footerCard: "Ver historia de navegacion", 
      contentCard: CardProduct(producto: _lastView,)
    );
  }
  
  Widget _getListProducts(Future<List<ProductosModel>> result){
    return Container(
      width: double.infinity,
      child: FutureBuilder(
        future: result,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData){
            return Column(
              children: snapshot.data.map(
                (item) => CardProduct(
                  producto: item
                )
              ).toList()
            );
          }else{
            return Container(
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator()
              )
            );
          }
          
        }
      ),
    );
  }
  
  Widget _onSale(BuildContext context) {

    return CardView(
      titleCard: "Ofertas", 
      contentCard: _getListProducts( _homeBloc.getOnSale() ),
      footerCard: "Ver todas las ofertas",
    );
  }

  Widget _inspirated() {

    return CardView(
      titleCard: "Inpirado en lo ultimo que viste", 
      contentCard: _getListProducts( _homeBloc.inspiratedOnLastView() ),
      footerCard: "Ver mas",
    );
  }

  Widget _history() {
    return CardView(
      titleCard: "Historial de navegacion", 
      contentCard: _getListProducts( _homeBloc.historyViews() ),
      footerCard: "Ver historial de navegacion",
    );
  }
}