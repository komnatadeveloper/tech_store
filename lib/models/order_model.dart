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
      this.productId,
      this.brand,
      this.productNo,
      this.keyProperties,
      this.mainImageId,
      this.price,
      this.quantity
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
    this.id,  // orderId
    this.customerId,
    this.address,
    this.items,
    this.date,
    this.orderTotalPrice,
  });
}