

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

  CustomerModel({
    this.id,
    this.email,
    this.balance
  });
}