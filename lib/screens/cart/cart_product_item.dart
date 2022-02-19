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
  double cardHeight = 135.0;

  final rightWidth = 50.0;

  final rightPaddingAll = 8.0;
  var _isInited = false;

  late TextEditingController _quantityTextController;

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
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 21
                  ),
                ),
                style: TextButton.styleFrom(
                  primary:  Colors.blue,
                ),
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
      _quantityTextController.text = Provider.of<CartProvider>(context, listen: false)
        .items.firstWhere((element) => element.productModel.id == widget.cartItem.productModel.id ).quantity.toString();
    }
    print('cartProductItem -> MediaQuery.of(context).size.width ->');
    print(      
      MediaQuery.of(context).size.width
    );
    if (MediaQuery.of(context).size.width < 400 ) {
      cardHeight = 180.0;
    }

    Widget _wideSizeComponent ( ) {
      return Card(
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
                                        Expanded(
                                          child: Text(
                                            widget.cartItem.productModel.productNo,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700]
                                            ),
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
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
                                    color: Colors.grey[200]!,                                  
                                    width: 2.5
                                  )
                                ),
                                child: Row(
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(

                                        padding: EdgeInsets.all(5),
                                        primary: Colors.grey[300],
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
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
                      
                      
                    ],
                  ),
                ),
              ), 
            ],
          ),
        ),
      );
    } // End of _wideSizeComponent


    Widget _narrowSizeComponent ( ) {
      return Card(
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
                      Expanded(
                        // height: 60,
                        child: Row(  // Row no: 2
                          children: <Widget>[
                            Expanded(
                              child: Column(  // Col no: 3
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // SizedBox(
                                  //   height: 25,
                                  Container(
                                    // color: Colors.pink,
                                    child: Column(  // Row no: 4
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.cartItem.productModel.brand,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue[700]
                                          ),
                                        ),
                                        // SizedBox(width: 20),

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
                                  // ),
                                  Expanded(
                                    child: Container(
                                      height: double.infinity,
                                      // color: Colors.red,
                                      child: Text(
                                        widget.cartItem.productModel.keyProperties,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]
                                        ),
                                        maxLines: 3,
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
                      Container(
                        child: Column(  // Row no: 4 -> Changed to Column
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              // width: 110,
                              // color: Colors.pink,                              
                              margin: EdgeInsets.only(
                                right: 10,
                                bottom: 8,
                              ),
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[200]!,                                  
                                      width: 2.5
                                    ),
                                    // color: Colors.yellow
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(

                                          padding: EdgeInsets.all(5),
                                          primary: Colors.grey[300],
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
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
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(

                                          padding: EdgeInsets.all(5),
                                          primary: Colors.grey[300],
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
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
                            ),

                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 12,
                                  bottom: 6
                                ),
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

                            

                          ],
                        ),
                      ),
                      
                      
                    ],
                  ),
                ),
              ), 
            ],
          ),
        ),
      );
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
      child: MediaQuery.of(context).size.width > 400
        ? _wideSizeComponent()
        : _narrowSizeComponent()
    );
    //--------------------------------------------------------------------------------------------------------
  }
}