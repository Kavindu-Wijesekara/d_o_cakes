import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:d_o_cakes/models/cake_model.dart';

class Cakes with ChangeNotifier {
  List<Cake> _cakes = [];

  List<Cake> get cakes {
    return [..._cakes];
  }

  Future<void> fetchCakes() async {
    await FirebaseFirestore.instance
        .collection('cakes')
        .where('status', isEqualTo: 'Enable')
        // .orderBy('uploadAt', descending: false)
        .get()
        .then(
      (QuerySnapshot cakeSnapshot) {
        _cakes = [];
        for (var element in cakeSnapshot.docs) {
          _cakes.insert(
            0,
            Cake(
              id: element.get('cakeId'),
              title: element.get('cakeTitle'),
              description: element.get('cakeDescription'),
              price: double.parse(
                element.get('price'),
              ),
              imageUrl: element.get('cakeImage'),
              cakeCategoryName: element.get('cakeCategory'),
              twoPrice: double.parse(
                element.get('twoKgPrice'),
              ),
              oldPrice: element.get('oldPrice') == ""
                  ? 0
                  : double.parse(element.get('oldPrice')),
              isPopular: true,
              status: element.get('status'),
            ),
          );
        }
      },
    );
  }

  Future<void> adminFetchAllCakes() async {
    await FirebaseFirestore.instance
        .collection('cakes')
        .orderBy('uploadAt', descending: false)
        .get()
        .then(
      (QuerySnapshot cakeSnapshot) {
        _cakes = [];
        for (var element in cakeSnapshot.docs) {
          _cakes.insert(
            0,
            Cake(
              id: element.get('cakeId'),
              title: element.get('cakeTitle'),
              description: element.get('cakeDescription'),
              price: double.parse(
                element.get('price'),
              ),
              imageUrl: element.get('cakeImage'),
              cakeCategoryName: element.get('cakeCategory'),
              twoPrice: double.parse(
                element.get('twoKgPrice'),
              ),
              oldPrice: element.get('oldPrice') == ""
                  ? 0
                  : double.parse(element.get('oldPrice')),
              isPopular: true,
              status: element.get('status'),
            ),
          );
        }
      },
    );
  }

  List<Cake> get popularCakes {
    return _cakes.where((element) => element.isPopular).toList();
  }

  Cake findById(String cakeId) {
    return _cakes.firstWhere((element) => element.id == cakeId);
  }

  List<Cake> findByCategory(String categoryName) {
    List<Cake> _categoryList = _cakes
        .where((element) => element.cakeCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Cake> searchQuery(String searchText) {
    List<Cake> _searchList = _cakes
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
}


// final List<Cake> _cakes = [
//     Cake(
//       id: 'chocC',
//       title: 'Chocolate Cake',
//       description:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante.',
//       price: 2000,
//       oldPrice: 2500,
//       imageUrl:
//           'https://images.unsplash.com/photo-1588195538326-c5b1e9f80a1b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
//       cakeCategoryName: 'Birthday Cakes',
//       twoPrice: 4000,
//       isPopular: false,
//       isFavorite: false,
//     ),
//     Cake(
//       id: 'FruitC',
//       title: 'Fruit Cake',
//       description:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante.',
//       price: 1000.00,
//       imageUrl:
//           'https://www.mybakingaddiction.com/wp-content/uploads/2011/10/lr-0953-720x720.jpg',
//       cakeCategoryName: 'Wedding Cakes',
//       twoPrice: 2000,
//       isPopular: true,
//       isFavorite: false,
//     ),
//     Cake(
//       id: 'RoseC',
//       title: 'Rose Cake',
//       description:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante.',
//       price: 3000,
//       oldPrice: 3500,
//       imageUrl:
//           'https://images.unsplash.com/photo-1606983340126-99ab4feaa64a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmlydGhkYXklMjBjYWtlc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
//       cakeCategoryName: 'Anniversary Cakes',
//       twoPrice: 6000,
//       isPopular: false,
//       isFavorite: false,
//     ),
//     Cake(
//       id: 'ButterC',
//       title: 'Butter Cake',
//       description:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante.',
//       price: 5000,
//       oldPrice: 5500,
//       imageUrl:
//           'https://storcpdkenticomedia.blob.core.windows.net/media/recipemanagementsystem/media/recipe-media-files/recipes/retail/x17/16714-birthday-cake-600x600.jpg?ext=.jpg',
//       cakeCategoryName: 'Birthday Cakes',
//       twoPrice: 6000,
//       isPopular: true,
//       isFavorite: false,
//     ),
//     Cake(
//       id: 'DripC',
//       title: 'Chocolate Dripple Cake',
//       description:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante.',
//       price: 2000,
//       oldPrice: 2500,
//       imageUrl:
//           'https://images.unsplash.com/photo-1588195538326-c5b1e9f80a1b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
//       cakeCategoryName: 'Anniversary Cakes',
//       twoPrice: 4000,
//       isPopular: true,
//       isFavorite: false,
//     ),
//     Cake(
//       id: 'VaniC',
//       title: 'Vanila Cake',
//       description:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at finibus purus. Nam bibendum mollis nisl at maximus. In sed nisl posuere, molestie metus id, ultricies orci. Curabitur porttitor venenatis scelerisque. Donec malesuada efficitur tincidunt. Donec lacus dolor, vulputate ac bibendum nec, bibendum vitae ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu placerat nulla, sodales feugiat lacus. Nunc tempus id turpis at pharetra. Sed id dolor ante.',
//       price: 2500,
//       oldPrice: 3000,
//       imageUrl:
//           'https://livforcake.com/wp-content/uploads/2017/07/black-forest-cake-thumb.jpg',
//       cakeCategoryName: 'Wedding Cakes',
//       twoPrice: 4000,
//       isPopular: false,
//       isFavorite: false,
//     ),
//   ];