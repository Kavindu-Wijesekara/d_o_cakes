import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrdersAttr with ChangeNotifier {
  final String orderId;
  final String userId;
  final String cakeId;
  final String title;
  final double price;
  final double paid;
  final String imageUrl;
  final String quantity;
  final String weight;
  final String egg;
  final String? msg;
  final String deliveryDate;
  final String deliveryMethod;
  final String? deliveryAddress;
  final String? status;
  final Timestamp orderDate;

  OrdersAttr(
      {required this.orderId,
      required this.userId,
      required this.cakeId,
      required this.title,
      required this.price,
      required this.paid,
      required this.imageUrl,
      required this.quantity,
      required this.weight,
      required this.egg,
      this.msg,
      required this.deliveryDate,
      required this.deliveryMethod,
      this.deliveryAddress,
      this.status,
      required this.orderDate});
}
