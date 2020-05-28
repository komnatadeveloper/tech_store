import 'package:flutter/material.dart';

class FavoriteProductItem  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FavoriteProductItemStateful(
      
    );
  }
}

class FavoriteProductItemStateful extends StatefulWidget {
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
    

    return Card(
      margin: EdgeInsets.only(
        bottom: 12
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
                    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80',
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
                      'ProductBrand',
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
                        'ProductCode',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700]
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'CI7-8700 3.20 Ghz 16GB 240GB SSD Free Dos Mini PC',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700]
                        ),
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
                        'Price: \$725.85',
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
                        fillColor: Colors.pink[200],
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 10,
                          backgroundColor: Colors.blue,
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
                        backgroundColor: Colors.blue,  
                      ),
                    ),
                  ),

                  // Right Center
                  Container(
                    height: rightWidth - 2 * rightPaddingAll,
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                        // color: Colors.amberAccent,
                        child: Icon(
                          Icons.shopping_cart,
                            color: Colors.white,
                          ),                        
                        ),
                      onPressed: () {},
                      color: Colors.green,
                    ),
                  ),

                  // Right Bottom
                  Container(
                    height: rightWidth - 2 * rightPaddingAll,
                    child: RaisedButton(
                      onPressed: () {},
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
    );
  }
}