import 'package:flutter/foundation.dart';

class ProductModel {
  final String id;
  final String brand;
  final String productNo;
  final String keyProperties;
  final String imageUrl;
  // final int quantity;
  final double price;

  ProductModel( {
    @required  this.id,
    @required  this.brand,
    @required  this.productNo,
    @required  this.keyProperties,
    @required  this.imageUrl,
    // @required  this.quantity,
    @required  this.price,
  });
}

  