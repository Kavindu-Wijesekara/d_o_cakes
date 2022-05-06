import 'package:flutter/cupertino.dart';

class Cake with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  double? oldPrice;
  final String imageUrl;
  final String cakeCategoryName;
  final double twoPrice;
  late final String status;
  bool? isFavorite;
  final bool isPopular;

  Cake(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      this.oldPrice,
      required this.imageUrl,
      required this.cakeCategoryName,
      required this.twoPrice,
      required this.status,
      this.isFavorite,
      required this.isPopular});
}
