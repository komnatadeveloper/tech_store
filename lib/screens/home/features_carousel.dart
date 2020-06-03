import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



// dummy
import '../../dummy_data.dart' as dummy;

class FeaturesCarousel extends StatefulWidget {
  final Function changeTab;
  FeaturesCarousel({
    this.changeTab
  });

  @override
  _FeaturesCarouselState createState() => _FeaturesCarouselState();
}


// -----------STATE-------------------
class _FeaturesCarouselState extends State<FeaturesCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final List<String> imgList = dummy.dummyFeaturesList;

    



    return Column(
      children: <Widget>[
        CarouselSlider(
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
          items: imgList.map((i) {
            return Builder(
              builder: (BuildContext ctx) {
                return GestureDetector(
                  onTap: () {
                    widget.changeTab(1);
                  },
                  child: Container(
                    width: screenWidth,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      // color: Colors.amber
                    ),
                    child: Image.network(
                      i,
                      fit: BoxFit.cover
                    )

                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
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