import 'package:flutter/material.dart';
import 'package:tech_store/screens/favorites/favorite_product_item.dart';


class FavoritesScreen extends StatelessWidget {
  final bool isEmptyList = false;

  @override
  Widget build(BuildContext context) {

    if( isEmptyList ) {
      return Center(
        child: Text('You have no products in your favorite list!')
      );
    }
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8
      ),
      color: Color.fromRGBO(239, 239, 239, 1),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FavoriteProductItem(),
            FavoriteProductItem(),
            // FavoriteProductItem(),
            // FavoriteProductItem(),
            // FavoriteProductItem(),
            // FavoriteProductItem(),
            // FavoriteProductItem(),
          ],
        )
      ),
    );
  }
}