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
  final _definitionFocusNode = FocusNode();
  final _receiverFocusNode = FocusNode();
  final _addressStringFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();

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
        title: Text('Create new Address'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _addAddressFormGlobalKey,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Address Definition'
                    ),
                    focusNode: _receiverFocusNode,
                    onSaved: ( val ) {
                      _formData = AddressModel(
                        definition: val,
                        receiver: _formData.receiver,
                        addressString: _formData.addressString,
                        city: _formData.city
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),


      ),
      
    );
  }
}