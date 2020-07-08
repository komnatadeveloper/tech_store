import 'package:flutter/material.dart';
// Screens
import '../create_new_address/create_new_address_screen.dart';

class OrderAddressDetailsScreen extends StatefulWidget {
  static const routeName = '/order-address-details';
  @override
  _OrderAddressDetailsScreenState createState() => _OrderAddressDetailsScreenState();
}




//   -------------------------------    STATE    ---------------------------------
class _OrderAddressDetailsScreenState extends State<OrderAddressDetailsScreen> {
  final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1);
  String _deliverOption;  // 'from-tech-store-warehouse' || 'shipment-to-address'
  @override
  void initState() {
    // TODO: implement initState
    _deliverOption = 'from-tech-store-warehouse';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appbarBackgroundColor,
        title: Text('Address Details'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey[400],
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 12,
                  right: 12,
                  bottom: 20
                ),
                width: double.infinity,
                child: RaisedButton.icon(
                  icon: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  label: Text('Add New Address'),
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(
                    vertical: 12
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CreateNewAddressScreen.routeName
                    );
                  },
                ) ,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 20
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 'from-tech-store-warehouse',
                        groupValue: _deliverOption,
                        onChanged: ( val ) {
                          print(val);
                          setState((  ) {
                            _deliverOption = val;
                          });
                        },
                      ),
                      Text(
                        'Tech Store Warehouse',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      )
                    ],
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: 12

                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 'shipment-to-address',
                        groupValue: _deliverOption,
                        onChanged: ( val ) {
                          print(val);
                          setState((  ) {
                            _deliverOption = val;
                          });
                        },
                      ),
                      Text(
                        'To Address',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      )
                    ],
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: 12

                ),
                child: Card(
                  margin: EdgeInsets.only(
                    top:3,
                    left:0,
                    right:0,
                    bottom: 0
                  ),
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 'customer-adress-1',
                        groupValue: 'customer-adress-1',
                        onChanged: ( val ) {
                          print(val);
                          // setState((  ) {                            
                          //   _deliverOption = val;
                          // });
                        },
                      ),
                      Text(
                        'customer-adress-1',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      )
                    ],
                  )
                ),
              ),

              
            ],
          ),
        ),
        
      ),
      
    );
  }
}