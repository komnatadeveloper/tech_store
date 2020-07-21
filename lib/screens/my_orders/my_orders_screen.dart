import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Providers
import '../../providers/order_provider.dart';
// Components
import './order_item_widget.dart';
// Models
import '../../models/order_model.dart';


class MyOrdersScreen extends StatefulWidget {
  static const routeName = '/my-orders';
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}
//  ----------------------------  STATE  -----------------------
class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool _isInited = false;
  List<OrderModel> _orderList = [];
  final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1);
  var _dateSelectionIndex = 1;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if( !_isInited ) {
      setState(() {
        _isInited = true;
      });
      Provider.of<OrderProvider>(context).getOrders(
      date: '1month'
      ).then(( result ) {
        setState(() {
          _orderList = result;
        });
      });
    }    
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appbarBackgroundColor,
        title: Text('My Orders'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(
          // top: 25
        ),
        height: double.infinity,
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(
                bottom:12
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: 12
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Date'
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text('Today'),
                          value: 0,                            
                        ),
                        DropdownMenuItem(
                          child: Text('1 Week'),
                          value: 1,                            
                        ),
                        DropdownMenuItem(    
                          child: Text('1 Month'), 
                          value: 2,
                        ),
                        DropdownMenuItem(    
                          child: Text('3 Months'), 
                          value: 3,
                        ),
                      ],
                      value: _dateSelectionIndex,
                      onChanged: (val) {
                        setState(() {
                          _dateSelectionIndex = val;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (_orderList.length > 0) ..._orderList.map(
                      (orderModel) => OrderItemWidget(
                        orderModel: orderModel
                      )
                    ).toList()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}