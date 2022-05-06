import 'package:d_o_cakes/provider/admin_order_provider.dart';
import 'package:d_o_cakes/widgets/admin_order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminAllOrderTabView extends StatefulWidget {
  const AdminAllOrderTabView({Key? key}) : super(key: key);

  @override
  _AdminAllOrderTabViewState createState() => _AdminAllOrderTabViewState();
}

class _AdminAllOrderTabViewState extends State<AdminAllOrderTabView> {
  Future<void> _getOrdersOnRefresh() async {
    await Provider.of<AdminOrdersProvider>(context, listen: false)
        .adminFetchAllOrders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final adminOrderProvider = Provider.of<AdminOrdersProvider>(context);
    return FutureBuilder(
      future: adminOrderProvider.adminFetchAllOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return adminOrderProvider.getAdminOrders.isEmpty
            ? const Scaffold(
                body: Center(
                  child: Text(
                    'No Orders',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                backgroundColor: Colors.transparent,
              )
            : RefreshIndicator(
                onRefresh: _getOrdersOnRefresh,
                child: ListView.builder(
                  itemCount: adminOrderProvider.getAdminOrders.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: adminOrderProvider.getAdminOrders[index],
                      child: const AdminOrderCard(),
                    );
                  },
                ),
              );
      },
    );
  }
}

class AdminPendingOrderTabView extends StatefulWidget {
  const AdminPendingOrderTabView({Key? key}) : super(key: key);

  @override
  _AdminPendingOrderTabViewState createState() =>
      _AdminPendingOrderTabViewState();
}

class _AdminPendingOrderTabViewState extends State<AdminPendingOrderTabView> {
  Future<void> _getOrdersOnRefresh() async {
    await Provider.of<AdminOrdersProvider>(context, listen: false)
        .adminFetchPendingOrders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final adminOrderProvider = Provider.of<AdminOrdersProvider>(context);
    return FutureBuilder(
      future: adminOrderProvider.adminFetchPendingOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return adminOrderProvider.getAdminOrders.isEmpty
            ? const Scaffold(
                body: Center(
                  child: Text(
                    'No Orders',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                backgroundColor: Colors.transparent,
              )
            : RefreshIndicator(
                onRefresh: _getOrdersOnRefresh,
                child: ListView.builder(
                  itemCount: adminOrderProvider.getAdminOrders.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: adminOrderProvider.getAdminOrders[index],
                      child: const AdminOrderCard(),
                    );
                  },
                ),
              );
      },
    );
  }
}

class AdminBakingOrderTabView extends StatefulWidget {
  const AdminBakingOrderTabView({Key? key}) : super(key: key);

  @override
  _AdminBakingOrderTabViewState createState() =>
      _AdminBakingOrderTabViewState();
}

class _AdminBakingOrderTabViewState extends State<AdminBakingOrderTabView> {
  Future<void> _getOrdersOnRefresh() async {
    await Provider.of<AdminOrdersProvider>(context, listen: false)
        .adminFetchBakingOrders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final adminOrderProvider = Provider.of<AdminOrdersProvider>(context);
    return FutureBuilder(
      future: adminOrderProvider.adminFetchBakingOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return adminOrderProvider.getAdminOrders.isEmpty
            ? const Scaffold(
                body: Center(
                  child: Text(
                    'No Orders',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                backgroundColor: Colors.transparent,
              )
            : RefreshIndicator(
                onRefresh: _getOrdersOnRefresh,
                child: ListView.builder(
                  itemCount: adminOrderProvider.getAdminOrders.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: adminOrderProvider.getAdminOrders[index],
                      child: const AdminOrderCard(),
                    );
                  },
                ),
              );
      },
    );
  }
}

class AdminReadyOrderTabView extends StatefulWidget {
  const AdminReadyOrderTabView({Key? key}) : super(key: key);

  @override
  _AdminReadyOrderTabViewState createState() => _AdminReadyOrderTabViewState();
}

class _AdminReadyOrderTabViewState extends State<AdminReadyOrderTabView> {
  Future<void> _getOrdersOnRefresh() async {
    await Provider.of<AdminOrdersProvider>(context, listen: false)
        .adminFetchReadyOrders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final adminOrderProvider = Provider.of<AdminOrdersProvider>(context);
    return FutureBuilder(
      future: adminOrderProvider.adminFetchReadyOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return adminOrderProvider.getAdminOrders.isEmpty
            ? const Scaffold(
                body: Center(
                  child: Text(
                    'No Orders',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                backgroundColor: Colors.transparent,
              )
            : RefreshIndicator(
                onRefresh: _getOrdersOnRefresh,
                child: ListView.builder(
                  itemCount: adminOrderProvider.getAdminOrders.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: adminOrderProvider.getAdminOrders[index],
                      child: const AdminOrderCard(),
                    );
                  },
                ),
              );
      },
    );
  }
}
