import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treecommerce/src/model/galery_model.dart';
import 'package:treecommerce/src/provider/provider.dart';
import 'package:treecommerce/src/utilerias/utils.dart';

class GaleryCarrucelWidget extends StatelessWidget {

  GaleryCarrucelWidget({ @required this.productId });

  int productId;

  @override
  Widget build(BuildContext context) {

    final _serviceGalery = Provider.galeryService(context);
    
    return FutureBuilder(
      future: _serviceGalery.getGalery(productId),
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
}