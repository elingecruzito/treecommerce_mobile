import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treecommerce/src/model/productos_model.dart';

class CardSwiper extends StatelessWidget {

  CardSwiper({ @required this.items });
  
  List<ProductosModel> items;
  final _pageController = new PageController(
    initialPage: 0,
    viewportFraction: 0.5,
  );

  @override
  Widget build(BuildContext context) {

    final _screanSize = MediaQuery.of(context).size;
    
    return Container(
      // height: _screanSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: (context, index){
          return _targeta(context, items[index]);
        },
      ),
    );
    
  }

  Widget _targeta(BuildContext context, ProductosModel item) {
    
    final _card = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Column(
        children: [
          Hero(
            tag: item.g01Id,
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(item.g01Imagens),
              fit: BoxFit.cover,
              height: 120.0,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.g01Precio}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.0
                  )
                ),
                SizedBox(height: 5.0),
                Text(
                  item.g01Name,
                  style: TextStyle(
                    fontSize: 12.0
                  ),
                )
              ]
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: _card,
      onTap: () => print('Detalle pelicula ${item.g01Name}...!'),
    );
  }
}