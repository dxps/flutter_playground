import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  //
  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      child: Text(
        '\$$price',
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
    );
  }
}
