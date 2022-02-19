import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/components/drawer/main_drawer_button2.dart';
import 'package:tech_store/components/drawer/second_level_drawer_button.dart';


// Providers
import '../../providers/category_provider.dart';

// Components
import './main_drawer_button.dart';
import './main_drawer_header_button.dart';




import '../../dummy_data.dart';

// Models
import 'package:tech_store/models/drawer_menu_item.dart';
import 'package:tech_store/models/category_model.dart';



class MainDrawer extends StatefulWidget {
  final Function selectPage;

  MainDrawer({
    required this.selectPage
  });

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

//  ------------------    STATE    ----------------------
class _MainDrawerState extends State<MainDrawer> {
  List<DrawerMenuItem> menuItemsList = [];
  List<TransformedDrawerMenuItem> _transformedChildrenList = [];
  List<TransformedDrawerMenuItem> _transformedChildrenList2 = [];
  // List<TransformedDrawerMenuItem> _filteredItemsList = [];
  late String _currentMenuId;
  bool _isHeaderExists = false;
  List _visibleSubItemsList = [];

  var _showMainItems = true;
  String? _mainCategoryId;


  void goToSecondLevel ({
    String? mainCategoryId,    
  }) {
    setState(() {
      _mainCategoryId = mainCategoryId;
      _showMainItems = false;
      _isHeaderExists = true;
    });
  }

  void goToMainLevel () {
    setState(() {
      _mainCategoryId = null;
      _showMainItems = true;
      _isHeaderExists = false;
    });
  }

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
    required List<DrawerMenuItem> inputList,
    required String id
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
     required List<DrawerMenuItem> inputList,
     required List<DrawerMenuItem> allItemsList,
     required String id
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

  List<TransformedDrawerMenuItem> handleCalculateTransformedChildrenList2 ({
     required List<DrawerMenuItem> inputList,
     required List<DrawerMenuItem> allItemsList,
     required String id
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
    required String id,
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
                mainCategory: Provider.of<CategoryProvider>(context)
                  .mainCategoryList.firstWhere((element) => element.id == _mainCategoryId),
                handleClickButton: goToMainLevel
              ),


              // ..._transformedChildrenList.map(
              //   (item) {
              //     return buildMainDrawerButton( item );
              //   }
              // ).toList(),

              if (
                Provider.of<CategoryProvider>(context).mainCategoryList.length > 0 
                && !_showMainItems
                && _mainCategoryId != null
                ) ...Provider
                  .of<CategoryProvider>(context).mainCategoryList.firstWhere(
                    (element) => element.id == _mainCategoryId
                    ).childrenList.map(
                      (secondLevelCategory) => SecondLevelDrawerButton(
                        handleClickButton: null,
                        selectPage: widget.selectPage,
                        secondLevelCategory: secondLevelCategory,
                      )
                    ).toList(),

              if (
                Provider.of<CategoryProvider>(context).mainCategoryList.length > 0 
                && _showMainItems
                ) ...Provider
                .of<CategoryProvider>(context).mainCategoryList.map((item) {
                  return MainDrawerButton2 (
                    handleClickButton: goToSecondLevel,
                    mainCategory: item
                  );
                }).toList(),


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