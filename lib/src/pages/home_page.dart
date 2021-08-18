import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.0)
        // ),
        backgroundColor: Colors.white,
        title: Center(child: Text('Home', style: TextStyle(color: Colors.teal[300]))),
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.teal[300]), 
            onPressed: () => print('Shopping car!')
          )
        ],
      ),
      body: Column(
        children: [
          _carousel(context),
        ],
      ),
    );
  }

  Widget _carousel(BuildContext context) {
    

    return Container(
      width: double.infinity,
      height: 300.0,
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
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ),
      )
    );

    // return Column(
    //   children: <Widget>[
    //     CarouselSlider(
    //       items: imgList.map((item) => 
    //         Image.network(item, fit: BoxFit.cover)
    //       ).toList(),
    //       carouselController: _controller,
    //       options: CarouselOptions(
    //         autoPlay: true,
    //         enlargeCenterPage: true,
    //         aspectRatio: 2.0,
    //         onPageChanged: (index, reason) =>
    //           setState(() => _current = index)
    //       ),
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: imgList.asMap().entries.map((entry){
    //         return GestureDetector(
    //           onTap: ()=> _controller.animateToPage(entry.key),
    //           child: Container(
    //             width: 7.0,
    //             height: 7.0,
    //             margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: (
    //                       Theme.of(context).brightness == Brightness.dark
    //                       ? Colors.white 
    //                       : Colors.black
    //                     ).withOpacity(_current == entry.key ? 0.9 : 0.4)
    //             ),
    //           ),
    //         );
    //       }).toList(),
    //     )
    //   ]
    // );
  }
}