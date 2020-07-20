import 'package:flutter/material.dart';
// Models
import '../../models/order_model.dart';

class OrderItemWidget extends StatelessWidget {
  final _rowVerticalSpace = 3.0;
  final OrderModel orderModel;
  OrderItemWidget({
    this.orderModel
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Order No:'
                  ),
                  Text(
                    orderModel.id
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
                    orderModel.date.toIso8601String()
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
                    '\$${orderModel.orderTotalPrice}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top:8
                ),
                height: .8,
                color: Colors.grey,
              ),
              FlatButton(
                padding: EdgeInsets.zero,           
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'See Order Details',
                      style: TextStyle(
                        color: Colors.cyan
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),

                onPressed: () {},

              )

            ],
          ),
        ),
      ),
    );
  }
}