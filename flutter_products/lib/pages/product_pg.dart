import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../models/product.dart';
import '../widgets/ui_elements/title_default.dart';

//
class ProductPage extends StatelessWidget {
  //

  final int productIndex;

  ProductPage(this.productIndex);

  Widget _buildLocationPriceRow(String location, double price) {
    //
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(location, style: TextStyle(fontFamily: 'Oswald', color: Colors.grey)),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text('|', style: TextStyle(color: Colors.grey)),
        ),
        Text('\$$price', style: TextStyle(fontFamily: 'Oswald', color: Colors.grey))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false); // Pass back 'value' as false (2nd arg).
        return Future.value(false); // false in this case means no other pop() to do.
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext ctx, Widget child, MainModel model) {
          final Product product = model.products[productIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(product.image),
                Container(padding: EdgeInsets.all(10.0), child: TitleDefault(product.title)),
                Container(child: Text(product.description, style: TextStyle(fontSize: 16))),
                SizedBox(height: 15),
                _buildLocationPriceRow(product.location, product.price),
              ],
            ),
          );
        },
      ),
    );
  }
}
