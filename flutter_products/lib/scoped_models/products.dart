import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

//
mixin ProductsModel on Model {
  //

  List<Product> _products = [];
  int _selectedProductIndex;
  bool _showFavorites = false;

  List<Product> get products {
    // returning a copy of the list
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    return _selectedProductIndex != null ? _products[_selectedProductIndex] : null;
  }

  void toggleProductFavorite() {
    _products[_selectedProductIndex] = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        location: selectedProduct.location,
        userId: selectedProduct.userId,
        userEmail: selectedProduct.userEmail,
        isFavorite: !selectedProduct.isFavorite);
    notifyListeners();
    _selectedProductIndex = null;
  }

  void toggleDisplayFavorites() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  bool get displayFavorites {
    return _showFavorites;
  }
}
