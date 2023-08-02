import 'package:mgahawa_app/models/userModel.dart';

class Order {
  int? id;
  String? orderNumber;
  int? status;
  User? user;

  Order(
      {required this.id,
      required this.orderNumber,
      required this.status,
      required this.user});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        orderNumber: json['order_number'],
        status: json['status'],
        user: json['user'] != null ? User.fromJson(json['user']) : null);
  }
}
