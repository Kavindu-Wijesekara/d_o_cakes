import 'package:d_o_cakes/screens/bottom_navy_bar.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  _drawerOptionTiles(Icon icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        color: Colors.white70,
        child: ListTile(
          leading: icon,
          title: Text(title),
          onTap: onTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    GlobalMethods globalMethods = GlobalMethods();
    return Drawer(
      backgroundColor: Colors.white24,
      child: Column(
        children: [
          Image.asset(
            'images/dils_oven_logo.png',
            height: 300.0,
            width: 300.0,
          ),
          _drawerOptionTiles(
            const Icon(Icons.people),
            'Customer Home',
            () => Navigator.pushNamed(context, BottomNavBar.routeName),
          ),
          _drawerOptionTiles(
            const Icon(Icons.logout_outlined),
            'Sign Out',
            () => globalMethods.showDialogg(
              'https://cdn-icons-png.flaticon.com/128/595/595067.png',
              'Sign out',
              'Do you want to Sign out?',
              () async {
                await _auth.signOut().then(
                      (value) => Navigator.pop(context),
                    );
              },
              context,
            ),
          ),
        ],
      ),
    );
  }
}
