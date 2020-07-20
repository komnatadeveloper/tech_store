import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/providers/auth_provider.dart';
import 'package:tech_store/providers/product_provider.dart';
// Models
import '../../models/product.dart';
//Providers
import '../../providers/cart_provider.dart';
import '../../providers/cart_provider.dart';
// helpers
import '../../helpers/helpers.dart' as helpers;
// Screens
import '../product_detail/product_detail_screen.dart';


class FavoriteProductItem  extends StatelessWidget {
  final ProductModel productModel;
  FavoriteProductItem(
    this.productModel
  );
  @override
  Widget build(BuildContext context) {
    return FavoriteProductItemStateful(
      productModel
    );
  }
}

class FavoriteProductItemStateful extends StatefulWidget {
  final ProductModel productModel;
  FavoriteProductItemStateful(
    this.productModel
  );
  @override
  _FavoriteProductItemStatefulState createState() => _FavoriteProductItemStatefulState();
}


//  -------------   STATE   ----------------------
class _FavoriteProductItemStatefulState extends State<FavoriteProductItemStateful> {
  final cardHeight = 135.0;
  final rightWidth = 50.0;
  final rightPaddingAll = 8.0;
  TextEditingController _quantityTextController;

  @override
  void initState() {
    // TODO: implement initState
    _quantityTextController = TextEditingController(text: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return GestureDetector(
      onTap: () {
        print( 'ProductItemCard ->  GestureDetector -> onTap' );
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: {
            'productModel': widget.productModel
          }
        );
      },
      child: Card(
        margin: EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 20
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
                      helpers.mainImageUrlHelper( productModel: widget.productModel ),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),

                    Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Text(
                        // In Stock,
                        widget.productModel.stockStatus.stockQuantity.toString(),
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
                            color: Colors.grey[700]
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
                        padding: EdgeInsetsDirectional.only(
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
                    // Right Top
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

                    // Right Center
                    Container(
                      height: rightWidth - 2 * rightPaddingAll,
                      width: rightWidth - 2 * rightPaddingAll,
                      child: RaisedButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          // color: Colors.amberAccent,
                          child: Icon(
                            Icons.shopping_cart,
                              color: Colors.white,
                            ),                        
                          ),
                        color: Colors.green,
                        onPressed: () {
                          // Provider
                          //   .of<CartProvider>(context, listen: false)
                          //   .addToCart(
                          //     CartItem(
                          //       brand: widget.productModel.brand,
                          //           id: widget.productModel.id,
                          //           productNo: widget.productModel.productNo,
                          //           imageUrl: widget.productModel.imageUrl,
                          //           keyProperties: widget.productModel.keyProperties,
                          //           price: widget.productModel.price,
                          //           quantity: int.parse(_quantityTextController.text)
                          //     )
                          // );
                          Provider.of<CartProvider>(context).addToCart(
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
                      ),
                    ),

                    // Right Bottom
                    Container(
                      height: rightWidth - 2 * rightPaddingAll,
                      child: RaisedButton(
                        onPressed: () {
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
                                  'Are you sure you want to remove  from favorites?' 
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
                                        print('FavoriteProductItem -> Remove Button -> AlertDialog -> No');
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
                                      onPressed: () async {
                                        print('FavoriteProductItem -> Remove Button -> AlertDialog -> Yes');
                                        await Provider.of<AuthProvider>(context, listen: false).addRemoveProductToFavorites(widget.productModel.id);
                                        Provider.of<ProductProvider>(context, listen: false).compareFavoriteListWithCustomerModel();
                                        Navigator.of(ctx).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ), 
                            )
                          );
                        },
                        color: Colors.red,
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.delete,
                            color: Colors.white,
                            size: 28,
                        ),  
                      ),
                    ),

                    

                  ],
                ),
              )


              
            ],
          ),
        ),
      ),
    );
  }
}