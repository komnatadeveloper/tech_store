import 'package:flutter/material.dart';

import './product_item_card.dart';


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container (
      height: double.infinity,
      color: Colors.grey[400],
      // padding: EdgeInsets.only(
      //   top: 80,
      //   bottom:80
      // ),
      
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
            ProductItemCard(),
          ],
        ),
      ),
    );
  }
}