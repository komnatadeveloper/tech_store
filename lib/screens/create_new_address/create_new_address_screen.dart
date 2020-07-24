import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/providers/auth_provider.dart';
// Models
import '../../models/customer_model.dart';


class CreateNewAddressScreen extends StatefulWidget {
  static const routeName = '/create-new-address';
  @override
  _CreateNewAddressScreenState createState() => _CreateNewAddressScreenState();
}

//   ----------------------------    STATE    ------------------------------
class _CreateNewAddressScreenState extends State<CreateNewAddressScreen> {
  final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1);
  AddressModel _formData = AddressModel(
    definition: '',
    receiver: '',
    addressString: '',
    city: ''
  );
  bool _willSaveAddress = true;
  bool _isLoading = true;
  // focus nodes
  final _definitionFocusNode = FocusNode();
  final _receiverFocusNode = FocusNode();
  final _addressStringFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  // global key
  final _addAddressFormGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _isLoading = false;
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
  _definitionFocusNode.dispose();
  _receiverFocusNode.dispose();
  _addressStringFocusNode.dispose();
  _cityFocusNode.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appbarBackgroundColor,
        // title: Text('Create Address'),
        title: Row(
          children: <Widget>[
            Expanded(
              child: Center(child: Text('Create Address')),
            ),
            FlatButton(
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
              onPressed: () async {
                if ( !_addAddressFormGlobalKey.currentState.validate() ) {
                  print('CreateNewAddressScreen -> parameters not validated!');
                  return;
                }
                _addAddressFormGlobalKey.currentState.save();
                if( _willSaveAddress ) {
                  setState(() {
                    _isLoading = true;                  
                  });
                  await Provider.of<AuthProvider>(context, listen: false).addAddress(
                    addressModel: _formData
                  );
                  setState(() {
                    _isLoading = false;                  
                  });
                  Navigator.of(context).pop();
                } else {
                  print('CreateNewAddressScreen -> addAddressWithoutSaving ->');
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
        // actions: <Widget>[
        //   Expanded(
        //     child: Row(
        //       children: <Widget>[
        //         Expanded(
        //           child: Text('Create Address'),
        //         ),
        //         FlatButton(
        //           child: Text('Accept'),
        //           onPressed: () {

        //           },
        //         )
        //       ],
        //     ),
        //   )
        // ],
        centerTitle: true,
      ),
      body:  _isLoading 
        ? 
        Center(
          child: CircularProgressIndicator(),
        )
        : Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: _addAddressFormGlobalKey,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 18,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Definition'
                      ),
                      validator: ( val ) {
                        if ( val.isEmpty 
                          || Provider.of<AuthProvider>(context).customerModel.addressList.indexWhere(
                              (element) => element.definition == val
                            ) >= 0
                          || val.length < 2
                        ) {
                          return 'Definition has problems!';
                        }
                      },
                      focusNode: _definitionFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: ( _ ) {
                        FocusScope.of(context).requestFocus(
                          _receiverFocusNode
                        );
                      },
                      onSaved: ( val ) {
                        _formData = AddressModel(
                          definition: val,
                          receiver: _formData.receiver,
                          addressString: _formData.addressString,
                          city: _formData.city
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Receiver'
                      ),
                      validator: ( val ) {
                        if ( val.isEmpty 
                          || val.length < 2
                        ) {
                          return 'Receiver is Empty';
                        }
                      },
                      focusNode: _receiverFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: ( _ ) {
                        FocusScope.of(context).requestFocus(
                          _addressStringFocusNode
                        );
                      },
                      onSaved: ( val ) {
                        _formData = AddressModel(
                          definition: _formData.definition,
                          receiver: val,
                          addressString: _formData.addressString,
                          city: _formData.city
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address',                                              
                      ),
                      validator: ( val ) {
                        if ( val.isEmpty 
                          || val.length < 8
                        ) {
                          return 'Address is too short!';
                        }
                      },
                      focusNode: _addressStringFocusNode,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      
                      onSaved: ( val ) {
                        _formData = AddressModel(
                          definition: _formData.definition,
                          receiver: _formData.receiver,
                          addressString: val,
                          city: _formData.city
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'City',                      
                      ),
                      validator: ( val ) {
                        if ( val.isEmpty 
                          || val.length < 3
                        ) {
                          return 'City name is too short!';
                        }
                      },
                      focusNode: _cityFocusNode,                      
                      onSaved: ( val ) {
                        _formData = AddressModel(
                          definition: _formData.definition,
                          receiver: _formData.receiver,
                          addressString: _formData.addressString,
                          city: val
                        );
                      },
                    ),

                    Container(
                      height: 40,
                      margin: EdgeInsets.only(
                        top: 18
                      ),
                      child: new SwitchListTile(
                        title: const Text('Save Address'),
                        value: _willSaveAddress,
                        onChanged: (value) {
                          setState(() {
                            _willSaveAddress = !_willSaveAddress;
                          });
                        },
                      ),
                    ),
                  
                    SizedBox(height: 18,),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}