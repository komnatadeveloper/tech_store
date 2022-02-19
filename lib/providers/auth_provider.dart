import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// HTTP and convert
import 'package:http/http.dart' as http;
import 'dart:convert';
// Models
import '../models/customer_model.dart';
// constants
import '../constants/constants.dart' as constants;
// helpers
import '../helpers/helpers.dart' as helpers;



class AuthProvider with ChangeNotifier { 

  String? _token;
  String? _userId;
  CustomerModel? _customerModel;
  AddressModel? _oneTimeAddress;
  int? _selectedAddressIndex ;
  String? _orderDeliverOption; // 'from-tech-store-warehouse' || 'shipment-to-address'
  bool isAppInited = false;
  // Getters
  bool get isAuth {
    return _token != null;
  }
  String? get token {
    return _token;
  }
  CustomerModel? get customerModel {
    return _customerModel;
  }
  int? get selectedAddressIndex {
    return _selectedAddressIndex ;
  }
  void setSelectedAddressIndex (int newIndex) {
    if( _customerModel!.addressList.length > newIndex  ) {
      _selectedAddressIndex = newIndex;
      notifyListeners();
    }
  }
  String? get orderDeliverOption {
    return _orderDeliverOption;
  }

  //  -------------Methods-------------------
  void setOrderDeliveryOption (
    String newDeliveryOption
  ) {
    if ( newDeliveryOption != _orderDeliverOption) {
      if( 
        newDeliveryOption == 'from-tech-store-warehouse'
        || newDeliveryOption == 'shipment-to-address'
       ) {
         _orderDeliverOption = newDeliveryOption;
         notifyListeners();
       }
    }
  }


  void resetAuthProvider () {
    _token = null;
    _userId = null;
    _customerModel = null;
    _oneTimeAddress = null;
    _selectedAddressIndex = null;
    _orderDeliverOption = null;
    notifyListeners();
  }


  Future<void> initialiseApp ( ) async {
    print('authRouter -> initialiseApp FIRED');
    var initialSharedPrefsData = await getInitDataFromDb();
    print('authRouter -> initialiseApp -> initialSharedPrefsData -> $initialSharedPrefsData');
    if( initialSharedPrefsData == null ) {
      return;
    }
    await signin(
      initialSharedPrefsData['email']! , 
      initialSharedPrefsData['password']! 
    );
    isAppInited = true;
    notifyListeners();
  }


  Future<void> recordCredentialstoDevice ({
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final komnataTechStore = json.encode( {
        'email': email.trim(),
        'password': password.trim(),
      } );
      await prefs.setString('komnataTechStore', komnataTechStore);
    } catch  ( err ) {
      throw err;
    }
  }


