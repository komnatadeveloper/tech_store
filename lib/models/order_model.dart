// Models
import './address_model.dart';

class OrderItemModel {
  final String productId;
  final String brand;
  final String productNo;
  final String keyProperties;
  final String mainImageId;
  final double price;
  final int quantity;
  OrderItemModel(
    {
      required this.productId,
      required this.brand,
      required this.productNo,
      required this.keyProperties,
      required this.mainImageId,
      required this.price,
      required this.quantity
    }
  );
}

class OrderModel {
  final String id;  // orderId
  final String customerId;
  final AddressModel address;
  final List<OrderItemModel> items;
  final DateTime date;
  final double orderTotalPrice;
  OrderModel({
    required this.id,  // orderId
    required this.customerId,
    required this.address,
    required this.items,
    required this.date,
    required this.orderTotalPrice,
  });
}