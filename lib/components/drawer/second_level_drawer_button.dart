import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/providers/product_provider.dart';

// Models
import '../../models/drawer_menu_item.dart';
import '../../models/category_model.dart';
// Helpers
import '../../helpers/color_helper.dart' as colorHelper;



class SecondLevelDrawerButton extends StatefulWidget {
  final SecondLevelCategoryModel secondLevelCategory;
  final Function? handleClickButton;
  final Function selectPage;
  // final bool isSubItemsVisible;
  


  SecondLevelDrawerButton({
    required this.secondLevelCategory,
    required this.selectPage,
    this.handleClickButton
    // this.isSubItemsVisible
  });

  @override
  _SecondLevelDrawerButtonState createState() => _SecondLevelDrawerButtonState();
}


//   ------------------------ STATE -----------------------------
class _SecondLevelDrawerButtonState extends State<SecondLevelDrawerButton> with SingleTickerProviderStateMixin {
  final rgbValue = 53;

  final rgbBorderValue = 20;

  late Animation<Offset> _slideAnimation;
  late AnimationController _animationController;
  bool _isSubItemsVisible = false;
  var _animationDuration = 450;

  // Animation<RelativeRect> _testRelativeRectAnimation;

  
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
  

  Widget renderChildrenButtons () {
    return SizeTransition(
      sizeFactor: _animationController,

 
      child: SlideTransition(
        position: _slideAnimation,      
        child: Column(
          children: widget.secondLevelCategory.childrenList != null && widget.secondLevelCategory.childrenList!.length > 0 && _isSubItemsVisible
            ? widget.secondLevelCategory.childrenList!.map(
              (subItem) =>  TextButton(
                style: TextButton.styleFrom(
                  // animationDuration: Duration(seconds: 2),      
                  padding: EdgeInsets.zero,
                  // elevation: 5,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // color: Color.fromRGBO(rgbValue , rgbValue, rgbValue, 1),
                ),
                child:  Container(
                padding: EdgeInsetsDirectional.only(
                  top: 10,
                  bottom: 10
                ),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          subItem.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color:  Colors.white
                          )
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color.fromRGBO(108, 108, 108, 1),
                      )                          
                    ],
                  ),
                ),            
                onPressed: () {

                  Provider.of<ProductProvider>(
                    context,
                    listen: false
                  ).getProductsByCategory(
                    categoryId: subItem.id
                  );
                  widget.selectPage(1); // 1 is Search Tab in DefaultScreen
                  Navigator.of(context).pop();

                  // if(
                  //   widget.secondLevelCategory.childrenList.length > 0                
                  // ) {
                  //   if (  !_isSubItemsVisible ) {
                  //     _animationController.forward();
                  //   } else {
                  //     _animationController.reverse();
                  //   }
                  // } else {
                    // this.widget.handleClickButton(
                    //   isHeaderButton: false,
                    //   id: widget.transformedDrawerMenuItem.drawerMenuItem.id,
                    //   isSubItem: widget.transformedDrawerMenuItem.isSubItem,  // WILL BE UPDATED
                    //   // isSubItemsVisible: widget.transformedDrawerMenuItem.isSubItem 
                    //     // ? !widget.isSubItemsVisible
                    //     // : false,
                    //   hasChildren: widget.transformedDrawerMenuItem.hasChildren
                      
                    // );
                  // }
                },  
              )
            ).toList()
            : []
        ),
      ),
    ); 
  }

  IconData get  mainButtonIcon {
    if(widget.secondLevelCategory.childrenList != null && widget.secondLevelCategory.childrenList!.length > 0     
    ) {
      if( _isSubItemsVisible )  {
        // return Icons.maximize;
        // return Icons.minimize;
        return Icons.remove;
      }
      return Icons.add;
    } else {
      return Icons.chevron_right;
    }  
  }

  @override
  Widget build(BuildContext context) {
    // print('MainDrawerButton -> transformedDrawerMenuItem ->');

    // print(transformedDrawerMenuItem..drawerMenuItem.title.toString());
    // print(transformedDrawerMenuItem.hasChildren);






    return Column(
      children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              animationDuration: Duration(milliseconds: 800),      
              padding: EdgeInsets.zero,
              elevation: 5,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Color.fromRGBO(rgbValue , rgbValue, rgbValue, 1),
            ),
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
                    widget.secondLevelCategory.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(111 , 160, 115, 1),

                    )
                  ),
                ),
                Icon(
                  // ( transformedDrawerMenuItem.isSubItem
                  //   && transformedDrawerMenuItem.hasChildren
                  // )
                  //   ? Icons.add          
                  //   : Icons.chevron_right,
                  mainButtonIcon,
                  color: Color.fromRGBO(108, 108, 108, 1),
                )                          
              ],
            ),
          ),
          
          
          // icon: Icon(Icons.chevron_right),
          // label: Text('Computers & Tablets'),
          onPressed: () {


            // ----------------------------------------------------------------
            if(
              widget.secondLevelCategory.childrenList != null 
              &&          widget.secondLevelCategory.childrenList!.length > 0               
            ) {
              if (  !_isSubItemsVisible ) {
                print(widget.secondLevelCategory.childrenList!.length);
                setState(() {
                  _isSubItemsVisible = true;
                });
                _animationController.forward();
              } else {
                print(widget.secondLevelCategory.childrenList!.length);
                setState(() {
                  _isSubItemsVisible = false;
                });
                _animationController.reverse();
              }
            } else {
              // this.widget.handleClickButton(
              //   isHeaderButton: false,
              //   id: widget.transformedDrawerMenuItem.drawerMenuItem.id,
              //   isSubItem: widget.transformedDrawerMenuItem.isSubItem,  // WILL BE UPDATED
              //   // isSubItemsVisible: widget.transformedDrawerMenuItem.isSubItem 
              //     // ? !widget.isSubItemsVisible
              //     // : false,
              //   hasChildren: widget.transformedDrawerMenuItem.hasChildren
                
              // );
              widget.selectPage(1); // 1 is Search Tab in DefaultScreen
              Navigator.of(context).pop();

              Provider.of<ProductProvider>(context).getProductsByCategory(
                categoryId: widget.secondLevelCategory.id
              );
            }
            // ----------------------------------------------------------------






            // this.widget.handleClickButton(
            //   id: widget.transformedDrawerMenuItem.drawerMenuItem.id,
            //   isSubItem: widget.transformedDrawerMenuItem.isSubItem,  // WILL BE UPDATED
            //   isSubItemsVisible: widget.transformedDrawerMenuItem.isSubItem 
            //     ? !widget.isSubItemsVisible
            //     : false,
            //   hasChildren: widget.transformedDrawerMenuItem.hasChildren
              
            // );

            // if( widget.transformedDrawerMenuItem.hasChildren
            //   && widget.isSubItemsVisible
            //   && widget.transformedDrawerMenuItem.isSubItem
            //  ) {
            //    print(widget.subItemList.length);
            //    _animationController.forward();
            //  }
            // if( widget.transformedDrawerMenuItem.hasChildren
            //   && !widget.isSubItemsVisible
            //   && widget.transformedDrawerMenuItem.isSubItem
            //  ) {
            //    print(widget.subItemList.length);
            //    _animationController.reverse();

            //  }
          },  
        ),
        renderChildrenButtons()
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