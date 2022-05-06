// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_o_cakes/models/cake_model.dart';
import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/widgets/category.dart';
import 'package:d_o_cakes/widgets/home_cakes.dart';
import 'package:d_o_cakes/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _getCakesOnRefresh() async {
    await Provider.of<Cakes>(context, listen: false).fetchCakes();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cakesData = Provider.of<Cakes>(context);
    List<Cake> popularItems = cakesData.popularCakes;
    cakesData.fetchCakes();
    return Scaffold(
      body: Column(
        children: [
          const HomeHeader(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Explore Catogories',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 140.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext ctx, int index) {
                return CakeCategory(index: index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Popular Deals',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _getCakesOnRefresh,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 190 / 265,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: List.generate(
                  popularItems.length,
                  (index) {
                    return ChangeNotifierProvider.value(
                      value: popularItems[index],
                      child: HomeCakes(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//             height: 150.0,
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//               child: Carousel(
//                 boxFit: BoxFit.cover,
//                 autoplay: true,
//                 animationCurve: Curves.fastOutSlowIn,
//                 animationDuration: Duration(milliseconds: 1000),
//                 dotSize: 3.0,
//                 dotBgColor: Colors.transparent,
//                 dotPosition: DotPosition.bottomCenter,
//                 showIndicator: true,
//                 indicatorBgPadding: 7.0,
//                 images: [
//                   Image.network(
//                       'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
//                   Image.network(
//                       'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F1542062283%2Fchocolate-and-cream-layer-cake-1812-cover.jpg%3Fitok%3DrEWL7AIN'),
//                   Image.network(
//                       'https://preppykitchen.com/wp-content/uploads/2019/06/Chocolate-cake-recipe-1200a.jpg'),
//                 ],
//               ),
//             ),
//           ),
