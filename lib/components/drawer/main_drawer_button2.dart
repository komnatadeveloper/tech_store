import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/models/category_model.dart';
import 'package:tech_store/providers/product_provider.dart';

// Models
import '../../models/drawer_menu_item.dart';

import '../../helpers/color_helper.dart' as colorHelper;



class MainDrawerButton2 extends StatefulWidget {
  // final TransformedDrawerMenuItem transformedDrawerMenuItem;
  final Function handleClickButton;
  final MainCategoryModel mainCategory;
  // final bool isSubItemsVisible;
  


  MainDrawerButton2({
    // this.transformedDrawerMenuItem,
    this.handleClickButton,
    this.mainCategory,
    // this.isSubItemsVisible
  });

  @override
  _MainDrawerButtonState2 createState() => _MainDrawerButtonState2();
}


//   ------------------------ STATE -----------------------------
class _MainDrawerButtonState2 extends State<MainDrawerButton2> with SingleTickerProviderStateMixin {
  final rgbValue = 53;

  final rgbBorderValue = 20;

  Animation<Offset> _slideAnimation;
  AnimationController _animationController;
  bool _isSubItemsVisible = false;
  var _animationDuration = 450;

  Animation<RelativeRect> _testRelativeRectAnimation;

  
  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationDuration),
      reverseDuration: Duration(milliseconds: _animationDuration)
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 0),
      ).animate( CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear
      )
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
  

  



  @override
  Widget build(BuildContext context) {





    return Column(
      children: <Widget>[
          RaisedButton(
          animationDuration: Duration(milliseconds: 800),      
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.mainCategory.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(222, 222, 222, 1)
                    )
                  ),
                ),
                Icon(
                  // ( transformedDrawerMenuItem.isSubItem
                  //   && transformedDrawerMenuItem.hasChildren
                  // )
                  //   ? Icons.add          
                  //   : Icons.chevron_right,
                  Icons.chevron_right,
                  color: Color.fromRGBO(108, 108, 108, 1),
                )                          
              ],
            ),
          ),
          
          
          // icon: Icon(Icons.chevron_right),
          // label: Text('Computers & Tablets'),
          onPressed: () {

            widget.handleClickButton(
              mainCategoryId: widget.mainCategory.id
            );
            print('MainDrawerButton2 Click');
            print('widget.mainCategory.title ->');
            print(widget.mainCategory.title);
            print('widget.mainCategory.childrenList.length -> ');
            print(widget.mainCategory.childrenList.length);

            if(widget.mainCategory.childrenList.length == 0) {
              Provider.of<ProductProvider>(context, listen: false).getProductsByCategory(
                categoryId: widget.mainCategory.id
              );
            }
          },  
        ),
        
      ] 
    );
  }
}



// return RaisedButton(
//       animationDuration: Duration(seconds: 2),      
//       padding: EdgeInsets.zero,
//       elevation: 5,
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       color: Color.fromRGBO(rgbValue , rgbValue, rgbValue, 1),
//       child:  Container(
//       padding: EdgeInsetsDirectional.only(
//         top: 10,
//         bottom: 10
//       ),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(
//               color: Color.fromRGBO(rgbBorderValue , rgbBorderValue, rgbBorderValue, 1),
//               width: 1
//             ),
//             bottom: BorderSide(
//               color: Color.fromRGBO(rgbBorderValue , rgbBorderValue, rgbBorderValue, 1),
//               width: 1
//             ),
//           )
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 transformedDrawerMenuItem.drawerMenuItem.title,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: transformedDrawerMenuItem.isSubItem 
//                     // ? Color.fromRGBO(86 , 137, 87, 1)
//                     ? Color.fromRGBO(111 , 160, 115, 1)
//                     // ? Color.fromRGBO(59 , 95, 60, 1)
//                     // ? colorHelper.HexColor('#353535')
//                     // ?   colorHelper.colorFromHex('35dd35')
//                     // ?   Color(colorHelper.getColorHexFromStr('353d35'))
//                     :  Color.fromRGBO(222, 222, 222, 1)
//                 )
//               ),
//             ),
//             Icon(
//               ( transformedDrawerMenuItem.isSubItem
//                 && transformedDrawerMenuItem.hasChildren
//               )
//                 ? Icons.add          
//                 : Icons.chevron_right,
//               color: Color.fromRGBO(108, 108, 108, 1),
//             )                          
//           ],
//         ),
//       ),  
//       onPressed: () {
//         this.handleClickButton(
//           id: transformedDrawerMenuItem.drawerMenuItem.id,
//           isSubItem: transformedDrawerMenuItem.isSubItem,  // WILL BE UPDATED
//           isSubItemsVisible: transformedDrawerMenuItem.isSubItem 
//             ? !isSubItemsVisible
//             : false,
//           hasChildren: transformedDrawerMenuItem.hasChildren
          
//         );
//       },  
//     );