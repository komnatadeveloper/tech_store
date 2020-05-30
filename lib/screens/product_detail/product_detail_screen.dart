import 'package:flutter/material.dart';
import 'package:tech_store/screens/product_detail/carousel_with_arrows.dart' as carousel;

import './technical_specifications.dart';

import '../../dummy_data.dart' as dummyData;



class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail-screen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

// ----------------------------  STATE  ---------------------------------
class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1);
  TextEditingController _quantityTextController;

  @override
  void initState() {
    // TODO: implement initState
    _quantityTextController = TextEditingController(text: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appbarBackgroundColor,
        title: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(child: Text('Product Details')),
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              )
            ],
          ),
        ), 
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20
                    ),
                    child: Text(
                      dummyData.dummySampleProductDetailsItem['brand'],
                      style: TextStyle(
                        color: Color.fromRGBO(164, 41, 48, 1)
                      ),
                    )
                  ),
                  Expanded(                    
                    child: Text(
                      dummyData.dummySampleProductDetailsItem['productNo']
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star
                    ),
                    onPressed: () {
                      print('Add to favorites');
                    },
                  )
                ],
              ), 
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom:20
                ),
                child: Text(
                  dummyData.dummySampleProductDetailsItem['keyProperties'],
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
              ), 
              carousel.CarouselWithArrows(),
              SizedBox(height: 20),
              // Stock Row
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: Row(
                        children: <Widget>[
                           SizedBox(width: 20),
                          Text(
                            'Stock Status:'
                          ),
                          SizedBox(width: 30),
                          Text(
                            dummyData.dummySampleProductDetailsItem['stockStatus'],
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Price Row
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: Row(
                        children: <Widget>[
                           SizedBox(width: 20),
                          Text(
                            'Price:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red
                            ),
                          ),
                          SizedBox(width: 30),
                          Text(
                            '\$${dummyData.dummySampleProductDetailsItem['price'].toString()}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                    ),
                    // Add To Cart Row
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                           
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: TextField(
                              controller: _quantityTextController,
                              keyboardType: TextInputType.numberWithOptions(decimal: false),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.pink[200],
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 10,
                                  backgroundColor: Colors.blue,
                                ),  
                                contentPadding: EdgeInsets.only(
                                  bottom: (35 )/2,
                                  left: 8,
                                  right: 8
                                ) 
                              ), 
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                backgroundColor: Colors.blue, 
                              ),
                            ),
                          ),
                          Expanded(
                            // This Builder is because of Scaffold doesnt exist here
                            child: Builder(
                              builder: (BuildContext ctx ) {
                                return Container(
                                  height: 35,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: RaisedButton.icon(
                                    icon: Icon(Icons.shopping_cart),
                                    label: Text('Add to Cart'),
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Scaffold.of(ctx).hideCurrentSnackBar();
                                      Scaffold.of(ctx).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Added Item to the Cart',
                                            textAlign: TextAlign.center,
                                          ),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.pink,
                                        ),
                                        
                                      );
                                    },
                                  ),
                                );
                              },
                            ) 
                          ) 
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TechnicalSpecifications(dummyData.dummySampleProductDetailsItem['specifications'])
            ],
          ),
        ),
      )
    );
  }
}