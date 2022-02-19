import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../providers/category_provider.dart';
import '../../providers/product_provider.dart';

// Helpers
import '../../helpers/helpers.dart' as helper;

// Models
import 'package:tech_store/models/product.dart';

// Components
import './features_carousel.dart';
import './special_for_you_item.dart';
import './product_groups_card.dart';
import './most_popular_products_carousel.dart';
import './most_popular_products_listview.dart';



class HomeScreen extends StatefulWidget {
  final Function changeTab;
  HomeScreen({
    required this.changeTab
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// -----------------------  STATE  --------------------
class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> _specialProductsList = [];

  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<ProductProvider>(context).getProductsByIdList(
    //   idList: Provider.of<ProductProvider>(context).customerModel.specialPriceItems.map(
    //     (item) => item.id
    //   )
    // ).then( 
    //     (value) {         
    //       _specialProductsList = value;
    //     }
    // );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsetsDirectional.only(bottom: 20, top: 20),
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            // Text('HomeScreen'),
            FeaturesCarousel(
              changeTab: widget.changeTab,
            ),
            // SpecialForYouItem(),
            // SpecialForYouItem(),
            if ( Provider.of<ProductProvider>(context).specialPriceItems.length > 0 
            ) ...Provider.of<ProductProvider>(context).specialPriceItems.map(
              (specialPriceItem) => SpecialForYouItem(
                specialPriceItem
              )
            ).toList(),


            // Most Popular Title
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              // color: Colors.pink,
              child: Text(
                'Most Popular',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              )
            ),

            // MostPopularProductsCarousel(),
            MostPopularProductsListView(
              changeTab: widget.changeTab,
            ),

            // Picture Below will be Discounts Picture
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 20),
            //   child: GestureDetector(
            //     onTap: ( ) {
            //       widget.changeTab(1);
            //     },
            //     child: Image.network(
            //       'https://gloimg.gbtcdn.com/soa/gb/pdm-provider-img/straight-product-img/20180914/T017597/T0175970025/source-img/160240-3829.jpg',
            //       width: double.infinity,
            //       height: 200,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            // Picture Below will be Discounts Picture
            ...Provider.of<CategoryProvider>(context).specialCategoryOnHomePageList.map(
              (specialCategoryItem) => Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: ( ) {
                    widget.changeTab(1);
                    Provider.of<ProductProvider>(
                      context,
                      listen: false
                    ).getProductsByCategory(
                      categoryId: specialCategoryItem.id
                    );
                  },
                  child: Image.network(
                    helper.imageUrlHelper(imageId: specialCategoryItem.imageId),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ).toList(),
            

            ProductGroupsCard(
              changeTab: widget.changeTab,
              mainCategoryList: Provider.of<CategoryProvider>(context).mainCategoryList,
            )

          ],
          // child: Text('HomeScreen'),
        ),
      ),
    );
  }
}