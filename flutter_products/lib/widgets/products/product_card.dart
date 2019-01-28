import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../../models/product.dart';
import '../../scoped_models/main.dart';

//
class ProductCard extends StatelessWidget {
  //

  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  //
  @override
  Widget build(BuildContext context) {
    //
    return Card(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.asset(product.image),
            
          ),
          _buildTitlePriceRow(),
          _buildOverview(),
          _buildActionButtons(context)
        ],
      ),
    );
  }

  //
  Widget _buildTitlePriceRow() {
    //
    return Container(
      padding: EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(width: 10.0),
          PriceTag(product.price.toString()),
        ],
      ),
    );
  }

  //
  Widget _buildOverview() {
    //
    return Column(
      children: <Widget>[
        Container(
          child: Text(product.location),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
        ),
        Container(child: Text(product.userEmail, style: TextStyle(color: Colors.grey)))
      ],
    );
  }

  //
  Widget _buildActionButtons(BuildContext context) {
    //
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(context, '/products/' + productIndex.toString()),
        ),
        ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectProduct(productIndex);
                model.toggleProductFavorite();
              },
            );
          },
        ),
      ],
    );
  }
}
