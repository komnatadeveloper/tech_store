import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
// Models
import '../../models/order_model.dart';
// Components
import './product_item.dart';

class SingleOrderScreen extends StatefulWidget {
  static const routeName = '/single-order-info';

  @override
  _SingleOrderScreenState createState() => _SingleOrderScreenState();
}

// ----------------------------  STATE  -------------------------
class _SingleOrderScreenState extends State<SingleOrderScreen> {
  final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1);
  final _rowVerticalSpace = 3.0;
  bool _isInited = false;
  OrderModel _orderModel;
  

  @override
  void didChangeDependencies() {
    if( !_isInited ) {
      print('SingleOrderScreen -> didChangeDependencies');
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      print('routeArgs ->');
      print(routeArgs);
      if(routeArgs['orderModel'] != null) {
        print('SingleOrderScreen -> didChangeDependencies -> routeArgs -> orderModel ->');
        print(routeArgs['orderModel'].toString());
        setState(() {        
          _orderModel = routeArgs['orderModel'] as OrderModel;
          _isInited = true;
        });
      }
    }
    super.didChangeDependencies();
  }

  Widget _initialLoadingWidget () {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: _appbarBackgroundColor,
        title: Text('Order Info'),
        centerTitle: true,
      ),
      body: !_isInited 
        ? _initialLoadingWidget()
        : Container(
          height: double.infinity,
          width: double.infinity,
          // color: Colors.grey[200],
          padding: EdgeInsets.only(
            top: 20,
            left: 12,
            right: 12,
            bottom: 20
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Order No:'
                    ),
                    Text(
                      _orderModel.id
                    ),
                  ],
                ),
                SizedBox(height:_rowVerticalSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[                
                    Text(
                      'Order Date:'
                    ),
                    Text(
                      // orderModel.date.toIso8601String()
                      intl.DateFormat(
                        'dd/MM/yyyy'
                      ).format(
                        _orderModel.date
                      )
                    ),
                  ],
                ),
                SizedBox(height:_rowVerticalSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[                
                    // Text(
                    //   'Order Date:'
                    // ),
                    Text(
                      // orderModel.date.toIso8601String()
                      intl.DateFormat(
                        'hh:mm'
                      ).format(
                        _orderModel.date
                      )
                    ),
                  ],
                ),
                SizedBox(height:_rowVerticalSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Order Sum:'
                    ),
                    Text(
                      '\$${_orderModel.orderTotalPrice}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top:8,
                    bottom: 12
                  ),
                  height: .8,
                  color: Colors.grey,
                ),
                ..._orderModel.items.map(
                  (orderItemModel) => ProductItem(
                    orderItemModel: orderItemModel,
                  )
                ).toList(),
                Container(
                  width: double.infinity,
                  margin : EdgeInsets.only(
                    bottom: 6
                  ),
                  child: Text(
                    'Shipment Info',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 18
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Definition'
                    ),
                    Text(
                      _orderModel.address.definition
                    ),
                  ],
                ),
                SizedBox(
                  height: 5
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Receiver'
                    ),
                    Text(
                      _orderModel.address.receiver
                    ),
                  ],
                ),
                SizedBox(
                  height: 5
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address'
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 16
                        ),
                        alignment: Alignment.topRight,
                        child: Text(
                          _orderModel.address.addressString,
                          maxLines: 4,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'City'
                    ),
                    Text(
                      _orderModel.address.city
                    ),
                  ],
                ),
                SizedBox(
                  height: 5
                ), 

              ],
            ),
          ),
        ),
      
    );
  }
}