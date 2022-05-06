import 'package:flutter/material.dart';

class AdminCustomerScreen extends StatelessWidget {
  const AdminCustomerScreen({Key? key}) : super(key: key);

  static const routeName = '/AdminCustomerScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
    );
  }
}
