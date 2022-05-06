// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_o_cakes/screens/admin_screens/admin_cakes_screen.dart';
import 'package:d_o_cakes/screens/admin_screens/admin_orders_screen.dart';
import 'package:d_o_cakes/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  static const routeName = '/AdminHomeScreen';

  @override
  Widget build(BuildContext context) {
    return Container(
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
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                bottom: 10.0,
                top: 10.0,
              ),
              child: Text(
                'Hey, Welcome Back',
                style: GoogleFonts.getFont(
                  'Nunito',
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 190 / 130,
                children: [
                  GestureDetector(
                    onTap: (() => Navigator.pushNamed(
                        context, AdminOrderScreen.routeName)),
                    child: homeTile(
                      'Orders',
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: (() => Navigator.pushNamed(
                        context, AdminCakeScreen.routeName)),
                    child: homeTile(
                      'Cakes',
                      Icons.cake_outlined,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: (() => Navigator.pushNamed(
                  //       context, AdminCustomerScreen.routeName)),
                  //   child: homeTile(
                  //     'Customers',
                  //     Icons.people_alt_outlined,
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: (() => Navigator.pushNamed(
                  //       context, AdminDashboardScreen.routeName)),
                  //   child: homeTile(
                  //     'Dashboard',
                  //     Icons.dashboard_outlined,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget homeTile(String _text, IconData _ico) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.white12,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _ico,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(height: 5.0),
                Text(
                  _text,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
