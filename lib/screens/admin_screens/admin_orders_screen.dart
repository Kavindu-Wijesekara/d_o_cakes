// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_o_cakes/inner_screens/admin_orders_tab_views.dart';
import 'package:flutter/material.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({Key? key}) : super(key: key);

  static const routeName = '/AdminOrderScreen';

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Color.fromARGB(255, 144, 46, 79),
            ],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Orders',
              style: TextStyle(fontSize: 15.0),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, right: 5.0, left: 5.0, bottom: 5.0),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  labelPadding: EdgeInsets.only(right: 2.0, left: 2.0),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Pending',
                    ),
                    Tab(
                      text: 'On Going',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AdminAllOrderTabView(),
                    AdminPendingOrderTabView(),
                    AdminBakingOrderTabView(),
                    AdminReadyOrderTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
