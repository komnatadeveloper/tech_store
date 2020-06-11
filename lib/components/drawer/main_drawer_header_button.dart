import 'package:flutter/material.dart';

// Models
import '../../models/drawer_menu_item.dart';
import '../../models/category_model.dart';


class MainDrawerHeaderButton extends StatelessWidget {
  final rgbValue = 53;
  final rgbBorderValue = 20;


  final MainCategoryModel mainCategory;
  final Function handleClickButton;
  // final String id;
  // final String title;
  // final String  parentId;    // if no parent this will be -2 "minus 2"

  MainDrawerHeaderButton({
    this.mainCategory,
    this.handleClickButton
  });


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      animationDuration: Duration(seconds: 2),      
      padding: EdgeInsets.zero,
      elevation: 5,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: Color.fromRGBO(rgbValue , rgbValue, rgbValue, 1),
      child:  Container(
      padding: EdgeInsetsDirectional.only(
        top: 10,
        bottom: 10
      ),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(rgbBorderValue , rgbBorderValue, rgbBorderValue, 1),
              width: 1
            ),
            bottom: BorderSide(
              color: Color.fromRGBO(rgbBorderValue , rgbBorderValue, rgbBorderValue, 1),
              width: 1
            ),
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Icon(
                Icons.chevron_left,
                color: Color.fromRGBO(174, 174, 174, 1),                
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                mainCategory.title,
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(226, 197, 55, 1)
                )
              ),
            ),                         
          ],
        ),
      ),
      
      
      // icon: Icon(Icons.chevron_right),
      // label: Text('Computers & Tablets'),
      onPressed: (){
        this.handleClickButton();
      },  
    );
  }
}