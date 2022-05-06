// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/screens/admin_screens/admin_home.dart';
import 'package:d_o_cakes/screens/bottom_navy_bar.dart';
import 'package:d_o_cakes/screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends StatefulWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // String? _uid;
  @override
  Widget build(BuildContext context) {
    // User? user = _auth.currentUser;
    // _uid = user!.uid;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (userSnapshot.connectionState == ConnectionState.active) {
          if (userSnapshot.hasData) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (conext, snapshot) {
                if (snapshot.hasData) {
                  Center(child: CircularProgressIndicator());
                  final userData = snapshot.data;
                  if ((userData as dynamic)['role'] == 'admin') {
                    return AdminHomeScreen();
                  }
                }
                return BottomNavBar();
              },
            );
          } else {
            print('The user didn\'t login yet');
            return LandingScreen();
          }
        }
        return Center(
          child: Text('Error occured'),
        );
      },
    );
  }
}
