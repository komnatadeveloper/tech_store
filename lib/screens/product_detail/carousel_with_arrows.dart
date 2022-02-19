import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../dummy_data.dart' as dummyData;

class CarouselWithArrows extends StatefulWidget {
  final List<String> imageList;
  CarouselWithArrows({
    required this.imageList
  });
  @override
  _CarouselWithArrowsState createState() => _CarouselWithArrowsState();
}


// -----------STATE-------------------
class _CarouselWithArrowsState extends State<CarouselWithArrows> {
  int _current = 0;
  // List<String> imgList;
  final double ARROW_ICON_SIZE = 18.0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    // imgList = dummyData.dummySampleProductDetailsItem['imageUrlList'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;


    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
               child: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                ),                
                iconSize: ARROW_ICON_SIZE,
                onPressed: () {
                  buttonCarouselController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear
                  );
                },
              ),
            ),
            Expanded(
              child: CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
                ),
                items: widget.imageList.map((i) {
                  return Builder(
                    builder: (BuildContext ctx) {
                      return Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                        ),
                        child: Image.network(
                          i,
                          fit: BoxFit.cover
                        )

                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
               child: IconButton(
                icon: Icon(
                  Icons.chevron_right,
                ),                
                iconSize: ARROW_ICON_SIZE,
                onPressed: () {
                  buttonCarouselController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear
                  );
                },
              ),
            ),
          ],
           
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imageList.map((url) {
            int index = widget.imageList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
      
    );
  }
}

