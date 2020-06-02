import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../providers/cart_provider.dart';



// Models
import './cart_product_item.dart';



class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<CartProvider>(
                  builder: ( ctx2, cartProvider, customChild ) => Column(
                  children: <Widget>[
                    // CartProductItem()
                      ...cartProvider.items.map(
                        (cartItem) => CartProductItem(
                          cartItem
                        )
                      ).toList()
                    ],
                  ),
                ) 
              )
            ),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(
                horizontal: 20
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1.8
                  )
                )
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 120,
                    // color: Colors.pink,                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: ( ctx2,  cartProvider, child ) => Text(                            
                            '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 19
                            ),
                          ),
                        ),
                        // Text('\$852.25')
                      ],
                    ),
                  ),
                  
                  Container(
                    height: 38,
                    width: 125,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )
          ],
         
        ),
      ),
    );


  }
}