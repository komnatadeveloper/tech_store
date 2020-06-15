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

  bool get isAuth {
    return _token != null;
  }
  String get token {
    return _token;
  }
  CustomerModel get customerModel {
    return _customerModel;
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
          
          default:
          print(responseData['customer'][name]);
        }
        
      }
      // _customerModel.favorites = responseData['customer']['favorites'];
      notifyListeners();
      print('userId ->');
      print( customerModel.id );
    } catch ( err ) {
      print( 'authProvider -> signin -> Errors ->'  );
      print(err);
    }
    
  }  // End of signin







} // End of AuthProvider