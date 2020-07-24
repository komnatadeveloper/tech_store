import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/providers/product_provider.dart';
// Dummy Data
import '../../dummy_data.dart' as dummyData;
// helpers
import '../../helpers/helpers.dart' as helpers;
// Providers
import '../../providers/cart_provider.dart';
import '../../providers/auth_provider.dart';
// Models
import '../../models/product.dart';
// Screens
import '../cart/cart_screen.dart';
// Components
import './carousel_with_arrows.dart' as carousel;
import './technical_specifications.dart';
import '../../components/badge.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail-screen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

// ----------------------------  STATE  ---------------------------------
class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1);
  TextEditingController _quantityTextController;
  ProductModel _productModel;

  @override
  void initState() {
    _quantityTextController = TextEditingController(text: '1');
    // TODO: implement initState
    super.initState();

  }

  @override
  void didChangeDependencies() {
    print('ProductDetailScreen -> initState');
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print('routeArgs ->');
    print(routeArgs);
    if(routeArgs['productModel'] != null) {
      print('ProductDetailScreen -> initState -> routeArgs -> productModel ->');
      print(routeArgs['productModel'].toString());
      _productModel = routeArgs['productModel'] as ProductModel;
    }
    super.didChangeDependencies();
  }



  

  Widget _goToCartButton ( BuildContext context ) {
    return IconButton(
      icon: Icon(
        Icons.shopping_cart,
        size: 24,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(
          CartScreen.routeName
        );
      },
    );
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
              Consumer<CartProvider>(
                builder: (_, cartProvider, customChild) => cartProvider.items.length > 0
                  ? Badge(
                    child: customChild,
                    value: cartProvider.items.length.toString(),
                  )
                : _goToCartButton( context ),
                child: _goToCartButton( context ),
              ), 
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
                      // dummyData.dummySampleProductDetailsItem['brand'],
                      _productModel.brand,
                      style: TextStyle(
                        color: Color.fromRGBO(164, 41, 48, 1)
                      ),
                    )
                  ),
                  Expanded(                    
                    child: Text(
                      // dummyData.dummySampleProductDetailsItem['productNo']
                      _productModel.productNo
                    ),
                  ),
                  Consumer<AuthProvider> (
                    builder: (ctx, authProvider, child ) => IconButton(
                      icon: Icon(
                        Icons.star,
                        color: authProvider.customerModel.favorites.indexOf(_productModel.id) >= 0 
                          ? Colors.blue
                          : Colors.black,
                      ),
                      onPressed: () async {
                        print('Add to favorites');
                        await Provider.of<AuthProvider>(context).addRemoveProductToFavorites(
                          _productModel.id
                        );
                        Provider.of<ProductProvider>(context,listen: false).compareFavoriteListWithCustomerModel();

                      },
                    ),

                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.star
                  //   ),
                  //   onPressed: () {
                  //     print('Add to favorites');
                  //     Provider.of<AuthProvider>(context).addRemoveProductToFavorites(
                  //       _productModel.id
                  //     );

                  //   },
                  // )
                ],
              ), 
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom:20
                ),
                child: Text(
                  // dummyData.dummySampleProductDetailsItem['keyProperties'],
                  _productModel.keyProperties,
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
              ), 
              carousel.CarouselWithArrows(
                imageList: List.generate(_productModel.imageList.length, (index) => helpers.imageUrlHelper(
                  imageId: _productModel.imageList[index].imageId
                )),
              ),
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
                            // dummyData.dummySampleProductDetailsItem['stockStatus'],
                            _productModel.stockStatus.stockQuantity.toString(),
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
                            // '\$${dummyData.dummySampleProductDetailsItem['price'].toString()}',
                            '\$${_productModel.price.toStringAsFixed(2)}',
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
                                fillColor: Colors.grey[300],
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  // backgroundColor: Colors.blue,
                                ),  
                                contentPadding: EdgeInsets.only(
                                  bottom: (35 )/2,
                                  left: 8,
                                  right: 8
                                ) 
                              ), 
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                // backgroundColor: Colors.blue, 
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
                                      Provider.of<CartProvider>(context, listen: false).addToCart(
                                        CartItem(
                                          productModel: _productModel,
                                          quantity: int.parse(_quantityTextController.text),
                                          
                                          
                                        )
                                      );
                                      Scaffold.of(ctx).hideCurrentSnackBar();
                                      Scaffold.of(ctx).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Added Item to the Cart',
                                            textAlign: TextAlign.center,
                                          ),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.orange,
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
              // TechnicalSpecifications(dummyData.dummySampleProductDetailsItem['specifications'])
              TechnicalSpecifications(
                List.generate(_productModel.specifications.length, (index) => 
                  {
                    _productModel.specifications[index].key : _productModel.specifications[index].value
                  }
                )
              )
            ],
          ),
        ),
      )
    );
  }
}