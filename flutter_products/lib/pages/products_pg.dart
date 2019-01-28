import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped_models/main.dart';

//
class ProductsPage extends StatelessWidget {
//

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy List'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavorites ? Icons.favorite : Icons.favorite_border),
                onPressed: () => model.toggleDisplayFavorites(),
              );
            },
          )
        ],
      ),
      body: Products(),
      drawer: _buildSideDrawer(context),
    );
  }

  //
  Widget _buildSideDrawer(BuildContext context) {
    //
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Options'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () => Navigator.pushReplacementNamed(context, '/admin'),
          ),
          ListTile(
            leading: Icon(Icons.eject),
            title: Text('Logout'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          )
        ],
      ),
    );
  }
}
