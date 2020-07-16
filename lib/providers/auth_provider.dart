import 'package:flutter/material.dart';
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

  String _token;
  String _userId;
  CustomerModel _customerModel;
  AddressModel _oneTimeAddress;
  int _selectedAddressIndex = null;
  String _orderDeliverOption; // 'from-tech-store-warehouse' || 'shipment-to-address'

  bool get isAuth {
    return _token != null;
  }
  String get token {
    return _token;
  }
  CustomerModel get customerModel {
    return _customerModel;
  }
  int get selectedAddressIndex {
    return _selectedAddressIndex ;
  }
  void setSelectedAddressIndex (int newIndex) {
    if( _customerModel.addressList.length > newIndex  ) {
      _selectedAddressIndex = newIndex;
      notifyListeners();
    }
  }
  String get orderDeliverOption {
    return _orderDeliverOption;
  }
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

  // signup
  Future<void> signup (String email, String password) async {
    const url = constants.apiUrl + '/api/customer-auth/signup';
    final res = await http.post(
      url,
      body: json.encode({
        'email': email.trim(),
        'password': password
      })
    );
    final responseData = json.decode( res.body );
    _token = responseData['token'];
    _userId = responseData['userId'];
    notifyListeners();
    print('userId ->');
    print( _userId );
  }  // End of signup


  // signin
  Future<void> signin (String email, String password) async {
    print('AuthProvider -> singin -> email, password ->');
    try {
      print( email  );
      print( password );
      const url = constants.apiUrl + '/api/customer/auth/signin';
      final res = await http.post(
        url,
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
      _customerModel.addressList = [];
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
          _customerModel.addressList.add(tempAddressItem);
        }
        print('_customerModel.addressList.length ->');
        print(_customerModel.addressList.length);
      }
      if( _customerModel.addressList.length > 0 ) {
        _selectedAddressIndex = 0;
      }

      for(final name in responseData['customer'].keys) {
        // print(name);
        // print(rawItem[name]);
        
        switch (name) {
          case  'favorites':
            _customerModel.favorites = helpers.convertDynamicToListString(responseData['customer'][name]) ;
            print('_customerModel.favorites ->');
            print(_customerModel.favorites);
            break;
          case  'orders':
            _customerModel.orders = helpers.convertDynamicToListString(responseData['customer'][name]);
            print('_customerModel.orders ->');
            print(_customerModel.orders);
            break;
          // case  'addressList':
          //   var rawAddressList = helpers.convertListDynamicToListMap(
          //     responseData['customer'][name] as List<dynamic>
          //   );
          //   for( int i = 0; i < rawAddressList.length; i++ ) {
          //     var tempAddressItem = AddressModel(
          //       definition: rawAddressList[i]['definition'],
          //       receiver: rawAddressList[i]['receiver'],
          //       addressString: rawAddressList[i]['addressString'],
          //       city: rawAddressList[i]['city'],
          //     );
          //     if( rawAddressList[i]['_id'] != null ) {
          //       tempAddressItem.id = rawAddressList[i]['_id'];
          //     }
          //     _customerModel.addressList.add(tempAddressItem);
          //   }
          //   print('_customerModel.addressList.length ->');
          //   print(_customerModel.addressList.length);
          //   break;
          
          default:
          print(responseData['customer'][name]);
        }
        
      }
      _orderDeliverOption = _customerModel.addressList.length == 0 
        ? 'from-tech-store-warehouse' 
        : 'shipment-to-address';
      
      // _customerModel.favorites = responseData['customer']['favorites'];
      notifyListeners();
      print('userId ->');
      print( customerModel.id );
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
      var url = constants.apiUrl + '/api/customer/product/addToFav/$id';
      final res = await http.post(
        url,
        headers: {
          'token': token
        }
      );
      final responseData = json.decode( res.body ) ;
      print('responseData ->');
      print(responseData);
      _customerModel.favorites = helpers.convertDynamicToListString(responseData['favorites']);
      notifyListeners();
    } catch (err) {
      print( 'authProvider -> addRemoveProductToFavorites -> Errors ->'  );
      print(err);
    }
  }

  Future<void> addAddress ({
    AddressModel addressModel
  }) async {
    try {
      var url = constants.apiUrl + '/api/customer/address/add';
      final res = await http.post(
        url,
        headers: {
          'token': token,
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
      _customerModel.addressList = tempAddressList;
      notifyListeners();
      print( 'authProvider -> addAddress -> _customerModel.addressList.length ->'  );
      print(_customerModel.addressList.length);
    } catch (err) {
      print( 'authProvider -> addAddress -> Errors ->'  );
      print(err);
    }
  } // End of addAddress








} // End of AuthProvider