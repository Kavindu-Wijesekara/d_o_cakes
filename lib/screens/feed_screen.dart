import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/widgets/home_cakes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  static const routeName = '/FeedScreen';

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Future<void> _getCakesOnRefresh() async {
    await Provider.of<Cakes>(context, listen: false).fetchCakes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cakesProvider = Provider.of<Cakes>(context);
    return FutureBuilder(
        future: cakesProvider.fetchCakes(),
        builder: (context, snapshot) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: _getCakesOnRefresh,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 190 / 265,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: cakesProvider.cakes.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChangeNotifierProvider.value(
                    value: cakesProvider.cakes[index],
                    child: const HomeCakes(),
                  );
                },
              ),
            ),
          );
        });
  }
}
