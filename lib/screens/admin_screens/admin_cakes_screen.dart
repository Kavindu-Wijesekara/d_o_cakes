import 'package:d_o_cakes/inner_screens/upload_new_cake.dart';
import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/widgets/admin_cake.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminCakeScreen extends StatefulWidget {
  const AdminCakeScreen({Key? key}) : super(key: key);

  static const routeName = '/AdminCakeScreen';

  @override
  State<AdminCakeScreen> createState() => _AdminCakeScreenState();
}

class _AdminCakeScreenState extends State<AdminCakeScreen> {
  Future<void> _getOrdersOnRefresh() async {
    await Provider.of<Cakes>(context, listen: false).adminFetchAllCakes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cakesProvider = Provider.of<Cakes>(context);
    return FutureBuilder(
        future: cakesProvider.adminFetchAllCakes(),
        builder: (context, snapshot) {
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
              appBar: AppBar(
                title: const Text(
                  'Cakes',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        UploadProductForm.routeName,
                      ),
                      child: const Tooltip(
                        message: 'Add New Cake',
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              body: RefreshIndicator(
                onRefresh: _getOrdersOnRefresh,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 190 / 265,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: cakesProvider.cakes.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cakesProvider.cakes[index],
                      child: const AdminCake(),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
