import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// models
import '../models/product.dart';


class CartItem {
  final ProductModel productModel;
  final int quantity;
  CartItem( {
    @required  this.productModel,
    @required  this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  List<CartItem> get items { 
    return [..._items];
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(( cartItem ) {
      total += double.parse((cartItem.productModel.price * cartItem.quantity).toStringAsFixed(2));
    });
    return double.parse(total.toStringAsFixed(2));
  }

  void addToCart( CartItem cartItem ) {
    // Check if this id already exists
    var index = _items.indexWhere((element) => element.productModel.id == cartItem.productModel.id);
    if( index >= 0 ) {
      changeItemQuantity(
        id: cartItem.productModel.id,
        newQuantity: _items[index].quantity + cartItem.quantity
      );
    } else {
      _items.add( cartItem  );
    }
    notifyListeners();    
  }

  void removeFromCart ({
    String id
  }) {
    var index = _items.indexWhere((element) => element.productModel.id == id);
    if( index >= 0 ) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void changeItemQuantity ({
    String id,
    int newQuantity
  }) {
    var index = _items.indexWhere((element) => element.productModel.id == id);
    // _items.replaceRange(index, index+1, replacement)
    _items[index] = CartItem(
      productModel: _items[index].productModel,
      quantity: newQuantity,
    );
    notifyListeners();
  }

  void clearCartItems () {
    _items = [];
    notifyListeners();
  }

}