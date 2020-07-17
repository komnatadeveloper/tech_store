
import 'package:flutter/foundation.dart';
// HTTP and convert
import 'package:http/http.dart' as http;
import 'dart:convert';
// constants
import '../constants/constants.dart' as constants;
// helpers
import '../helpers/helpers.dart' as helpers;
// models
import '../models/customer_model.dart';
import './cart_provider.dart';  // CartItem there will be necessary


class OrderProvider with ChangeNotifier {

  final String authToken;
  final CustomerModel customerModel;

  OrderProvider(
    // from authProvider
    this.authToken,
    this.customerModel
  );
  
  Future<Map<String, String>> payAndOrder ({
    // String type,
    List<CartItem> items,  // to be updated
    double orderTotalPrice,
    AddressModel address,
    String cardNumber,
    String cvvCode,
    String expiryDate,
    String cardHolder
  }) async {
    try {
      final url = '${constants.apiUrl}/api/customer/order/add';
      final res = await http.post(
        url,
        headers: {
          'token': authToken,
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'type': 'sell',
          'items': items.map(
            (cartItem) => {
              'productId': cartItem.productModel.id,
              'quantity': cartItem.quantity,
              'price': cartItem.productModel.price
            }
          ).toList(),
          'orderTotalPrice': orderTotalPrice,
          'address': {
            'definition': address.definition,
            'receiver': address.receiver,
            'addressString': address.addressString,
            'city': address.city
          },
          'cardNumber': cardNumber,
          'cvvCode':cvvCode,
          'expiryDate': expiryDate,
          'cardHolder': cardHolder
        })
      ); 
      final responseData = json.decode( res.body ) ;
      print('responseData ->');
      print(responseData);
      String msg = responseData['msg'] as String;
      return {
        'msg': msg
      };

    } catch ( err ) {
      print( 'orderProvider -> payAndOrder -> Errors ->'  );
      print(err);
      return {
        'msg': 'There Are Errors'
      };

    }
  } // End of payAndOrder

}