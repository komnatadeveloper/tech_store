import 'package:flutter/material.dart';

import '../components/drawer/main_drawer.dart';
// Screens
import './home/home_screen.dart';
import './search/search_screen.dart';
import './favorites/favorites_screen.dart';
import './account/account_screen.dart';
import './cart/cart_screen.dart';



class DefaultScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _DefaultScreenState createState() => _DefaultScreenState();
}

// ------------- STATE -----------------
class _DefaultScreenState extends State<DefaultScreen> {

  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1);




  void _selectPage(int newIndex) {
    setState(() {
      _selectedPageIndex = newIndex;
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      {
        'page':HomeScreen(), 
        'title':'Main'
      },
      {
        'page':SearchScreen( ), 
        'title':'Search'
      }, 
      {
        'page':FavoritesScreen( ), 
        'title':'Favorites'
      }, 
      {
        'page':AccountScreen( ), 
        'title':'Account'
      }, 
    ];
    super.initState();
  } // End of initState

  


  @override
  Widget build(BuildContext context) {

    var varAppBar = Builder(
      builder: ( BuildContext ctx) {
        return PreferredSize(
          preferredSize: Size.fromHeight(101.0),
          
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(ctx).padding.top
            ),
            color: _appbarBackgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          size: 28,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      Text(
                        _pages[_selectedPageIndex]['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24
                        ),
                        //  textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ] 
            ),
          ),
        );
      },
    ); 

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(208, 57, 28, 1),
      //   flexibleSpace: Container(
      //     height: 150,
      //     child: null,
      //   ),
      //   actions: <Widget>[

      //   ],
      //   title: Container(
      //     color: Colors.yellow,
      //     width: double.infinity,
      //     margin: EdgeInsets.only(right: 60),
      //     child: Column(
      //       children: <Widget>[
      //         Text(
      //           _pages[_selectedPageIndex]['title'],
      //           textAlign: TextAlign.center,
      //         ),
      //         TextField(
      //           decoration: InputDecoration(
      //             fillColor: Colors.pink,
      //             filled: true
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(101.0),
        
        child: Column(
          children: <Widget>[
            AppBar(
              centerTitle: false,

              backgroundColor: _appbarBackgroundColor,
              actions: <Widget>[                
              ],
              title: Container(
                
                // color: Colors.yellow,
                width: double.infinity,
                // margin: EdgeInsets.only(right: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(                      
                      child: Text(
                        _pages[_selectedPageIndex]['title'],
                        textAlign: TextAlign.center,
                      ),
                    ),  
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          CartScreen.routeName
                        );
                      },
                    )                
                  ],
                ),
              ),
            ),
            Container(
              color: _appbarBackgroundColor,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(                
                cursorColor: Colors.pink,
                // textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                ),
                
                
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,  
                  // labelText: 'Search in Tech Store',
                  hintText: 'Search in Tech Store',
                  
                  contentPadding: EdgeInsets.only(
                    bottom: 10
                  ),
                  
                  
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),                  
                  border: InputBorder.none,  
                  
                          
                                  
                ),
                
                
              ),
            ),
            Container(
              color: _appbarBackgroundColor,
              height: 15,
            )
          ] 
        ),
      ),

      drawer: MainDrawer(),

      body: _pages[_selectedPageIndex]['page'],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,   // if you need more than 3 items this should be fixed

        
        onTap: _selectPage,
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Color.fromRGBO(208, 57, 28, 1),
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.home,
              // size: 12,
            ),
            title: Text('Main')
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.search ,
              // size: 12,
            ),
            title: Text('Search')
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star,
              // size: 12,
            ),
            title: Text('Favorites')
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person),
            title: Text('Account')
          ),
        ],
      ),
    );
  }
}