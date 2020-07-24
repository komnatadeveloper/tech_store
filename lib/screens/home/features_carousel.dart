import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/providers/product_provider.dart';
// Models
import '../../models/feature_model.dart';
// Providers
import '../../providers/category_provider.dart';
// helpers
import '../../helpers/helpers.dart' as helpers;




// dummy
import '../../dummy_data.dart' as dummy;

class FeaturesCarousel extends StatefulWidget {
  final Function changeTab;
  // final  FeatureModel featureList;

  FeaturesCarousel({
    this.changeTab,
    // this.featureList
  });

  @override
  _FeaturesCarouselState createState() => _FeaturesCarouselState();
}


// -----------STATE-------------------
class _FeaturesCarouselState extends State<FeaturesCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    var _featureList = Provider.of<CategoryProvider>(context).featureList;

    final List<String> imgList = dummy.dummyFeaturesList;

    



    return Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            // height: 200.0,
            height: MediaQuery.of(context).size.width * (3 / 5),
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
          items: _featureList.map((i) {
            return Builder(
              builder: (BuildContext ctx) {
                return GestureDetector(
                  onTap: () {
                    Provider.of<ProductProvider>(
                      context,
                      listen: false
                    ).getProducts(
                      categoryId: i.categoryId == null ? '' : i.categoryId,
                      productId: i.productId == null ? '' : i.productId,
                      brand: i.brand == null ? '' : i.brand,
                    );
                    widget.changeTab(1);
                  },
                  child: Container(
                    width: screenWidth,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      // color: Colors.amber
                    ),
                    child: Image.network(
                      helpers.imageUrlHelper( imageId: i.imageId),
                      fit: BoxFit.cover
                    )

                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _featureList.map((featureItem) {
            int index = _featureList.indexWhere(
              (element) => element.imageId == featureItem.imageId
            );
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
      
    );
  }
}