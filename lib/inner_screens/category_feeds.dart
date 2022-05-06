import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/widgets/home_cakes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryFeedScreen extends StatelessWidget {
  const CategoryFeedScreen({Key? key}) : super(key: key);

  static const routeName = '/CategoryFeedScreen';

  @override
  Widget build(BuildContext context) {
    final cakesProvider = Provider.of<Cakes>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    final cakeList = cakesProvider.findByCategory(categoryName);
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 190 / 265,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: List.generate(
          cakeList.length,
          (index) {
            return ChangeNotifierProvider.value(
              value: cakeList[index],
              child: const HomeCakes(),
            );
          },
        ),
      ),
    );
  }
}
