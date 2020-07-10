import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Models
import '../../models/customer_model.dart';
// Credit Card Imports
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
// Screens
import '../order_address_details/order_address_details_screen.dart';
// Providers
import '../../providers/auth_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = '/order-details-screen';

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}


// -----------------------   STATE   --------------------------------
class _OrderDetailsScreenState extends State<OrderDetailsScreen> with SingleTickerProviderStateMixin {
  final _appbarBackgroundColor = Color.fromRGBO(208, 57, 28, 1);
  var _shipmentCompanyIndex = 0;
  TabController _tabController;
  var _selectedPaymentTabIndex = 0;
  List _paymentTabList;
  // Address variables
  List<AddressModel> _customerAddressList;
  AddressModel _selectedAddress;
  String _orderDeliverOption;
  int _selectedAddressIndex;
  // Credit Card Variables
  String _cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  // End of Credit Card Variables
  CreditCardModel _creditCardModel;
  CreditCardWidget _creditCardWidget;
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      _cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void _selectPaymentTab(int newIndex) {
    setState(() {
      _selectedPaymentTabIndex = newIndex;
    });
  }

  Widget _customerAddressWidget ({
    AddressModel selectedAddressModel
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          // width:  230 ,
          // color: Colors.yellow,
          // child: GestureDetector(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedAddressModel.definition
              ),
              Text(
                selectedAddressModel.receiver,
                overflow: TextOverflow.clip,
              ),
              Text(
                selectedAddressModel.addressString,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
          // ),
        ),
        Container(
          width: 40,
          height: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.orange,
            border: Border(
              left: BorderSide(
                // color: Color.fromRGBO(rgbBorderValue , rgbBorderValue, rgbBorderValue, 1),
                color: Colors.grey,
                width: 1
              ),
            )
          ),
          // color: ,
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 35,
          )
        )
      ],
    );
  }

  Widget _warehouseAddressWidget  () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          // width:  230 ,
          // color: Colors.yellow,
          // child: GestureDetector(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Tech Store'
              ),
              Text(
                'From Warehouse'
              ),
            ],
          ),
          // ),
        ),
        Container(
          width: 40,
          height: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.orange,
            border: Border(
              left: BorderSide(
                // color: Color.fromRGBO(rgbBorderValue , rgbBorderValue, rgbBorderValue, 1),
                color: Colors.grey,
                width: 1
              ),
            )
          ),
          // color: ,
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 35,
          )
        )
      ],
    );
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {      
      _creditCardWidget = new  CreditCardWidget(
        cardNumber: _cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        showBackView: isCvvFocused,
        animationDuration: Duration(milliseconds: 300),
      );
    });

    super.didChangeDependencies();
  }

  
  @override
  void initState() {
    super.initState();
    


    _creditCardWidget =   CreditCardWidget(
      cardNumber: _cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      animationDuration: Duration(milliseconds: 300),
    );
    
    _paymentTabList = [
      Text('Transfer'),
      Container(
        // height: 800,
        child: IntrinsicHeight(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                IntrinsicHeight(
                  child: _creditCardWidget
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: CreditCardForm(
                      onCreditCardModelChange: (val) {
                        setState(() {                          
                          _creditCardWidget = CreditCardWidget(
                            cardNumber :val.cardNumber,
                            expiryDate : val.expiryDate,
                            cardHolderName : val.cardHolderName,
                            cvvCode : val.cvvCode,
                            showBackView: false,
                            animationDuration: Duration(milliseconds: 300),
                          );
                        });
                        print('onCreditCardModelChange -> val ->');
                        this.setState(() {
                          _cardNumber = val.cardNumber;
                        });
                        print(val.cardNumber);
                        print('cardNumer ->');
                        print(_cardNumber);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Text('Paypal'),
    ];
    _tabController =  TabController(
      length: 3,
      initialIndex: _selectedPaymentTabIndex,
      vsync: this
    );

    
  } // End of initState

  @override
  Widget build(BuildContext context) {
    _customerAddressList = Provider.of<AuthProvider>(context).customerModel.addressList;
    _orderDeliverOption = Provider.of<AuthProvider>(context).orderDeliverOption;
    _selectedAddressIndex = Provider.of<AuthProvider>(context).selectedAddressIndex;
    if ( _customerAddressList.length > 0
      || _orderDeliverOption == 'shipment-to-address'
      || _selectedAddressIndex != null
    ) {
      _selectedAddress = _customerAddressList[_selectedAddressIndex];
    }




    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appbarBackgroundColor,
        title: Text('Order Details'),
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
                width: double.infinity,
                child: Card(                
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 12,
                    right: 12
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          top: 8,
                          left: 12
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Delivery Address',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('OrderDetailScreen -> Delivery Address Click');
                          Navigator.of(context).pushNamed(
                            OrderAddressDetailsScreen.routeName
                          );
                        },
                        child: Container(                      
                          height: 80,
                          margin: EdgeInsets.only(
                            top: 8,
                            left: 12,
                            right: 12,
                            bottom: 8
                          ),
                          padding: EdgeInsets.only(
                            top: 8,
                            left: 12,
                            bottom: 8
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey
                            ),
                            
                            borderRadius: BorderRadius.circular(5)
                            
                            // color: Colors.pink
                          ),
                          // child: GestureDetector(

                            child: ( _customerAddressList.length == 0 
                              || _orderDeliverOption == 'from-tech-store-warehouse'
                              )
                                ?
                                _warehouseAddressWidget()
                                :
                                _customerAddressWidget(
                                  selectedAddressModel: _selectedAddress
                                )
                          // ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 8,
                          left: 12
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Shipment Company',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsets.only(
                          left: 12,
                          bottom: 12
                        ),
                        child: DropdownButton(
                          items: [
                            DropdownMenuItem(
                              child: Text('Company 1'),
                              value: 0,                            
                            ),
                            DropdownMenuItem(    
                              child: Text('Company 2'), 
                              value: 1,
                            ),
                          ],
                          value: _shipmentCompanyIndex,
                          onChanged: (val) {
                            setState(() {
                              _shipmentCompanyIndex = val;
                            });
                          },
                        ),
                      ) 
                    ],
                  )
                ),
              ),
              // Payment Card
              Container(
                width: double.infinity,
                child: Card(                
                  margin: EdgeInsets.only(
                    top: 25,
                    left: 12,
                    right: 12,
                    bottom: 12,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          top: 8,
                          left: 12
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Payment Method',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                      ),
                      Container(                      
                        height: 80,
                        margin: EdgeInsets.only(
                          top: 8,
                          left: 12,
                          right: 12,
                          bottom: 8
                        ),
                        padding: EdgeInsets.only(
                          top: 8,
                          left: 12,
                          bottom: 8
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey
                          ),
                          
                          borderRadius: BorderRadius.circular(5)
                          
                          // color: Colors.pink
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.red,
                          indicatorColor: Colors.black,
                          onTap: (newIndex) {
                            _selectPaymentTab(newIndex);
                          },

                          // labelStyle: TextStyle(

                          // ),
                          unselectedLabelColor: Colors.grey,
                          tabs: <Widget>[
                            Tab(
                              text: 'Transfer',

                              // child: Text('dsffsdfsdfdsf'),

                            ),
                            Tab(text: 'Credit Card'),
                            Tab(text: 'Paypal'),
                          ],
                        ),                        
                      ),
                      _paymentTabList[_selectedPaymentTabIndex],
                      SizedBox(height: 12,),
                      
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