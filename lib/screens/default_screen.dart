import 'package:flutter/material.dart';

import '../components/drawer/main_drawer.dart';
// Screens
import './home/home_screen.dart';
import './search/search_screen.dart';
import './favorites/favorites_screen.dart';
import './account/account_screen.dart';



class DefaultScreen extends StatefulWidget {
  @override
  _DefaultScreenState createState() => _DefaultScreenState();
}

// ------------- STATE -----------------
class _DefaultScreenState extends State<DefaultScreen> {

  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;




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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(208, 57, 28, 1),
        actions: <Widget>[

        ],
        title: Container(
          color: Colors.yellow,
          width: double.infinity,
          margin: EdgeInsets.only(right: 60),
          child: Text(
            _pages[_selectedPageIndex]['title'],
            textAlign: TextAlign.center,
          ),
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