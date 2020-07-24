import 'package:flutter/material.dart';
// Models
import '../../models/order_model.dart';
// helpers
import '../../helpers/helpers.dart' as helpers;

class ProductItem extends StatelessWidget {
  final OrderItemModel orderItemModel;
  ProductItem({
    this.orderItemModel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 6
      ),
      margin: EdgeInsets.only(
        bottom: 12
      ),
      decoration: BoxDecoration(        
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.8
          ),
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80 * 0.6,
            child: Image.network(
              helpers.imageUrlHelper(
                imageId: orderItemModel.mainImageId
              )
            ),
          ),
          Expanded(
            child: Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Text(
                  //   '${orderItemModel.brand} ${orderItemModel.productNo} ${orderItemModel.keyProperties}',
                  //   maxLines: 2,
                  //   overflow: TextOverflow.clip,
                  // ),
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: orderItemModel.brand + ' ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        TextSpan(
                          text: orderItemModel.productNo + ' ',
                          style: TextStyle(
                            // fontSize: 15,
                            // fontWeight: FontWeight.bold
                            color: Colors.red
                          ),
                        ),
                        TextSpan(
                          text: orderItemModel.keyProperties,
                          style: TextStyle(
                            // fontSize: 15,
                            // fontWeight: FontWeight.bold
                            // color: Colors.red
                          ),
                        ),
                      ]
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                       '${ orderItemModel.quantity} ea.'
                      ),
                      Text(
                        '\$${orderItemModel.price}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                       
                      )
                    ],
                  )
                ],
              ),
            ),
          )
          
        ],
      ),
      
    );
  }
}