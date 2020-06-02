

import 'package:flutter/material.dart';

var customAppBar = (
  String title

 )  {

   final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1); 
  
  return PreferredSize(
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
                    title,
                    textAlign: TextAlign.center,
                  ),
                ),  
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 24,
                  ),
                  onPressed: () {},
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
  );
};

   