  Future<void> removeCredentialsFromDevice () async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('komnataTechStore');
    } catch  ( err ) {
      print('authProvider -> removeCredentialsFromDevice -> errors -> $err');
      throw err;
    }
  }



  
  // Get Initial Data From Device
  Future<Map<String, String>?> getInitDataFromDb ()  async{
    print('authProvider -> getInitDataFromDb FIRED');
    final prefs = await SharedPreferences.getInstance();
    // If First Use of App
    if(  !prefs.containsKey( 'komnataTechStore' ) ) {
      return null;
    } else {  // NOT FIRST USE OF APP 
      final extractedUserData = json.decode(
        prefs.getString('komnataTechStore')!
      ) as Map<String, dynamic>;
      var email = extractedUserData['email'] as String;
      var password = extractedUserData['password'] as String;
      return {
        'email': email,
        'password': password,
      }; 
    }
  }  // End of getInitDataFromDb





  // signup
  Future<List<dynamic>?> signup (String email, String password) async {
    const url = constants.apiUrl + '/api/customer/auth/signup';
    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': email.trim(),
          'password': password
        }),
        headers: {
          'Content-Type': 'application/json'
        },
      );
      final responseData = json.decode( res.body );
      if( res.statusCode == 400 ) {
        return json.decode( 
          res.body 
        )['errors'] as List<dynamic>;        
      }
      var balance = responseData['customer']['balance'];
      _token = responseData['token'];
      _customerModel = CustomerModel(
        id: responseData['customer']['_id'],
        email: responseData['customer']['email'],
        balance: double.parse(double.parse(balance.toString()).toStringAsFixed(2))
             
      );
      _customerModel!.addressList = [];
      if( responseData['customer']['addressList'] != null ) {
        var rawAddressList = helpers.convertListDynamicToListMap(
          responseData['customer']['addressList'] as List<dynamic>
        );
        for( int i = 0; i < rawAddressList.length; i++ ) {
          var tempAddressItem = AddressModel(
            definition: rawAddressList[i]['definition'],
            receiver: rawAddressList[i]['receiver'],
            addressString: rawAddressList[i]['addressString'],
            city: rawAddressList[i]['city'],
          );
          if( rawAddressList[i]['_id'] != null ) {
            tempAddressItem.id = rawAddressList[i]['_id'];
          }
          _customerModel!.addressList.add(tempAddressItem);
        }
        print('_customerModel.addressList.length ->');
        print(_customerModel!.addressList.length);
      }
      if( _customerModel!.addressList.length > 0 ) {
        _selectedAddressIndex = 0;
      }
      _customerModel!.specialPriceItems = [];
      if( responseData['customer']['specialPriceItems'] != null ) {
        print('responseData -> customer -> specialPriceItems ->');
        print(responseData['customer']['specialPriceItems']);
        var rawSpecialPriceItems = helpers.convertListDynamicToListMap(
          responseData['customer']['specialPriceItems'] as List<dynamic>
        );
        for( int i = 0; i < rawSpecialPriceItems.length; i++) {
          _customerModel!.specialPriceItems.add(
            SpecialPriceItemModel(
              id: rawSpecialPriceItems[i]['productId'],
              price: double.parse(
                double.parse(
                  rawSpecialPriceItems[i]['price'].toString()
                ).toStringAsFixed(2)
              )  
            )
          );
        }        
      }
      for(final name in responseData['customer'].keys) {
        // print(name);
        // print(rawItem[name]);
        
        switch (name) {
          case  'favorites':
            _customerModel!.favorites = helpers.convertDynamicToListString(responseData['customer'][name]) ;
            print('_customerModel.favorites ->');
            print(_customerModel!.favorites);
            break;
          case  'orders':
            // _customerModel.orders = helpers.convertDynamicToListString(responseData['customer'][name]);
            _customerModel!.orders = [];
            var rawOrders = helpers.convertListDynamicToListMap(responseData['customer'][name] as List<dynamic>);
            if( rawOrders.length > 0 ) {
              for( int i = 0; i < rawOrders.length; i++ ) {
                _customerModel!.orders.add(
                  rawOrders[i]['orderId'] as String
                );
              }
            }
            print('_customerModel.orders ->');
            print(_customerModel!.orders);
            break;
          
          default:
          print(responseData['customer'][name]);
        }
        
      }
      _orderDeliverOption = _customerModel!.addressList.length == 0 
        ? 'from-tech-store-warehouse' 
        : 'shipment-to-address';
      
      // _customerModel.favorites = responseData['customer']['favorites'];
      notifyListeners();
      print('userId ->');
      print( customerModel!.id );
      return null; 
    } catch ( err ) {
      print( 'authProvider -> signup -> Errors ->'  );
      print(err);
    }
  }  // End of signup


  // signin
  Future<List<dynamic>?> signin (String email, String password) async {
    print('AuthProvider -> singin -> email, password ->');
    try {
      print( email  );
      print( password );
      const url = constants.apiUrl + '/api/customer/auth/signin';
      final res = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': email.trim(),
          'password': password
        }),
        headers: {
          'Content-Type': 'application/json'
        },
        // body: {
        //   'email': email.trim(),
        //   'password': password
        // },
      );
      if( res.statusCode == 400 ) {
        return json.decode( 
          res.body 
        )['errors'] as List<dynamic>;        
      }

      print('AuthProvider -> singin -> res.body ->');
      print(res.body);
      final responseData = json.decode( res.body );
      var balance = responseData['customer']['balance'];

      _token = responseData['token'];
      _customerModel = CustomerModel(
        id: responseData['customer']['_id'],
        email: responseData['customer']['email'],
        balance: double.parse(double.parse(balance.toString()).toStringAsFixed(2))
             
      );
      _customerModel!.addressList = [];
      if( responseData['customer']['addressList'] != null ) {
        var rawAddressList = helpers.convertListDynamicToListMap(
          responseData['customer']['addressList'] as List<dynamic>
        );
        for( int i = 0; i < rawAddressList.length; i++ ) {
          var tempAddressItem = AddressModel(
            definition: rawAddressList[i]['definition'],
            receiver: rawAddressList[i]['receiver'],
            addressString: rawAddressList[i]['addressString'],
            city: rawAddressList[i]['city'],
          );
          if( rawAddressList[i]['_id'] != null ) {
            tempAddressItem.id = rawAddressList[i]['_id'];
          }
          _customerModel!.addressList.add(tempAddressItem);
        }
        print('_customerModel.addressList.length ->');
        print(_customerModel!.addressList.length);
      }
      if( _customerModel!.addressList.length > 0 ) {
        _selectedAddressIndex = 0;
      }
      _customerModel!.specialPriceItems = [];
      if( responseData['customer']['specialPriceItems'] != null ) {
        print('responseData -> customer -> specialPriceItems ->');
        print(responseData['customer']['specialPriceItems']);
        var rawSpecialPriceItems = helpers.convertListDynamicToListMap(
          responseData['customer']['specialPriceItems'] as List<dynamic>
        );
        for( int i = 0; i < rawSpecialPriceItems.length; i++) {
          _customerModel!.specialPriceItems.add(
            SpecialPriceItemModel(
              id: rawSpecialPriceItems[i]['productId'],
              price: double.parse(
                double.parse(
                  rawSpecialPriceItems[i]['price'].toString()
                ).toStringAsFixed(2)
              )  
            )
          );
        }        
      }
      for(final name in responseData['customer'].keys) {
        // print(name);
        // print(rawItem[name]);
        
        switch (name) {
          case  'favorites':
            _customerModel!.favorites = helpers.convertDynamicToListString(responseData['customer'][name]) ;
            print('_customerModel.favorites ->');
            print(_customerModel!.favorites);
            break;
          case  'orders':
            // _customerModel.orders = helpers.convertDynamicToListString(responseData['customer'][name]);
            _customerModel!.orders = [];
            var rawOrders = helpers.convertListDynamicToListMap(responseData['customer'][name] as List<dynamic>);
            if( rawOrders.length > 0 ) {
              for( int i = 0; i < rawOrders.length; i++ ) {
                _customerModel!.orders.add(
                  rawOrders[i]['orderId'] as String
                );
              }
            }
            print('_customerModel.orders ->');
            print(_customerModel!.orders);
            break;
          default:
          print(responseData['customer'][name]);
        }
        
      }
      _orderDeliverOption = _customerModel!.addressList.length == 0 
        ? 'from-tech-store-warehouse' 
        : 'shipment-to-address';
      
      // _customerModel.favorites = responseData['customer']['favorites'];
      notifyListeners();
      print('userId ->');
      print( customerModel!.id );
      return null; 
    } catch ( err ) {
      print( 'authProvider -> signin -> Errors ->'  );
      print(err);
    }    
  }  // End of signin


  // add product to favorites
  Future<void> addRemoveProductToFavorites (String id) async {
    print('AuthProvider -> addRemoveProductToFavorites ->id ->');
    print(id);
    try {
      if ( token == null ) {   return; }
      var url = constants.apiUrl + '/api/customer/product/addToFav/$id';
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'token': token! 
        }
      );
      final responseData = json.decode( res.body ) ;
      print('responseData ->');
      print(responseData);
      _customerModel!.favorites = helpers.convertDynamicToListString(responseData['favorites']);
      notifyListeners();
    } catch (err) {
      print( 'authProvider -> addRemoveProductToFavorites -> Errors ->'  );
      print(err);
    }
  } // End of addRemoveProductToFavorites
  

  Future<void> addAddress ({
    required AddressModel addressModel
  }) async {
    try {
      if ( token == null ) {   return; }
      var url = constants.apiUrl + '/api/customer/address/add';
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'token': token!,
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'definition': addressModel.definition.trim(),
          'receiver': addressModel.receiver.trim(),
          'addressString': addressModel.addressString.trim(),
          'city': addressModel.city.trim(),
        }),
      );
      final responseData = json.decode( res.body ) ;
      print('responseData ->');
      print(responseData);
      var rawAddressList = helpers.convertListDynamicToListMap(
        responseData['addressList'] as List<dynamic>
      );
      List<AddressModel> tempAddressList = [];
      for( int i = 0; i < rawAddressList.length; i++ ) {
        var tempAddressItem = AddressModel(
          definition: rawAddressList[i]['definition'],
          receiver: rawAddressList[i]['receiver'],
          addressString: rawAddressList[i]['addressString'],
          city: rawAddressList[i]['city'],
        );
        if( rawAddressList[i]['_id'] != null ) {
          tempAddressItem.id = rawAddressList[i]['_id'];
        }
        tempAddressList.add(tempAddressItem);
      }
      _customerModel!.addressList = tempAddressList;
      if( _selectedAddressIndex == null ) {
        _selectedAddressIndex = 0;
      }
      notifyListeners();
      print( 'authProvider -> addAddress -> _customerModel.addressList.length ->'  );
      print(_customerModel!.addressList.length);
    } catch (err) {
      print( 'authProvider -> addAddress -> Errors ->'  );
      print(err);
    }
  } // End of addAddress








} // End of AuthProvider