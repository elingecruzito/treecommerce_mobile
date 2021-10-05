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
    
    return Container(
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
            tag: item.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage('https://coca-colafemsa.com/wp-content/uploads/2019/11/2.png'),
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
                  '${item.price}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.0
                  )
                ),
                SizedBox(height: 5.0),
                Text(
                  item.name,
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
      onTap: () => print('Detalle pelicula ${item.name}...!'),
    );
  }
}