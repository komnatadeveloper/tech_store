import 'package:flutter/material.dart';
// Models
import '../../models/address_model.dart';


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
  // focus nodes
  final _definitionFocusNode = FocusNode();
  final _receiverFocusNode = FocusNode();
  final _addressStringFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  // global key
  final _addAddressFormGlobalKey = GlobalKey<FormState>();


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
              onPressed: () {

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
      body: Container(
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