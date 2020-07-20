import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Providers
import '../../providers/cart_provider.dart';
// Screens
import '../product_detail/product_detail_screen.dart';
// helpers
import '../../helpers/helpers.dart' as helpers;

class CartProductItem extends StatefulWidget {
  final CartItem cartItem;


  CartProductItem(
    this.cartItem
  );

  @override
  _CartProductItemState createState() => _CartProductItemState();
}


//  ------------------------------------------ STATE  --------------
class _CartProductItemState extends State<CartProductItem> {
  final cardHeight = 135.0;

  final rightWidth = 50.0;

  final rightPaddingAll = 8.0;
  var _isInited = false;

  TextEditingController _quantityTextController;

  @override
  void initState() {
    // TODO: implement initState
    
    _quantityTextController = TextEditingController(
      text: widget.cartItem.quantity.toString()
    ); 
    _isInited = true;
    super.initState();
  }

  //--------------------------------------------------------------------------
  void _showRemoveAlert (BuildContext context) {
    showDialog(
      context: context,
      builder: ( ctx ) => AlertDialog(   
        contentPadding: EdgeInsets.zero,
        // actionsPadding: EdgeInsets.zero,   
        buttonPadding: EdgeInsets.zero,   
        titlePadding: EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: 26,
        ),                  
        title: Container(
          alignment: Alignment.center,
          // color: Colors.pink,
          child: Text(
            'Are you sure you want to remove from Cart?' 
          ),
        ),

        content:Container(
          // color: Colors.pink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(
                    fontSize: 21
                  ),
                ),
                textColor: Colors.blue,
                onPressed: () {
                  print('CartProductItem -> Remove Button -> AlertDialog -> No');
                  Navigator.of(ctx).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 21
                  ),
                ),
                textColor: Colors.blue,
                onPressed: () {
                  print('CartProductItem -> Remove Button -> AlertDialog -> Yes');
                  Provider.of<CartProvider>(context, listen: false).removeFromCart(
                    id: widget.cartItem.productModel.id
                  );
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        ), 
      )
    );
  }
  //--------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if( _isInited ) {
      _quantityTextController.text = Provider.of<CartProvider>(context)
        .items.firstWhere((element) => element.productModel.id == widget.cartItem.productModel.id ).quantity.toString();
    }
    
    //--------------------------------------------------------------------------------------------------------
    return GestureDetector(
      onTap: () {
        print( 'CartProductItem ->  GestureDetector -> onTap' );
        Navigator.of(context).pushNamed( 
          ProductDetailScreen.routeName,
          arguments: {
            'productModel': widget.cartItem.productModel
          }
        );
      },
      child: Card(
        margin: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12,
        ),
        color: Colors.white,
        // elevation: 4,
        
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5
              )
            )
          ),
          padding: EdgeInsets.only(
            top:10
          ),
          child: Row(
            children: <Widget>[
              // Left side - Image & Existence
              Container(            
                padding: EdgeInsets.only(
                  left: 10,
                  top: 8
                ),
                width: 100,
                height: cardHeight,
                alignment: Alignment.topLeft,
                // color: Colors.pink,
                child:  Image.network(
                  // widget.cartItem.imageUrl,
                  helpers.mainImageUrlHelper(
                    productModel: widget.cartItem.productModel
                  ),
                  
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ), // End of Left side - Image & Existence

              // Right Column----------------------------------------------
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: cardHeight,
                  padding: EdgeInsets.only(
                    top: 0,
                    left: 8.0
                  ),
                  // color: Colors.orange,
                  child: Column(   // Column no:1
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Right Column 1st Row
                      Container(
                        height: 60,
                        child: Row(  // Row no: 2
                          children: <Widget>[
                            Expanded(
                              child: Column(  // Col no: 3
                                children: <Widget>[
                                  SizedBox(
                                    height: 25,
                                    child: Row(  // Row no: 4
                                      children: <Widget>[
                                        Text(
                                          widget.cartItem.productModel.brand,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue[700]
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          widget.cartItem.productModel.productNo,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700]
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.cartItem.productModel.keyProperties,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 60,
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showRemoveAlert(context);
                                },
                              ),
                            )
                            
                          ],
                        )  
                      ),

                      //--------------------------------------------------
                      Expanded(
                        child: Row(  // Row no: 4
                          children: <Widget>[

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(  // col No: 5
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(  // Row no: 6
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[                                    
                                        Text(
                                          'Unit Price:',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.red[700]
                                          ),
                                        ),
                                        Text(
                                          '\$${widget.cartItem.productModel.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red[700]
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(  // Row no: 7
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[                                    
                                        Text(
                                          'Total Price:',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.red[700]
                                          ),
                                        ),
                                        Text(
                                          // '\$725.85',
                                          '\$${(widget.cartItem.productModel.price * widget.cartItem.quantity).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red[700]
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              // width: 110,
                              // color: Colors.pink,
                              margin: EdgeInsets.only(
                                right: 10
                              ),
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[200],                                  
                                    width: 2.5
                                  )
                                ),
                                child: Row(
                                  children: <Widget>[
                                    RaisedButton(
                                      padding: EdgeInsets.all(5),
                                      color: Colors.grey[300],
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      child: Icon(Icons.remove),
                                      onPressed: () {
                                        if( widget.cartItem.quantity == 1 ) {
                                          _showRemoveAlert(context);
                                        } else {
                                          Provider.of<CartProvider>(context, listen: false)
                                            .changeItemQuantity(
                                              id: widget.cartItem.productModel.id,
                                              newQuantity: widget.cartItem.quantity-1
                                          );
                                        }
                                      },
                                    ),
                                    Container(
                                      width: 30,
                                      height: 34,
                                      color: Colors.white,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            bottom:17
                                          )
                                        ),
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number, 
                                        controller: _quantityTextController,
                                        onSubmitted: ( val ) {
                                            Provider.of<CartProvider>(context, listen: false)
                                            .changeItemQuantity(
                                              id: widget.cartItem.productModel.id,
                                              newQuantity: int.parse( val )
                                          );
                                        },                                
                                      )
                                    ),
                                    RaisedButton(
                                      padding: EdgeInsets.all(5),
                                      color: Colors.grey[300],
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      child: Icon(Icons.add),
                                      onPressed: () {
                                        Provider.of<CartProvider>(context, listen: false)
                                          .changeItemQuantity(
                                            id: widget.cartItem.productModel.id,
                                            newQuantity: widget.cartItem.quantity+1
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      // Text(
                      //   'Price: \$725.85',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     color: Colors.red[700]
                      //   ),
                      // ),
                      //--------------------------------------------------
                      
                    ],
                  ),
                ),
              ),
              

              //Right--------------------------------------------------
              // Container(
              //   width: rightWidth,            
              //   height: cardHeight,
              //   padding: EdgeInsets.only(
              //     top: rightPaddingAll,
              //     left: rightPaddingAll,
              //     right: rightPaddingAll,
              //     bottom: rightPaddingAll
              //   ),
              //   // color: Colors.blue,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       // Right Top
              //       Container(
              //         height: rightWidth - 2 * rightPaddingAll,
              //         width: rightWidth - 2 * rightPaddingAll,
              //         alignment: Alignment.center,
                      
              //         child: TextField(
              //           controller: _quantityTextController,
              //           // keyboardType: TextInputType.numberWithOptions(decimal: true),
              //           keyboardType: TextInputType.numberWithOptions(decimal: false),
              //           decoration: InputDecoration(
              //             filled: true,
              //             fillColor: Colors.pink[200],
              //             border: InputBorder.none,
              //             hintStyle: TextStyle(
              //               fontSize: 10,
              //               backgroundColor: Colors.blue,
              //             ),                      
              //             contentPadding: EdgeInsets.only(
              //               bottom: (rightWidth - 2 * rightPaddingAll )/2,
              //               left: 8,
              //               right: 8
              //             )
                          
              //           ),  
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             fontSize: 10,
              //             backgroundColor: Colors.blue,  
              //           ),
              //         ),
              //       ),

              //       // Right Center
              //       Container(
              //         height: rightWidth - 2 * rightPaddingAll,
              //         child: RaisedButton(
              //           padding: EdgeInsets.zero,
              //           child: Container(
              //             // color: Colors.amberAccent,
              //             child: Icon(
              //               Icons.shopping_cart,
              //                 color: Colors.white,
              //               ),                        
              //             ),
              //           color: Colors.green,
              //           onPressed: () {
              //             Scaffold.of(context).hideCurrentSnackBar();
              //             Scaffold.of(context).showSnackBar(
              //               SnackBar(
              //                 content: Text(
              //                   'Added Item to the Cart',
              //                   textAlign: TextAlign.center,
              //                 ),
              //                 duration: Duration(seconds: 2),
              //                 backgroundColor: Colors.pink,
              //               ),
                            
              //             );
              //           },
              //         ),
              //       ),

              //       // Right Bottom
              //       Container(
              //         height: rightWidth - 2 * rightPaddingAll,
              //         child: RaisedButton(
              //           onPressed: () {
              //             showDialog(
              //               context: context,
              //               builder: ( ctx ) => AlertDialog(   
              //                 contentPadding: EdgeInsets.zero,
              //                 // actionsPadding: EdgeInsets.zero,   
              //                 buttonPadding: EdgeInsets.zero,   
              //                 titlePadding: EdgeInsets.only(
              //                   top: 20,
              //                   left: 15,
              //                   right: 15,
              //                   bottom: 26,
              //                 ),                  
              //                 title: Container(
              //                   alignment: Alignment.center,
              //                   // color: Colors.pink,
              //                   child: Text(
              //                     'Are you sure you want to remove  from favorites?' 
              //                   ),
              //                 ),

              //                 content:Container(
              //                   // color: Colors.pink,
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                     children: <Widget>[
              //                       FlatButton(
              //                         child: Text(
              //                           'No',
              //                           style: TextStyle(
              //                             fontSize: 21
              //                           ),
              //                         ),
              //                         textColor: Colors.blue,
              //                         onPressed: () {
              //                           print('FavoriteProductItem -> Remove Button -> AlertDialog -> No');
              //                           Navigator.of(ctx).pop();
              //                         },
              //                       ),
              //                       FlatButton(
              //                         child: Text(
              //                           'Yes',
              //                           style: TextStyle(
              //                             fontSize: 21
              //                           ),
              //                         ),
              //                         textColor: Colors.blue,
              //                         onPressed: () {
              //                           print('FavoriteProductItem -> Remove Button -> AlertDialog -> Yes');
              //                           Navigator.of(ctx).pop();
              //                         },
              //                       ),
              //                     ],
              //                   ),
              //                 ), 
              //               )
              //             );
              //           },
              //           color: Colors.red,
              //           padding: EdgeInsets.zero,
              //           child: Icon(
              //             Icons.delete,
              //               color: Colors.white,
              //               size: 28,
              //           ),  
              //         ),
              //       ),

                    

              //     ],
              //   ),
              // )


              
            ],
          ),
        ),
      ),
    );
    //--------------------------------------------------------------------------------------------------------
  }
}