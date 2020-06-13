import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../providers/cart_provider.dart';

// helpers
import '../../helpers/helpers.dart' as helpers;


// Screens
import '../product_detail/product_detail_screen.dart';
// Models
import '../../models/product.dart';
// Constants
import '../../constants/constants.dart' as constants;


class SearchProductItem  extends StatelessWidget {
  final ProductModel productModel;
  final bool isFirstItem;
  final bool isLastItem;

  SearchProductItem({
    this.productModel,
    this.isFirstItem,
    this.isLastItem
  });

  @override
  Widget build(BuildContext context) {
    return SearchProductItemStateful(
      productModel: productModel,
      isFirstItem: isFirstItem,
      isLastItem: isLastItem,
    );
  }
}

class SearchProductItemStateful extends StatefulWidget {
  final ProductModel productModel;
  final bool isFirstItem;
  final bool isLastItem;

  SearchProductItemStateful({
    this.productModel,
    this.isFirstItem,
    this.isLastItem
  });
  @override
  _SearchProductItemStatefulState createState() => _SearchProductItemStatefulState();
}


//  -------------   STATE   ----------------------
class _SearchProductItemStatefulState extends State<SearchProductItemStateful> {
  final cardHeight = 135.0;
  final rightWidth = 50.0;
  final rightPaddingAll = 8.0;
  TextEditingController _quantityTextController;

  var _cardOpacity  = 1.0;





  @override
  void initState() {
    // TODO: implement initState
    _quantityTextController = TextEditingController(text: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  
    

    return Container(
      margin: EdgeInsets.only(
        top: widget.isFirstItem ? 20 : 0,
        left: 15,
        right: 15,
        bottom: widget.isLastItem ? 30 : 20
      ),
      child: Listener(
        onPointerUp: ( _ ) {
          print('ProductItemCard ->  Listener -> onPointerUp');
          setState(() {
            _cardOpacity = 1.0;
          });
        },
        onPointerDown: ( _ ) {
          print('ProductItemCard ->  Listener -> onPointerDown');
          setState(() {
            _cardOpacity = 0.35;
          });
        },
        // absorbing: false,

      // return GestureDetector(
        // onTapDown: ( _ ) {
        //   print( 'ProductItemCard ->  GestureDetector -> onTapDown' );
        // },
        // onTapUp: ( _ ) {
        //   print( 'ProductItemCard ->  GestureDetector -> onTapUp' );
        // },
        // onTapCancel: (  ) {
        //   print( 'ProductItemCard ->  GestureDetector -> onTapCancel' );
        // },
        // onPanStart: ( _  ) {
        //   print( 'ProductItemCard ->  GestureDetector -> onPanEnd' );
        // },
        
        // onVerticalDragCancel: () {
        //   print( 'ProductItemCard ->  GestureDetector -> onVerticalDragCancel' );
        // },
        // onPanStart: ( _ ) {
        //   print( 'ProductItemCard ->  GestureDetector -> onPanStart' );
        // },

        // onLongPressStart: ( _ ) {
        //   print( 'ProductItemCard ->  GestureDetector -> onLongPressStart' );
        // },
        // onForcePressStart: ( _ ) {
        //   print( 'ProductItemCard ->  GestureDetector -> onForcePressStart' );
        // },

        child: GestureDetector(
          onTap: () {
            print( 'ProductItemCard ->  GestureDetector -> onTap' );
            Navigator.of(context).pushNamed( 
              ProductDetailScreen.routeName,
              arguments: {
                'productModel': widget.productModel
              }
            );
          },
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _cardOpacity,
            
            child: Card(
              margin: EdgeInsets.zero,
              child: Row(
                children: <Widget>[
                  // Left side - Image & Existence
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      top: 10
                    ),
                    width: 100,
                    // color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: <Widget>[
                        Image.network(
                          // 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80',
                          helpers.mainImageUrlHelper(productModel: widget.productModel),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),

                        Container(
                          height: 45,
                          alignment: Alignment.center,
                          child: Text(
                            'In Stock',
                            style: TextStyle(
                              color: Colors.green[500]
                            ),
                          ) // In Stock -OR- Out of Stock
                          ), 
                      ],
                    ),
                  ), // End of Left side - Image & Existence

                  // Center Column----------------------------------------------
                  Expanded(            
                    child: Container(
                      height: cardHeight,
                      padding: EdgeInsets.only(
                        top: 8,
                        left: 8.0
                      ),
                      // color: Colors.orange,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.productModel.brand,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[700]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 3,
                              bottom: 5
                            ),
                            child: Text(
                              widget.productModel.productNo,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700]
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.productModel.keyProperties,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                
                              ),
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                          Container(
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //     top: BorderSide(
                            //       color: Colors.grey,
                            //       width: 1.5
                            //     )
                            //   )
                            // ),
                            // color: Colors.yellow,
                            padding: EdgeInsets.only(
                              top:10,
                              bottom:10
                            ),
                            child: Text(
                              'Price: \$${widget.productModel.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red[700]
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  //Right--------------------------------------------------
                  Container(
                    width: rightWidth,            
                    height: cardHeight,
                    padding: EdgeInsets.only(
                      top: rightPaddingAll,
                      left: rightPaddingAll,
                      right: rightPaddingAll,
                      bottom: rightPaddingAll
                    ),
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: rightWidth - 2 * rightPaddingAll,
                          width: rightWidth - 2 * rightPaddingAll,
                          alignment: Alignment.center,
                          
                          child: TextField(
                            controller: _quantityTextController,
                            // keyboardType: TextInputType.numberWithOptions(decimal: true),
                            keyboardType: TextInputType.numberWithOptions(decimal: false),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 10,
                                // backgroundColor: Colors.blue,
                              ),
                              
                              
                              // contentPadding: EdgeInsets.only(
                              //   bottom: 17,
                              //   left: 5,
                              //   right: 5                        
                              // )
                              contentPadding: EdgeInsets.only(
                                bottom: (rightWidth - 2 * rightPaddingAll )/2,
                                left: 8,
                                right: 8
                              )
                              
                            ),
                            
                            
                            
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              // backgroundColor: Colors.blue,
                              
                              
                              
                            ),
                          ),
                        ),

                        Container(
                          height: rightWidth - 2 * rightPaddingAll,
                          // child: RaisedButton.icon(
                            
                          //   icon: Icon(Icons.add_shopping_cart),
                          //   label: Text(''),
                          //   padding: EdgeInsets.zero,                  
                          //   onPressed: () {},
                          // ),

                          // child: IconButton(
                          //   icon: Icon(Icons.add_shopping_cart),
                          //   onPressed: () {},
                          //   color: Colors.green,
                          // ),


                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 3
                            ),
                            child: Container(
                              // color: Colors.amberAccent,
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ), 
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              print('ProductItemCard -> CartButton -> onPressed');
                              Provider.of<CartProvider>(context, listen: false)
                                .addToCart(
                                    CartItem(
                                      productModel: widget.productModel,
                                      quantity: int.parse(_quantityTextController.text)
                                    )
                              );
                              Scaffold.of(context).hideCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(
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
                            onLongPress: () {
                              print('ProductItemCard -> CartButton -> onLongPress');
                            },
                            onHighlightChanged: ( boolValue ) {
                              print('ProductItemCard -> CartButton -> onHighlightChanged -> $boolValue');
                            },
                            
                            
                            color: Colors.green,
                          ),

                        ),

                        

                      ],
                    ),
                  )


                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}