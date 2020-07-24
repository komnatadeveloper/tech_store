import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// dummy
import '../../dummy_data.dart' as dummy;
// Providers
import '../../providers/product_provider.dart';
// Screens
import '../product_detail/product_detail_screen.dart';
// Components
import './most_popular_product_item.dart';

class MostPopularProductsListView extends StatelessWidget {
  final Function changeTab;
  MostPopularProductsListView({
    this.changeTab   // just in case. Maybe it will be necessary
  });

  final List<String> imgList = dummy.dummyMostPopularImageList;

  @override
  Widget build(BuildContext context) {
    var _mostPopularProductsList = Provider.of<ProductProvider>(context).mostPopularProductsList;
    return Container(
      height: 120,
      width: double.infinity,
      child: ListView.builder(        
        itemBuilder: (_, index) => MostPopularProductItem(
          productModel: _mostPopularProductsList[index],
        ),
        itemCount: _mostPopularProductsList.length,
        scrollDirection: Axis.horizontal,
      )
    );
  }
}