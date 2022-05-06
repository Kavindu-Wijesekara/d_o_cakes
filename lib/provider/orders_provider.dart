import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/models/order_attr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrdersProvider with ChangeNotifier {
  final List<OrdersAttr> _orders = [];

  List<OrdersAttr> get getOrders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user = _auth.currentUser;
    var _uid = _user?.uid;
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: _uid)
        .get()
        .then(
      (QuerySnapshot ordersSnapshot) {
        _orders.clear();
        for (var element in ordersSnapshot.docs) {
          _orders.insert(
            0,
            OrdersAttr(
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              cakeId: element.get('cakeId'),
              title: element.get('title'),
              price: element.get('price'),
              paid: element.get('paid'),
              imageUrl: element.get('imageUrl'),
              quantity: element.get('quantity').toString(),
              weight: element.get('weight'),
              egg: element.get('egg'),
              msg: element.get('msg'),
              deliveryDate: element.get('deliveryDate'),
              deliveryMethod: element.get('deliveryMethod'),
              status: element.get('status'),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      },
    );
  }
}
