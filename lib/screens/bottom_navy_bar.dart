// ignore_for_file: deprecated_member_use

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/screens/cart_screen.dart';
import 'package:d_o_cakes/screens/feed_screen.dart';
import 'package:d_o_cakes/screens/home_screen.dart';
import 'package:d_o_cakes/screens/search_screen.dart';
import 'package:d_o_cakes/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  static const routeName = '/BottomNavBar';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPages(),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 4:
        return const UserScreen();
      // case 4:
      //   return WishlistScreen();
      case 3:
        return const CartScreen();
      case 2:
        return const SearchScreen();
      case 1:
        return const FeedScreen();
      case 0:
      default:
        return const HomeScreen();
    }
  }

  Widget buildBottomNavigation() {
    final changeTheme = Provider.of<DarkThemeProvider>(context);
    return BottomNavyBar(
      selectedIndex: index,
      onItemSelected: (index) => setState(() => this.index = index),
      backgroundColor: Theme.of(context).cardColor,
      items: [
        // BottomNavyBarItem(
        //   icon: const Icon(Icons.cake),
        //   title: const Text('Detail'),
        //   textAlign: TextAlign.center,
        //   activeColor: changeTheme.darkTheme ? Colors.white : Colors.pink,
        //   inactiveColor: Theme.of(context).textSelectionColor,
        // ),
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Home'),
          textAlign: TextAlign.center,
          activeColor: changeTheme.darkTheme ? Colors.white : Colors.pink,
          inactiveColor: Theme.of(context).textSelectionColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.cake),
          title: const Text('Feed'),
          textAlign: TextAlign.center,
          activeColor: changeTheme.darkTheme ? Colors.white : Colors.pink,
          inactiveColor: Theme.of(context).textSelectionColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.search),
          title: const Text('Search'),
          textAlign: TextAlign.center,
          activeColor: changeTheme.darkTheme ? Colors.white : Colors.pink,
          inactiveColor: Theme.of(context).textSelectionColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.shopping_cart),
          title: const Text('Cart'),
          textAlign: TextAlign.center,
          activeColor: changeTheme.darkTheme ? Colors.white : Colors.pink,
          inactiveColor: Theme.of(context).textSelectionColor,
        ),
        // BottomNavyBarItem(
        //   icon: const Icon(EvaIcons.heart),
        //   title: const Text('Wishlist'),
        //   textAlign: TextAlign.center,
        //   activeColor: changeTheme.darkTheme ? Colors.white : Colors.pink,
        //   inactiveColor: Theme.of(context).textSelectionColor,
        // ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          textAlign: TextAlign.center,
          activeColor: changeTheme.darkTheme ? Colors.white : Colors.pink,
          inactiveColor: Theme.of(context).textSelectionColor,
        ),
      ],
    );
  }
}
