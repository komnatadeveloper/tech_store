import 'package:flutter/material.dart';

// Components
import './main_drawer_button.dart';
import './main_drawer_header_button.dart';


import '../../dummy_data.dart';

// Models
import 'package:tech_store/models/drawer_menu_item.dart';


class MainDrawer extends StatefulWidget {

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

//  ------------------    STATE    ----------------------
class _MainDrawerState extends State<MainDrawer> {
  List<DrawerMenuItem> menuItemsList = [];
  List<TransformedDrawerMenuItem> _transformedChildrenList = [];
  // List<TransformedDrawerMenuItem> _filteredItemsList = [];
  String _currentMenuId;
  bool _isHeaderExists = false;
  List _visibleSubItemsList = [];


  @override
  void initState() {
    // TODO: implement initState
    menuItemsList = dummyDrawerMenuList;
    _currentMenuId = '-2';
    _transformedChildrenList = handleCalculateTransformedChildrenList(
      allItemsList: dummyDrawerMenuList,
      inputList: findRawChildren('-2'),
      id: '-2'
      // findRawChildren('-2')
    );
    _isHeaderExists = false;
    super.initState();
  }

  bool doesItemHaveChildren ({
    List<DrawerMenuItem> inputList,
    String id
  }) {
    final index = inputList.indexWhere(
      (element) => element.parentId == id 
    );
    if ( index >= 0 ) {
      return true;
    }
    return false;
  }

  List<TransformedDrawerMenuItem> handleCalculateTransformedChildrenList ({
     List<DrawerMenuItem> inputList,
     List<DrawerMenuItem> allItemsList,
     String id
  }) {
    if( _isHeaderExists ) {
      // if _isHeaderExists, so _currentMenuId is not NULL
      // var tempFilteredList = findRawChildren( _currentMenuId );
      return  List.generate(
        inputList.length, (index)  {
          return TransformedDrawerMenuItem(
            drawerMenuItem: inputList[index],
            hasChildren: doesItemHaveChildren(
              inputList: allItemsList,
              id: inputList[index].id
            ),
            isSubItem: true
          );
        }
      );
    } else {   // So we are at top Level
      // var tempFilteredList = findRawChildren( '-2' );
      return List.generate(
        inputList.length, (index)  {
          return TransformedDrawerMenuItem(
            drawerMenuItem: inputList[index],
            hasChildren: doesItemHaveChildren(
              inputList: allItemsList,
              id: inputList[index].id
            ),
            isSubItem: false
          );
        }
      );
    }
  }

  List<DrawerMenuItem> findRawChildren ( String id ) {
    return menuItemsList
      .where(
        (element) => element.parentId == id
    ).toList();
  }

  void handleClickButton ( {
    String id,
    bool isHeaderButton = false,
    bool isSubItem = false,
    // bool isSubItemsVisible = false,
    bool hasChildren = false
  } ) {
    print('MainDrawer -> handleClickButton method -> DrawerItemId ->');
    print(id);
    // Check if this item has sub items:
    var filteredList = findRawChildren(id);
    if( 
      filteredList.length > 0 // 
      ) {
        // sub of sub items
        if( isSubItem ) {
          print('Sub Item');
          // // Show 
          // if( isSubItemsVisible )  {
          //   setState(() {
          //     _visibleSubItemsList.add( id );
          //   }); 
          // // Hide
          // }  else {
          //   setState(() {
          //     _visibleSubItemsList.removeWhere((element) => element == id );
          //   });
          // }        
        } else {
          setState(() {
            _isHeaderExists =  isHeaderButton ? false : true;
            _currentMenuId = id;
            _transformedChildrenList = handleCalculateTransformedChildrenList(
              allItemsList: menuItemsList,
              inputList: filteredList,
              id: id
            );
          });
        }
    }
  } 

  Widget buildMainDrawerButton ( TransformedDrawerMenuItem item ) {
    List<DrawerMenuItem> tempSubItems = [];
    if (
      item.isSubItem
      && item.hasChildren
    ) {
      tempSubItems = findRawChildren( item.drawerMenuItem.id );
    }

      // bool isSubItemsVisible = _visibleSubItemsList
      //   .indexWhere( (element) => element == item.drawerMenuItem.id ) >= 0; 
               
      // List<DrawerMenuItem> tempSubItems = [];
      // if( isSubItemsVisible ) {
      //   tempSubItems = findRawChildren( item.drawerMenuItem.id );
      // }

    return MainDrawerButton(
      // id: item.id,
      // title: item.title,
      // parentId: item.parentId,
      // handleClickButton: this.handleClickButton,
      transformedDrawerMenuItem: item,
      handleClickButton: this.handleClickButton,
      // isSubItemsVisible: _visibleSubItemsList.indexWhere(
      //   (  element) => element == item.drawerMenuItem.id ) 
      //     >= 0 ? true : false,
      subItemList:  [...tempSubItems],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Container(
        color: Color.fromRGBO(78, 78, 78, 1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 30,
                  left: 20
                ),
                alignment: Alignment.centerLeft,
                color: Color.fromRGBO(78, 78, 78, 1),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.white
                  ),
                ),
                
              ),
              SizedBox(
                height: 20,
              ),

              // MainDrawerButton(),
              // MainDrawerButton(),
              // MainDrawerButton(),

              if( _isHeaderExists ) MainDrawerHeaderButton(
                drawerMenuItem:  menuItemsList.firstWhere((element) => element.id == _currentMenuId),
                handleClickButton: this.handleClickButton
              ),


              ..._transformedChildrenList.map(
                (item) {
                  return buildMainDrawerButton( item );
                }
              ).toList(),


              // buildListTile(
              //   'Meals',
              //   Icons.restaurant,
              //   () {
              //     Navigator.of(context).pushReplacementNamed('/');
              //   }
              // ),
              // buildListTile(
              //   'Filters',
              //   Icons.settings,
              //   () {
              //     Navigator.of(context).pushReplacementNamed(
              //       FiltersScreen.routeName
              //     );

              //   }
              // ),
              
              
            ],
          ),
        ),
      ),
      
    );
  }
}