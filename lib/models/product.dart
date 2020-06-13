import 'package:flutter/foundation.dart';

// class ProductModel {
//   final String id;
//   final String brand;
//   final String productNo;
//   final String keyProperties;
//   final String imageUrl;
//   // final int quantity;
//   final double price;

//   ProductModel( {
//     @required  this.id,
//     @required  this.brand,
//     @required  this.productNo,
//     @required  this.keyProperties,
//     @required  this.imageUrl,
//     // @required  this.quantity,
//     @required  this.price,
//   });
// }

class ProductImageModel {
  final bool isMain;
  final String imageId;

  ProductImageModel({
    this.isMain,
    this.imageId
  });
}

class ProductSpecificationModel {
  final String key;
  final String value;
  ProductSpecificationModel({
    this.key,
    this.value
  });
}

class ProductStockModel {
  final int stockQuantity;
  final bool isOnOrder;
  ProductStockModel({
    this.stockQuantity,
    this.isOnOrder
  });
}

class ProductModel {
  final String id;
  final List<ProductImageModel> imageList;
  final String brand;
  final String productNo;
  final String keyProperties;
  final List<ProductSpecificationModel> specifications;
  final double price;
  final ProductStockModel stockStatus;
  final List<String> category;
  // final String imageUrl;
  // final int quantity;

  ProductModel( {
    @required  this.id,
    @required  this.imageList,
    @required  this.brand,
    @required  this.productNo,
    @required  this.keyProperties,
    @required  this.specifications,
    // @required  this.imageUrl,
    // @required  this.quantity,
    @required  this.price,
    @required  this.stockStatus,
    @required  this.category,

  });
}

  