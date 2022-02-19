import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../providers/product_provider.dart';


class ProductGroupItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final Function changeTab;
  final String categoryId;

  ProductGroupItem({
    required this.imageUrl,
    required this.title,
    required this.changeTab,
    required this.categoryId,
  });

  @override
  _ProductGroupItemState createState() => _ProductGroupItemState();
}

//  -----------------------  STATE   --------------------------
class _ProductGroupItemState extends State<ProductGroupItem> {
  var _cardOpacity  = 1.0;

  // Flexible(
  //           fit: FlexFit.tight,

  //           child: 

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Listener(
        onPointerUp: ( _ ) {
          print('HomeScreen -> ProductGroupItem ->  Listener -> onPointerUp');
          setState(() {
            _cardOpacity = 1.0;
          });
        },
        onPointerDown: ( _ ) {
          print('HomeScreen -> ProductGroupItem ->  Listener -> onPointerDown');
          setState(() {
            _cardOpacity = 0.35;
          });
        },
        child: GestureDetector(
          onTap: () {
            print( 'HomeScreen -> ProductGroupItem ->  GestureDetector -> onTap' );
            Provider.of<ProductProvider>(context, listen: false).getProductsByCategory(
              categoryId: widget.categoryId
            );
            widget.changeTab(1);  // this 1 is index of Search in HomeScreen
          },
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _cardOpacity,
            child: Container(
              color: Colors.grey[300],

              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(
                vertical: 8
              ),

              child: Column(
                children: <Widget>[

                  // Image
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.imageUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  // Text Row
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                  )

                ],
              ),
              
            )

          ),
        ),
      ),
    );
  }
}