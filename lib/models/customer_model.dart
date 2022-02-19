

// import 'package:tech_store/models/address_model.dart';

class AddressModel {
  final String definition;
  final String receiver;
  final String addressString;
  final String city;
  String? id;

  AddressModel({
    required this.definition,
    required this.receiver,
    required this.addressString,
    required this.city,
  });
}

class SpecialPriceItemModel {
  final String id;
  final double price;
  SpecialPriceItemModel({
    required this.id,
    required this.price
  });
}


class CustomerModel {
  final String id;
  final String email;
  final double balance;
  List<String> orders = [];
  List<String> favorites = [];
  String? name;
  String? middleName;
  String? surName;
  String? tel1;
  String? tel2;
  List<AddressModel> addressList;
  List<SpecialPriceItemModel> specialPriceItems;

  CustomerModel({
    required this.id,
    required this.email,
    this.balance = 0,
    this.addressList = const [],
    this.specialPriceItems = const []
  });
}