import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped_models/main.dart';

//
class ProductEditPage extends StatefulWidget {
  //

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

//
class _ProductEditPageState extends State<ProductEditPage> {
  //

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'isFavorite': false,
    'image': 'assets/food.jpg',
    'location': 'Default Location Avenue, 156'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //
  @override
  Widget build(BuildContext context) {
    //
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        //
        Product selectedProduct = model.selectedProduct;
        _formData['isFavorite'] = selectedProduct != null ? selectedProduct.isFavorite : false ;
        Widget pageContent = _buildPageContent(context, selectedProduct);
        return selectedProduct == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(title: Text('Edit Product')),
                body: pageContent,
              );
      },
    );
  }

  //
  Widget _buildTitleField(Product product) {
    //
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: product != null ? product.title : '',
      validator: (String value) {
        if (value.isEmpty || value.length < 5) return 'Title is required and must be 5+ chars long';
      },
      onSaved: (String value) => _formData['title'] = value,
    );
  }

  //
  Widget _buildDescriptionField(Product product) {
    //
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 2,
      initialValue: product != null ? product.description : '',
      onSaved: (String value) => _formData['description'] = value,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) return 'Title is required and must be 10+ chars long';
      },
    );
  }

  //
  Widget _buildPriceField(Product product) {
    //
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      initialValue: product != null ? product.price.toString() : '',
      onSaved: (String value) {
        // treat '.' and ',' mix
        _formData['price'] = double.parse(value);
      },
      validator: (String value) {
        if (value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value))
          return 'Price is required and should be a number';
      },
    );
  }

  //
  Widget _buildSubmitButton() {
    //
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Save'),
          textColor: Colors.white,
          onPressed: () => _submitForm(
                model.addProduct,
                model.updateProduct,
                model.authenticatedUser.id,
                model.authenticatedUser.email,
                model.selectedProductIndex,
              ),
        );
      },
    );
  }

  //
  _submitForm(Function addProduct, Function updateProduct, String userId, String userEmail,
      [int selectedProductIndex]) {
    //
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    Product product = _buildProductFromForm(userId, userEmail);
    if (selectedProductIndex == null)
      addProduct(product);
    else
      updateProduct(product);

    Navigator.pushReplacementNamed(context, '/admin');
  }

  //
  Product _buildProductFromForm(String userId, String userEmail) {
    //
    return Product(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        location: 'Sweet Life Avenue, 90210',
        image: 'assets/food.jpg',
        isFavorite: _formData['isFavorite'],
        userId: userId,
        userEmail: userEmail);
  }

  //
  Widget _buildPageContent(BuildContext context, Product product) {
    //
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.9;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()), // for closing the keyboard
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleField(product),
              _buildDescriptionField(product),
              _buildPriceField(product),
              SizedBox(height: 10.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
