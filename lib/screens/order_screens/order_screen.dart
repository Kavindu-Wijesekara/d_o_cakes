import 'package:d_o_cakes/provider/orders_provider.dart';
import 'package:d_o_cakes/screens/order_screens/order_empty.dart';
import 'package:d_o_cakes/screens/order_screens/order_full.dart';
// import 'package:d_o_cakes/services/global_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future<void> _getOrdersOnRefresh() async {
    await Provider.of<OrdersProvider>(context, listen: false).fetchOrders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // GlobalMethods globalMethods = GlobalMethods();
    final orderProvider = Provider.of<OrdersProvider>(context);

    return FutureBuilder(
      future: orderProvider.fetchOrders(),
      builder: (context, snapshot) {
        return orderProvider.getOrders.isEmpty
            ? const Scaffold(
                body: OrderEmpty(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text('Orders (${orderProvider.getOrders.length})'),
                ),
                body: RefreshIndicator(
                  onRefresh: _getOrdersOnRefresh,
                  child: ListView.builder(
                      itemCount: orderProvider.getOrders.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ChangeNotifierProvider.value(
                          value: orderProvider.getOrders[index],
                          child: const OrderFull(),
                        );
                      }),
                ),
              );
      },
    );
  }
}
