import 'package:flutter/material.dart';

// Models
import '../../models/drawer_menu_item.dart';

import '../../helpers/color_helper.dart' as colorHelper;



class MainDrawerButton extends StatefulWidget {
  final TransformedDrawerMenuItem transformedDrawerMenuItem;
  final Function handleClickButton;
  final List<DrawerMenuItem> subItemList;
  // final bool isSubItemsVisible;
  


  MainDrawerButton({
    this.transformedDrawerMenuItem,
    this.handleClickButton,
    this.subItemList,
    // this.isSubItemsVisible
  });

  @override
  _MainDrawerButtonState createState() => _MainDrawerButtonState();
}


//   ------------------------ STATE -----------------------------
class _MainDrawerButtonState extends State<MainDrawerButton> with SingleTickerProviderStateMixin {
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
  

  Widget renderChildrenButtons () {
    return SizeTransition(
      sizeFactor: _animationController,

 
      child: SlideTransition(
        position: _slideAnimation,      
        child: Column(
          children: widget.subItemList.length > 0 && _isSubItemsVisible
            ? widget.subItemList.map(
              (subItem) =>  FlatButton(
                // animationDuration: Duration(seconds: 2),      
                padding: EdgeInsets.zero,
                // elevation: 5,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                // color: Color.fromRGBO(rgbValue , rgbValue, rgbValue, 1),
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

                  if(
                    widget.transformedDrawerMenuItem.hasChildren
                    && widget.transformedDrawerMenuItem.isSubItem
                    && widget.subItemList.length > 0                  
                  ) {
                    if (  !_isSubItemsVisible ) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                  } else {
                    this.widget.handleClickButton(
                      isHeaderButton: false,
                      id: widget.transformedDrawerMenuItem.drawerMenuItem.id,
                      isSubItem: widget.transformedDrawerMenuItem.isSubItem,  // WILL BE UPDATED
                      // isSubItemsVisible: widget.transformedDrawerMenuItem.isSubItem 
                        // ? !widget.isSubItemsVisible
                        // : false,
                      hasChildren: widget.transformedDrawerMenuItem.hasChildren
                      
                    );
                  }
                },  
              )
            ).toList()
            : []
        ),
      ),
    ); 
  }

  IconData get  mainButtonIcon {
    if( widget.transformedDrawerMenuItem.isSubItem
      && widget.transformedDrawerMenuItem.hasChildren       
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

    if( widget.transformedDrawerMenuItem.drawerMenuItem.id == '12' ) {

      print('MainDrawerButton -> transformedDrawerMenuItem -> isSubItemsVisible ');
      print(_isSubItemsVisible);
      print( widget.transformedDrawerMenuItem.hasChildren );
      print( widget.subItemList );
    }




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
                    widget.transformedDrawerMenuItem.drawerMenuItem.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: widget.transformedDrawerMenuItem.isSubItem 
                        // ? Color.fromRGBO(86 , 137, 87, 1)
                        ? Color.fromRGBO(111 , 160, 115, 1)
                        // ? Color.fromRGBO(59 , 95, 60, 1)
                        // ? colorHelper.HexColor('#353535')
                        // ?   colorHelper.colorFromHex('35dd35')
                        // ?   Color(colorHelper.getColorHexFromStr('353d35'))
                        :  Color.fromRGBO(222, 222, 222, 1)
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
              widget.transformedDrawerMenuItem.hasChildren
              && widget.transformedDrawerMenuItem.isSubItem
              && widget.subItemList.length > 0                  
            ) {
              if (  !_isSubItemsVisible ) {
                print(widget.subItemList.length);
                setState(() {
                  _isSubItemsVisible = true;
                });
                _animationController.forward();
              } else {
                print(widget.subItemList.length);
                setState(() {
                  _isSubItemsVisible = false;
                });
                _animationController.reverse();
              }
            } else {
              this.widget.handleClickButton(
                isHeaderButton: false,
                id: widget.transformedDrawerMenuItem.drawerMenuItem.id,
                isSubItem: widget.transformedDrawerMenuItem.isSubItem,  // WILL BE UPDATED
                // isSubItemsVisible: widget.transformedDrawerMenuItem.isSubItem 
                  // ? !widget.isSubItemsVisible
                  // : false,
                hasChildren: widget.transformedDrawerMenuItem.hasChildren
                
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