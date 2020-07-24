

// import 'package:tech_store/models/address_model.dart';

class AddressModel {
  final String definition;
  final String receiver;
  final String addressString;
  final String city;
  String id;

  AddressModel({
    this.definition,
    this.receiver,
    this.addressString,
    this.city
  });
}

class SpecialPriceItemModel {
  final String id;
  final double price;
  SpecialPriceItemModel({
    this.id,
    this.price
  });
}


class CustomerModel {
  final String id;
  final String email;
  final double balance;
  List<String> orders = [];
  List<String> favorites = [];
  String name;
  String middleName;
  String surName;
  String tel1;
  String tel2;
  List<AddressModel> addressList;
  List<SpecialPriceItemModel> specialPriceItems;

  CustomerModel({
    this.id,
    this.email,
    this.balance
  });
}