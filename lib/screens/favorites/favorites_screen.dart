import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/models/product.dart';

// Providers
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
// Widgets
import './favorite_product_item.dart';


class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}


//  ---------------------  STATE    -------------------------
class _FavoritesScreenState extends State<FavoritesScreen> {
  final bool isEmptyList = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if( !Provider.of<ProductProvider>(context).isFavoritesFetched ) {
      Provider.of<ProductProvider>(context).fetchFavoriteProducts();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    if( isEmptyList ) {
      return Center(
        child: Text('You have no products in your favorite list!')
      );
    }
    if(Provider.of<ProductProvider>(context).isLoadingFavorites) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(
        top: 8,
        // left: 8,
        // right: 8
      ),
      // color: Color.fromRGBO(239, 239, 239, 1),
      color: Colors.grey[300],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            ...Provider.of<ProductProvider>(context).favoriteProducts.map(
              (productModel) => FavoriteProductItem(productModel)
            ).toList(),
            // FavoriteProductItem(),
            // FavoriteProductItem(),
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