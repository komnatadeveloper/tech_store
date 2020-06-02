import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  Widget _accountScreenItem (
    String title
  ) {
    return Container(
      color: Colors.white,
      height: 40,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title
          ),
          Icon(
            Icons.chevron_right
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
        top: 25
      ),
      height: double.infinity,
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _accountScreenItem('My Orders')
          ],
        ),
      ),
    );
  }
}