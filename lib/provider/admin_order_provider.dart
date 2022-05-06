import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/models/order_attr.dart';
import 'package:flutter/cupertino.dart';

class AdminOrdersProvider with ChangeNotifier {
  final List<OrdersAttr> _orders = [];

  List<OrdersAttr> get getAdminOrders {
    return [..._orders];
  }

  Future<void> adminFetchAllOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .orderBy('deliveryDate', descending: false)
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
              deliveryAddress: element.get('deliveryAddress'),
              status: element.get('status'),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      },
    );
  }

  Future<void> adminFetchPendingOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: 'Pending')
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
              deliveryAddress: element.get('deliveryAddress'),
              status: element.get('status'),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      },
    );
  }

  Future<void> adminFetchBakingOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: 'Your cake is Baking')
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
              deliveryAddress: element.get('deliveryAddress'),
              status: element.get('status'),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      },
    );
  }

  Future<void> adminFetchReadyOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: 'Your cake is Ready')
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
              deliveryAddress: element.get('deliveryAddress'),
              status: element.get('status'),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      },
    );
  }
}
