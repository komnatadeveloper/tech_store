
import 'package:flutter/foundation.dart';
// HTTP and convert
import 'package:http/http.dart' as http;
import 'dart:convert';
// constants
import '../constants/constants.dart' as constants;
// helpers
import '../helpers/helpers.dart' as helpers;
// Models
import '../models/product.dart';

class ProductProvider with ChangeNotifier { 
  List<ProductModel> searchedProductsList = [];

  Future<void> getProductsByCategory ({
    String categoryId
  }) async {
    final url = '${constants.apiUrl}/api/product/product?categoryId=$categoryId';
    print('ProductProvider -> getProductsByCategory FIRED');
    // print('url ->');
    // print(url);

    try {
      final res = await http.get(url);
      final  extractedData = json.decode(res.body ) as List<dynamic>;
      print('ProductProvider -> getProductsByCategory -> extractedData ->');
      print(extractedData);
      var mappedList = helpers.convertListDynamicToListMap(extractedData);
      List<ProductModel> tempProductsList = [];
      // Create List<ProductModel>
      for( int i = 0; i < mappedList.length; i++ ) {
        var tempSpecList = mappedList[i]['specifications'] as List<dynamic>;
        final List<ProductSpecificationModel> specifications = [];
        for(int i = 0; i < tempSpecList.length; i++) {
          specifications.add(
            ProductSpecificationModel(
              key: tempSpecList[i]['key'],
              value: tempSpecList[i]['value'],
            )
          );
        }
        print('specifications OK');
        var rawImageList = mappedList[i]['imageList'] as List<dynamic>;
        List<ProductImageModel> imageList = [];
        for(int i = 0; i < rawImageList.length; i++) {
          imageList.add(
            ProductImageModel(
              imageId: rawImageList[i]['imageId'],
              isMain: rawImageList[i]['isMain']
            )
          );
        }
        print('imageList OK');
        var tempStockStatus = mappedList[i]['stockStatus'] as Map<String, dynamic>;
        ProductStockModel stockStatus = ProductStockModel(
          isOnOrder: tempStockStatus['isOnOrder'] ?? false,
          stockQuantity: tempStockStatus['stockQuantity']
        );
        print('stockStatus OK');
        var category = helpers.convertDynamicToListString(mappedList[i]['category']);
        print('category OK');
        tempProductsList.add(
          ProductModel(
            id: mappedList[i]['_id'],
            imageList: [ ...imageList ],
            brand: mappedList[i]['brand'],
            productNo: mappedList[i]['productNo'],
            keyProperties: mappedList[i]['keyProperties'],
            specifications: specifications,
            price:  double.parse(mappedList[i]['price'].toString()) ,
            stockStatus: stockStatus,
            category: [ ...category ],
          )
        );
      } // End of Create List<ProductModel>

      searchedProductsList = [...tempProductsList];
      notifyListeners();

    } catch (err) {
      print('ProductProvider -> getProductsByCategory -> errors');
      print(err);
    }

  }  // End of getProductsByCategory

}  // End of ProductProvider