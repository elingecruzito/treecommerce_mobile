import 'package:flutter/material.dart';

class CardView extends StatelessWidget {

  CardView({ 
    @required this.titleCard, 
    this.footerCard, 
    @required this.contentCard 
  });

  String titleCard;
  String footerCard = null;
  Widget contentCard;

  final _border = BorderSide(
    width: 0.5,
    color: Colors.grey[300],
    style: BorderStyle.solid
  );

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 10.0,
        child: Column(
          children: [
            _header(),
            this.contentCard,
            _footer(),
          ]
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Text(this.titleCard, style: TextStyle(fontWeight: FontWeight.bold)),
      decoration: BoxDecoration(
        border: Border(
          bottom: _border
        ),
      ),
    );
  }

  Widget _footer() {
    if(this.footerCard == null ){
      return Container();
    }else{
      return GestureDetector(
        onTap: () => print('Function Card View...!'),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            border: Border( 
              top: _border
            )
          ),
          child: Text(
            this.footerCard, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.blue
            )
          ),
        ),
      );
    }
  }

  
}