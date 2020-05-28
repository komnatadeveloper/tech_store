import 'package:flutter/material.dart';

class SpecialForYouItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: 10,
        left: 15,
        right: 15,
        bottom: 10
      ),
      shape: ContinuousRectangleBorder(
        
      ),
      elevation: 15,
      child: Container(
        height: 60,
        padding: EdgeInsets.all(3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.network(
              'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
              fit: BoxFit.cover,
              width: 60,
              height: double.infinity,
            ),

            // Text with price
            Expanded(              
              child: Container(
                height: double.infinity,                
                // color: Colors.orange,
                padding: EdgeInsets.symmetric(
                  horizontal: 6
                ),
                child: Center(
                  child: Text(
                    'SA400S37 has a special price \$50.50 for you',
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.green
                    ),
                    // style: TextStyle(),
                  ),
                ),
              ),
            ),
            
            // Button
            Container(
              // width: 70,
              // color: Colors.blue,
              padding: EdgeInsets.only(right: 6),
              child: 
              RaisedButton(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 8.0
                  
                ),
                
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('View'),
                onPressed: () {
                },
                
                
              ),
            )
          ],
        ),
      ),
    );

  }
}