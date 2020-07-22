import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Providers
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/product_provider.dart';
// Screens
import '../my_orders/my_orders_screen.dart';
import '../auth/auth_screen.dart';



class AccountScreen extends StatelessWidget {


  void _showLogoutAlert (BuildContext context) {
    showDialog(
      context: context,
      builder: ( ctx ) => AlertDialog(   
        contentPadding: EdgeInsets.zero,
        // actionsPadding: EdgeInsets.zero,   
        buttonPadding: EdgeInsets.zero,   
        titlePadding: EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: 26,
        ),                  
        title: Container(
          alignment: Alignment.center,
          // color: Colors.pink,
          child: Text(
            'Are you sure you want to Log Out?' 
          ),
        ),

        content:Container(
          // color: Colors.pink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(
                    fontSize: 21
                  ),
                ),
                textColor: Colors.blue,
                onPressed: () {
                  print('AccountScreen -> Logout Button -> AlertDialog -> No');
                  Navigator.of(ctx).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 21
                  ),
                ),
                textColor: Colors.blue,
                onPressed: () async {
                  print('AccountScreen -> Logout Button -> AlertDialog -> Yes');                  
                  // Provider.of<CartProvider>(context, listen: false).removeFromCart(
                  //   id: widget.cartItem.productModel.id
                  // );
                  Navigator.of(ctx).pop();                  
                  await Provider.of<AuthProvider>(
                    ctx,
                    listen: false
                  ).removeCredentialsFromDevice();
                  Provider.of<CartProvider>(ctx,listen:false).resetCartProvider();
                  Provider.of<ProductProvider>(ctx,listen:false).resetProductProvider();
                  Navigator.of(ctx).pushReplacementNamed(
                    AuthScreen.routeName
                  );
                },
              ),
            ],
          ),
        ), 
      )
    );
  }


  Widget _accountScreenItem (
    String title,
    Function handleTap
  ) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        color: Colors.white,
        height: 40,
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title
            ),
            Icon(
              Icons.chevron_right
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
        top: 25
      ),
      height: double.infinity,
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _showLogoutAlert(context);
              },
              child: Container(
                color: Colors.white,
                height: 40,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 8
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sign Out'
                    ),
                    Icon(
                      Icons.exit_to_app
                    )
                  ],
                ),
              ),
            ),
            _accountScreenItem(
              'My Orders',
              () {
                Navigator.of(context).pushNamed(
                  MyOrdersScreen.routeName
                );
              }
            )
          ],
        ),

      ),
    );
  }
}