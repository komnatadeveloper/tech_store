
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
  String? authToken;
  CustomerModel? customerModel;
  // Own variables
  bool _isLoadingProducts = false;
  bool _isLoadingFavorites = false;
  bool _isFavoritesFetched = false;
  List<ProductModel> favoriteProducts = [];
  List<ProductModel> specialPriceItems = [];
  List<ProductModel> _mostPopularProductsList = [];

  void update (
    String? authToken,
    CustomerModel? customerModel,
    List<ProductModel> searchedProductsList,
    bool _isLoadingProducts,
    bool _isLoadingFavorites,
    bool _isFavoritesFetched,
    List<ProductModel> favoriteProducts,
    List<ProductModel> specialPriceItems,
    List<ProductModel> _mostPopularProductsList
  ) {
    this.authToken = authToken;
    this.customerModel = customerModel;
    this.searchedProductsList = searchedProductsList;
    this._isLoadingProducts = _isLoadingProducts;
    this._isLoadingFavorites = _isLoadingFavorites;
    this._isFavoritesFetched = _isFavoritesFetched;
    this.favoriteProducts = favoriteProducts;
    this.specialPriceItems = specialPriceItems;
    this._mostPopularProductsList = _mostPopularProductsList;
  }
  // Getters
  bool get isLoadingProducts  {
    return _isLoadingProducts;
  }
  bool get isLoadingFavorites  {
    return _isLoadingFavorites;
  }
  bool get isFavoritesFetched  {
    return _isFavoritesFetched;
  }
  List<ProductModel> get mostPopularProductsList  {
    return _mostPopularProductsList;
  }


  // ----------------- METHODS  ---------------------

  void resetProductProvider () {
    _isLoadingProducts = false;
    _isLoadingFavorites = false;
    _isFavoritesFetched = false;
    favoriteProducts = [];
    specialPriceItems = [];
    // _mostPopularProductsList = [];
    notifyListeners();
  } // End of resetProductProvider


  Future<void> fetchFavoriteProducts () async {
     final url = '${constants.apiUrl}/api/customer/product/productList';
     _isLoadingFavorites = true;
     notifyListeners();
     try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode({
          'productList': customerModel!.favorites
        }),
        headers: {
          'token': authToken!,
          'Content-Type': 'application/json'
        },
      );
      var unorderedFavoriteList =  convertResponseToProductList(res);
      List<ProductModel> orderedFavoriteList = [];
      for(int i = 0; i < customerModel!.favorites.length; i++ ) {
        orderedFavoriteList.add(
          unorderedFavoriteList.firstWhere((element) => element.id == customerModel!.favorites[i])
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


  void setSpecialPriceItems (
    List<ProductModel> specialItemsList
  ) {
    specialPriceItems = specialItemsList;
    notifyListeners();
  }


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
    if( customerModel!.favorites.length != favoriteProducts.length  ) {
      doListsMatch = false;
    } else {
      for( int i = 0; i < customerModel!.favorites.length; i++ ) {
        if(customerModel!.favorites[i] != favoriteProducts[i].id) {
          doListsMatch = false;
        }
      }
    }
    // We removed items from favorites and maybe we may remove from list without sending any request to server
    if( !doListsMatch 
        && customerModel!.favorites.length < favoriteProducts.length
        && customerModel!.favorites.length  > 0
        ) {
      List<int> removedIndexesList = [];
      int customerListIndex = 0;
      int favoriteListIndex = 0;
      for( int i = 0; i < favoriteProducts.length; i++ ) {
        if( favoriteProducts[favoriteListIndex].id == customerModel!.favorites[customerListIndex] ) {
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
      && customerModel!.favorites.length  == 0
    ) {
      favoriteProducts = [];
    } else if( !doListsMatch 
        && customerModel!.favorites.length > favoriteProducts.length
        )  {
      _isFavoritesFetched = false;
    }
    notifyListeners();
    print('productProvider -> compareFavoriteListWithCustomerModel FINISHED');
  } // End of compareFavoriteListWithCustomerModel


  Future<void> getProductsByCategory ({
    required String categoryId
  }) async {
    final url = '${constants.apiUrl}/api/customer/productByCategory?categoryId=$categoryId';
    print('ProductProvider -> getProductsByCategory FIRED');
    // print('url ->');
    // print(url);
    _isLoadingProducts = true;
    notifyListeners();
    try {
      final res = await http.get(
        Uri.parse(url),
        headers: {
          'token': authToken!,
          'Content-Type': 'application/json'
        },
      );  
      searchedProductsList = convertResponseToProductList(res);  
      searchedProductsList = handleSpecialPriceItemsForSearchedItems(searchedProductsList);
    } catch (err) {
      print('ProductProvider -> getProductsByCategory -> errors');
      print(err);
    }
    _isLoadingProducts = false;
    notifyListeners();
  }  // End of getProductsByCategory

  Future<void> getMostPopularProducts () async {
    final url = '${constants.apiUrl}/api/customer/statistic?type=topSellStatistic&populateProducts=yes&maxCount=10';
    print('ProductProvider -> getMostPopularProducts FIRED -> url -> ' + url.toString());
    try {
      final res = await http.get(
        Uri.parse(url),
        headers: {
          'token': authToken!,
          'Content-Type': 'application/json'
        },
      );  
      _mostPopularProductsList = convertResponseToProductList(res);  
      _mostPopularProductsList = handleSpecialPriceItemsForSearchedItems(_mostPopularProductsList);
    } catch (err) {
      print('ProductProvider -> getMostPopularProducts -> errors');
      print(err);
    }
    notifyListeners();
  }  // End of getMostPopularProducts


  Future<List<ProductModel>> getProductsByIdList ({
    required List<String> idList
  }) async {
    final url = '${constants.apiUrl}/api/customer/product/productList';
    print('ProductProvider -> getProductsByIdList FIRED');
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'token': authToken!,
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'productList':idList
        })
      );  
      var tempProductList = convertResponseToProductList(res);  
      tempProductList = handleSpecialPriceItemsForSearchedItems(tempProductList);
      return [...tempProductList];
    } catch (err) {
      print('ProductProvider -> getProductsByIdList -> errors');
      print(err);
      return [];
    }
  }  // End of getProductsByIdList


  List<ProductModel> handleSpecialPriceItemsForSearchedItems (
    List<ProductModel> inputList
  ) {
    if( inputList.length > 0 ) {
      var tempList = [...inputList];
      for( int i = 0; i < tempList.length; i++ ) {
        for(  int j = 0; j < customerModel!.specialPriceItems.length; j++ ) {
          if ( tempList[i].id == customerModel!.specialPriceItems[j].id ) {
            // tempList[i].price = customerModel.specialPriceItems[j].price;
            tempList[i] = ProductModel(
              id: tempList[i].id,
              imageList: tempList[i].imageList,
              brand: tempList[i].brand,
              productNo: tempList[i].productNo,
              keyProperties: tempList[i].keyProperties,
              specifications: tempList[i].specifications,
              price: customerModel!.specialPriceItems[j].price,
              stockStatus: tempList[i].stockStatus,
              category: tempList[i].category,
            );
          }
        }
      }
      return [...tempList];
    } else {
      return [];
    }
  } // End of handleSpecialPriceItemsForSearchedItems


  Future<void> getProducts ({
    String categoryId = '',
    String productId = '',
    String brand = ''
  }) async {
    var queryString = '';
    int queriedParameterCount = 0;
    if( categoryId != '' ) {
      if( queriedParameterCount != 0 ) {
        queryString = queryString + '&';
      }
      queryString = queryString + 'categoryId=' + categoryId;
      queriedParameterCount++;
    }
    if( productId != '' ) {
      if( queriedParameterCount != 0 ) {
        queryString = queryString + '&';
      }
      queryString = queryString + 'productId=' + productId;
      queriedParameterCount++;
    }
    if( brand != '' ) {
      if( queriedParameterCount != 0 ) {
        queryString = queryString + '&';
      }
      queryString = queryString + 'brand=' + brand;
      queriedParameterCount++;
    }
    if( queriedParameterCount == 0 ) {
      return;
    }
    final url = '${constants.apiUrl}/api/customer/product/get?$queryString';
    print('ProductProvider -> getProducts FIRED');
    // print('url ->');
    // print(url);
    _isLoadingProducts = true;
    notifyListeners();
    try {      
      final res = await http.get(
        Uri.parse(url),
        headers: {
          'token': authToken!,
          'Content-Type': 'application/json'
        },
      );  
      searchedProductsList = convertResponseToProductList(res);  
      searchedProductsList = handleSpecialPriceItemsForSearchedItems(searchedProductsList);
    } catch (err) {
      print('ProductProvider -> getProducts -> errors');
      print(err);
    }
    _isLoadingProducts = false;
    notifyListeners();
  }  // End of getProducts


  Future<void> queryProducts ({
    required String search
  }) async {
    final url = '${constants.apiUrl}/api/customer/product/query?search=$search';
    print('ProductProvider -> queryProducts -> url ->');
    print(url);
    // print('url ->');
    // print(url);
    _isLoadingProducts = true;
    notifyListeners();
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'token': authToken!,
          'Content-Type': 'application/json'
        },
      );  
      searchedProductsList = convertResponseToProductList(res);  
      searchedProductsList = handleSpecialPriceItemsForSearchedItems(searchedProductsList);
    } catch (err) {
      print('ProductProvider -> queryProducts -> errors');
      print(err);
    }
    _isLoadingProducts = false;
    notifyListeners();
  }  // End of getProductsByCategory

}  // End of ProductProvider