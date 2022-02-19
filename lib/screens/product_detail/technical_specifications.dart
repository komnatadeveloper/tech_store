import 'package:flutter/material.dart';

class TechnicalSpecifications extends StatefulWidget {
  final List<Map<String, String>> _techInfo;


  TechnicalSpecifications(
    this._techInfo
  );
  @override
  _TechnicalSpecificationsState createState() => _TechnicalSpecificationsState();
}


// -----------------------------------  STATE ---------------------------------
class _TechnicalSpecificationsState extends State<TechnicalSpecifications> {

  List<Widget> _specsList =  [];


  Widget _specificationRow ( String key, String value ) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey
          )
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(key),
          Text(value),
        ],
      ),
    );
  }

  List<Widget> handleCreateList ( ) {
    List<Widget> tempList = [];
    widget._techInfo.forEach((element) {      
      for( final name in element.keys ) {
        tempList.add(
          _specificationRow( 
              name,
              element[name]!
          )        
        );
      }
    });
    return tempList;
  } 


  @override
  Widget build(BuildContext context) {

    // widget._techInfo.forEach( ( item ) {
    //   print(item.keys);
    // });


    widget._techInfo.forEach((element) {
      List<Widget> tempList = [];
      for( final name in element.keys ) {
        print(name);
        print(element[name]);

        tempList.add(
          _specificationRow( 
              name,
              element[name]!
          )        
        );
      }
    });



    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            'Specifications',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22
            ),
            textAlign: TextAlign.left,
          ),
          ...handleCreateList()
          // .toList()
        ],
      ) 
    );
  }
}