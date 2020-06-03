import 'package:flutter/material.dart';

// Screens
import '../product_detail/product_detail_screen.dart';

class MostPopularProductItem extends StatefulWidget {
  final String imageUrl;
  MostPopularProductItem({
    this.imageUrl
  });
  @override
  _MostPopularProductItemState createState() => _MostPopularProductItemState();
}

// --------------------------------- STATE ---------------------------------
class _MostPopularProductItemState extends State<MostPopularProductItem> {
  var _cardOpacity  = 1.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Listener(
        onPointerUp: ( _ ) {
          print('MostPopularProductItem ->  Listener -> onPointerUp');
          setState(() {
            _cardOpacity = 1.0;
          });
        },
        onPointerDown: ( _ ) {
          print('MostPopularProductItem ->  Listener -> onPointerDown');
          setState(() {
            _cardOpacity = 0.35;
          });
        },
        child: GestureDetector(
          // padding: const EdgeInsets.all(8.0),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName
            );
          },
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _cardOpacity,
            child: Container(
              alignment: Alignment.center,
              width: 180,
              color: Colors.white,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,                
              ),
            ),
          ),
        ),
      ),
    );
  }
}