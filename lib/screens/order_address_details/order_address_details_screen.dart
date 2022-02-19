import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Models
import '../../models/customer_model.dart';
// Providers
import '../../providers/auth_provider.dart';
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
  String? _deliverOption;  // 'from-tech-store-warehouse' || 'shipment-to-address'
   List<AddressModel> _customerAddressList = [];
  //  int _selectedAddressIndex = 0;
   AddressModel? _selectedAddress;
  @override
  void initState() {
    // TODO: implement initState
    
    // _customerAddressList = Provider.of<AuthProvider>(context, listen: false).customerModel.addressList;
    // if ( _customerAddressList.length != 0 ) {
    //   _selectedAddress = _customerAddressList[0];
    // }
    super.initState();
  }

  Widget _customerAddressItemWidget ({
    required AddressModel addressModel
  }) {
    return Container(
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
              value: addressModel.definition,
              groupValue: _selectedAddress!.definition,
              onChanged: ( val ) {
                print(val);
                print('OrderAddressDetailsScreen -> _customerAddressItemWidget -> CLICK');
                var index = _customerAddressList.indexOf(addressModel);
                Provider.of<AuthProvider>(context, listen: false).setSelectedAddressIndex(index);
                // setState((  ) {                            
                //   _deliverOption = val;
                // });
              },
            ),
            Text(
              addressModel.definition,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            )
          ],
        )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    _deliverOption =  Provider.of<AuthProvider>(context).orderDeliverOption!;
    if (Provider.of<AuthProvider>(context).customerModel != null ) {
      _customerAddressList = Provider.of<AuthProvider>(context).customerModel!.addressList;
    }
    if ( _customerAddressList.length != 0 ) {
      if ( Provider.of<AuthProvider>(context).selectedAddressIndex != null ) {
        _selectedAddress = _customerAddressList[
          Provider.of<AuthProvider>(context).selectedAddressIndex!
        ];
      } 
    }
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
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  label: Text('Add New Address'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    padding: EdgeInsets.symmetric(
                      vertical: 12
                    ),
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
                          Provider.of<AuthProvider>(context,listen: false).setOrderDeliveryOption(
                            'from-tech-store-warehouse'
                          );
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
                          Provider.of<AuthProvider>(context,listen: false).setOrderDeliveryOption(
                            'shipment-to-address'
                          );
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
              if (_customerAddressList.length > 0) ..._customerAddressList.map(
                (addressItem ) => _customerAddressItemWidget(
                  addressModel: addressItem
                )
              ).toList(),
              // Text('This is a test'),
              // Consumer<AuthProvider>(
              //   builder: ( _, authInstance, child ) => authInstance.customerModel.addressList.length > 0
              //     ?
              //     Column(
              //       children: authInstance.customerModel.addressList.map(
              //         (addressItem ) => _customerAddressItemWidget(
              //           addressModel: addressItem
              //         )
              //       ).toList(),
              //     )                  
              //     : SizedBox(height: 0.2,)
              // ),
              if (_customerAddressList.length == 0) Container(
                margin: EdgeInsets.only(
                  // top: 20,
                  left: 12,
                  right: 12,
                  bottom: 20
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 10
                    ),
                    primary: Colors.white,
                  ),
                  child: Text(
                    'No Addresses. Please Add!',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CreateNewAddressScreen.routeName
                    );
                  },
                ),
              )

                  
    //               label: Text('Add New Address'),
    //               color: Colors.grey,
    //               padding: EdgeInsets.symmetric(
    //                 vertical: 12
    //               ),
    //               onPressed: () {
    //                 Navigator.of(context).pushNamed(
    //                   CreateNewAddressScreen.routeName
    //                 );
    //               },
    //             ) ,
    // )
              

              
            ],
          ),
        ),
        
      ),
      
    );
  }
}