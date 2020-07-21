
import 'package:flutter/foundation.dart';
import 'package:jiffy/jiffy.dart' as jiffy;
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
import '../models/order_model.dart' as order;
import '../models/address_model.dart' as address;



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
      final responseData = json.decode( res.body );
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


  Future<List<order.OrderModel>>  getOrders ({
    String date
  }) async {
    print('orderProvider -> getOrders FIRED');
    try {
      final url = '${constants.apiUrl}/api/customer/order/get?date=$date';
      final res = await http.get(
        url,
        headers: {
          'token': authToken,
          'Content-Type': 'application/json'
        },
      ); 
      final responseData = json.decode( res.body );
      print('responseData ->');
      print(responseData);
      return handleConvertResponseToOrderList(
        responseData
      );        
    } catch ( err ) {
      print( 'orderProvider -> getOrders -> Errors ->'  );
      print(err);
      return [];
    }
  } // End of getOrders


  List<order.OrderModel>  handleConvertResponseToOrderList (
    dynamic responseData
  ) {
    var rawResponseData = helpers.convertListDynamicToListMap(
      responseData as List<dynamic>
    );
    List<order.OrderModel> tempList = [];
    for( int i = 0; i < rawResponseData.length; i++ ) {
      var tempAddress = address.AddressModel(
        definition: rawResponseData[i]['address']['definition'],
        receiver: rawResponseData[i]['address']['receiver'],
        addressString: rawResponseData[i]['address']['addressString'],
        city: rawResponseData[i]['address']['city'],
      );
      var tempRawItems = helpers.convertListDynamicToListMap(
        rawResponseData[i]['items'] as List<dynamic>
      );
      List<order.OrderItemModel>  tempItems = [];
      for( int j = 0; j < tempRawItems.length; j++ ) {
        tempItems.add(
          order.OrderItemModel(
            productId: tempRawItems[j]['productId'],
            brand: tempRawItems[j]['brand'],
            productNo: tempRawItems[j]['productNo'],
            keyProperties: tempRawItems[j]['keyProperties'],
            mainImageId: tempRawItems[j]['mainImageId'],
            price:  double.parse(
              double.parse(
                tempRawItems[j]['price'].toString()
              ).toStringAsFixed(2) 
            ),
            quantity: tempRawItems[j]['quantity'],
          )
        );
      }
      tempList.add(
        order.OrderModel(
          id: rawResponseData[i]['_id'],
          address: tempAddress,
          customerId: rawResponseData[i]['customerId'],
          // date: DateTime.now(), // to be Updated
          date: jiffy.Jiffy(
            rawResponseData[i]['date'] as String,
            // 'dd MMM yyyy hh:mm:ss'
          ).dateTime,          
          items: tempItems,
          orderTotalPrice: double.parse(
            double.parse(
              rawResponseData[i]['orderTotalPrice'].toString()
            ).toStringAsFixed(2) 
          ),
        )
      );
    }
    return [ ...tempList ];
  } // End of handleConvertResponseToOrderList

}