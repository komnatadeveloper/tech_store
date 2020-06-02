import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartItem {
  final String id;
  final String brand;
  final String productNo;
  final String keyProperties;
  final String imageUrl;
  final int quantity;
  final double price;
  CartItem( {
    @required  this.id,
    @required  this.brand,
    @required  this.productNo,
    @required  this.keyProperties,
    @required  this.imageUrl,
    @required  this.quantity,
    @required  this.price,
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
      total += double.parse((cartItem.price * cartItem.quantity).toStringAsFixed(2));
    });
    return double.parse(total.toStringAsFixed(2));
  }

  void addToCart( CartItem cartItem ) {
    // Check if this id already exists
    var index = _items.indexWhere((element) => element.id == cartItem.id);
    if( index >= 0 ) {
      changeItemQuantity(
        id: cartItem.id,
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
    var index = _items.indexWhere((element) => element.id == id);
    if( index >= 0 ) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void changeItemQuantity ({
    String id,
    int newQuantity
  }) {
    var index = _items.indexWhere((element) => element.id == id);
    // _items.replaceRange(index, index+1, replacement)
    _items[index] = CartItem(
      id: _items[index].id,
      brand: _items[index].brand,
      productNo: _items[index].productNo,
      keyProperties: _items[index].keyProperties,
      imageUrl: _items[index].imageUrl,
      quantity: newQuantity,
      price: _items[index].price,
    );
    notifyListeners();
  }

}