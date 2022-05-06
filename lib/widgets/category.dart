import 'package:d_o_cakes/inner_screens/category_feeds.dart';
import 'package:flutter/material.dart';

class CakeCategory extends StatelessWidget {
  CakeCategory({Key? key, required this.index}) : super(key: key);

  final int index;
  final List<Map<String, Object>> categories = [
    {
      'categoryName': 'Birthday Cake',
      'categoryImagePath': 'images/birthday.png'
    },
    {'categoryName': 'Wedding Cake', 'categoryImagePath': 'images/wedding.png'},
    {
      'categoryName': 'Anniversary Cake',
      'categoryImagePath': 'images/anniversary.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                CategoryFeedScreen.routeName,
                arguments: '${categories[index]['categoryName']}',
              );
              // print('${categories[index]['cakeCategoryName']}');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(
                        categories[index]['categoryImagePath'] as String),
                    fit: BoxFit.fill),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              width: 125.0,
              height: 125.0,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10.0,
            right: 10.0,
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Theme.of(context).cardColor,
              child: Text(
                categories[index]['categoryName'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).textSelectionColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
