
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
import '../models/customer_model.dart';

class ProductProvider with ChangeNotifier { 
  List<ProductModel> searchedProductsList = [];
  // From AuthProvider
  final String authToken;
  final CustomerModel customerModel;
  // Own variables
  bool _isLoadingProducts = false;
  bool _isLoadingFavorites = false;
  bool _isFavoritesFetched = false;
  List<ProductModel> favoriteProducts = [];
  ProductProvider(
    this.authToken,
    this.customerModel,
    this.searchedProductsList,
    this._isLoadingProducts,
    this._isLoadingFavorites,
    this._isFavoritesFetched,
    this.favoriteProducts
  );
  bool get isLoadingProducts  {
    return _isLoadingProducts;
  }
  bool get isLoadingFavorites  {
    return _isLoadingFavorites;
  }
  bool get isFavoritesFetched  {
    return _isFavoritesFetched;
  }


  // ----------------- METHODS  ---------------------
  Future<void> fetchFavoriteProducts () async {
     final url = '${constants.apiUrl}/api/customer/product/productList';
     _isLoadingFavorites = true;
     notifyListeners();
     try {
      final res = await http.post(
        url,
        body: json.encode({
          'productList': customerModel.favorites
        }),
        headers: {
          'token': authToken,
          'Content-Type': 'application/json'
        },
      );
      var unorderedFavoriteList =  convertResponseToProductList(res);
      List<ProductModel> orderedFavoriteList = [];
      for(int i = 0; i < customerModel.favorites.length; i++ ) {
        orderedFavoriteList.add(
          unorderedFavoriteList.firstWhere((element) => element.id == customerModel.favorites[i])
        );
      }
      favoriteProducts = [ ...orderedFavoriteList ];


     } catch ( err ) {
      print('ProductProvider -> fetchFavoriteProducts -> errors');
      print(err);
      // _isLoadingFavorites = false;
      // notifyListeners();
    }

     _isLoadingFavorites = false;
     _isFavoritesFetched = true;
     notifyListeners();
  } // End of fetchFavoriteProducts

  List<ProductModel> convertResponseToProductList ( http.Response res ) {
    final  extractedData = json.decode(res.body ) as List<dynamic>;
    print('ProductProvider -> convertResponseToProductList -> extractedData ->');
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
    return [ ...tempProductsList ];
  } // End of convertResponseToProductList


  void compareFavoriteListWithCustomerModel () {
    print('productProvider -> compareFavoriteListWithCustomerModel FIRED');
    var doListsMatch = true;
    if( customerModel.favorites.length != favoriteProducts.length  ) {
      doListsMatch = false;
    } else {
      for( int i = 0; i < customerModel.favorites.length; i++ ) {
        if(customerModel.favorites[i] != favoriteProducts[i].id) {
          doListsMatch = false;
        }
      }
    }
    // We removed items from favorites and maybe we may remove from list without sending any request to server
    if( !doListsMatch 
        && customerModel.favorites.length < favoriteProducts.length
        && customerModel.favorites.length  > 0
        ) {
      List<int> removedIndexesList = [];
      int customerListIndex = 0;
      int favoriteListIndex = 0;
      for( int i = 0; i < favoriteProducts.length; i++ ) {
        if( favoriteProducts[favoriteListIndex].id == customerModel.favorites[customerListIndex] ) {
          customerListIndex++;
          favoriteListIndex++;
        } else {
          removedIndexesList.add( favoriteListIndex );
          customerListIndex++;
        }
      }
      for( int i =  removedIndexesList.length-1; i <= 0; i--) {
        favoriteProducts.removeAt(removedIndexesList[i]);
      }
    } else if(
      !doListsMatch 
      && customerModel.favorites.length  == 0
    ) {
      favoriteProducts = [];
    } else if( !doListsMatch 
        && customerModel.favorites.length > favoriteProducts.length
        )  {
      _isFavoritesFetched = false;
    }
    notifyListeners();
    print('productProvider -> compareFavoriteListWithCustomerModel FINISHED');
  }


  Future<void> getProductsByCategory ({
    String categoryId
  }) async {
    final url = '${constants.apiUrl}/api/product/product?categoryId=$categoryId';
    print('ProductProvider -> getProductsByCategory FIRED');
    // print('url ->');
    // print(url);
    _isLoadingProducts = true;
    notifyListeners();

    try {
      final res = await http.get(url);  
      searchedProductsList = convertResponseToProductList(res);  
    } catch (err) {
      print('ProductProvider -> getProductsByCategory -> errors');
      print(err);
    }
    _isLoadingProducts = false;
    notifyListeners();
  }  // End of getProductsByCategory

}  // End of ProductProvider