import 'package:d_o_cakes/models/cart_attr.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.00;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  double get fee {
    var total = 0.00;
    var fee = 0.00;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
      fee = (total / 100) * 2.8;
    });
    return fee;
  }

  void addCakeToCart(
    String cakeId,
    double price,
    String title,
    String imageUrl,
    String egg,
    String weight,
    String msg,
    String deliveryDate,
    String deliveryMethod,
  ) {
    if (_cartItems.containsKey(cakeId)) {
      _cartItems.update(
          cakeId,
          (exitingCartItem) => CartAttr(
                id: exitingCartItem.id,
                cakeId: exitingCartItem.cakeId,
                title: exitingCartItem.title,
                price: exitingCartItem.price,
                imageUrl: exitingCartItem.imageUrl,
                msg: exitingCartItem.msg,
                deliveryDate: exitingCartItem.deliveryDate,
                deliveryMethod: exitingCartItem.deliveryMethod,
                egg: exitingCartItem.egg,
                quantity: exitingCartItem.quantity + 1,
                weight: exitingCartItem.weight,
              ));
    } else {
      _cartItems.putIfAbsent(
          cakeId,
          () => CartAttr(
                id: DateTime.now().toString(),
                cakeId: cakeId,
                title: title,
                egg: egg,
                weight: weight,
                msg: msg,
                deliveryDate: deliveryDate,
                deliveryMethod: deliveryMethod,
                quantity: 1,
                price: price,
                imageUrl: imageUrl,
              ));
    }
    notifyListeners();
  }

  void reduceItemByOne(String cakeId) {
    if (_cartItems.containsKey(cakeId)) {
      _cartItems.update(
          cakeId,
          (exitingCartItem) => CartAttr(
              id: exitingCartItem.id,
              cakeId: exitingCartItem.cakeId,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              imageUrl: exitingCartItem.imageUrl,
              msg: exitingCartItem.msg,
              deliveryDate: exitingCartItem.deliveryDate,
              deliveryMethod: exitingCartItem.deliveryMethod,
              egg: exitingCartItem.egg,
              quantity: exitingCartItem.quantity - 1,
              weight: exitingCartItem.weight));
    }
    notifyListeners();
  }

  void removeItem(String cakeId) {
    _cartItems.remove(cakeId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
