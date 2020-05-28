import 'package:flutter/material.dart';

import './features_carousel.dart';
import './special_for_you_item.dart';
import './most_popular_products_carousel.dart';
import './product_groups_card.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsetsDirectional.only(bottom: 20, top: 20),
        color: Color.fromRGBO(239, 239, 239, 1),
        child: Column(
          children: <Widget>[
            // Text('HomeScreen'),
            FeaturesCarousel(),
            SpecialForYouItem(),
            SpecialForYouItem(),

            // Most Popular Title
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              color: Colors.pink,
              child: Text(
                'Most Popular',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              )
            ),

            MostPopularProductsCarousel(),

            // Picture Below will be Discounts Picture
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Image.network(
                'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            ProductGroupsCard()

          ],
          // child: Text('HomeScreen'),
        ),
      ),
    );
  }
}