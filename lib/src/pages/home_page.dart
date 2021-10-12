import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treecommerce/src/bloc/home_bloc.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/services/home_service.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';
import 'package:treecommerce/src/widgets/card_product_widget.dart';
import 'package:treecommerce/src/widgets/card_view_widget.dart';
import 'package:treecommerce/src/widgets/drawer_widget.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeBloc _homeBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeService _homeService;
  List list = [];
  UserPreferences _preferences;

  @override
  Widget build(BuildContext context) {

    _homeBloc = Provider.homeBloc(context);
    _homeService =  Provider.homeService(context);
    _preferences = Provider.userPreferences(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCustom(),
      appBar: appBarSearch(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
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

  Widget _carousel(BuildContext context){ 

    return FutureBuilder(
      future: _homeService.carousel(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if( !snapshot.hasData ){
          return getLoader();
        }else{
          List<Image> itemList = snapshot.data.map((item) => 
            Image.network(item, fit: BoxFit.cover)
          ).toList();
          
          return Container(
            decoration: getDecorationGradient(),
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
      }
    );
    
  }

  Widget _lastView(){

    return FutureBuilder(
      future: _homeService.lastView(_preferences),
      builder: (BuildContext context, AsyncSnapshot<ProductosModel> snapshot){
        if(!snapshot.hasData){
          return getLoader();
        }else{
          return CardView(
            titleCard: "Visto recientemente", 
            footerCard: "Ver historia de navegacion", 
            contentCard: CardProduct(producto: snapshot.data),
            routeFooterCard: 'watched',
          );
        }
      }
    );
  }
  
  Widget _onSale(BuildContext context) {

    return CardView(
      titleCard: "Ofertas", 
      contentCard: getListProducts( _homeService.onSale(_preferences) ),
      footerCard: "Ver todas las ofertas",
      routeFooterCard: 'offers',
    );
  }

  Widget _inspirated() {

    return CardView(
      titleCard: "Inpirado en lo ultimo que viste", 
      contentCard: getListProducts( _homeService.inspirated(_preferences) ),
      footerCard: "Ver mas",
      routeFooterCard: 'inspirated',
    );
  }

  Widget _history() {

    return CardView(
      titleCard: "Historial de navegacion", 
      contentCard: getListProducts( _homeService.history(_preferences) ),
      footerCard: "Ver historial de navegacion",
      routeFooterCard: 'watched',
    );
  }
}