import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String id;
  final String title;
  final String cakeId;
  final String egg;
  final String weight;
  final double price;
  final String imageUrl;
  final String? msg;
  final String deliveryDate;
  final String deliveryMethod;
  final int quantity;

  CartAttr(
      {required this.id,
      required this.title,
      required this.cakeId,
      required this.egg,
      required this.weight,
      required this.price,
      this.msg,
      required this.deliveryDate,
      required this.deliveryMethod,
      required this.imageUrl,
      required this.quantity});
}
