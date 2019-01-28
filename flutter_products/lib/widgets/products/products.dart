import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../scoped_models/main.dart';
import '../../models/product.dart';

//
class Products extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductList(model.displayedProducts);
    });
  }

  //
  Widget _buildProductList(List<Product> products) {
    //
    return Container(
      padding: EdgeInsets.all(10.0),
      child: products.length > 0
          ? ListView.builder(
              itemBuilder: (BuildContext ctx, int index) => ProductCard(products[index], index),
              itemCount: products.length,
            )
          : Center(
              child: Text('No products exist ...'),
            ),
    );
  }
}
