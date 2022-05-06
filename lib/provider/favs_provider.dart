import 'package:d_o_cakes/models/favs_attr.dart';
import 'package:flutter/cupertino.dart';

class FavsProvider with ChangeNotifier {
  final Map<String, FavsAttr> _favsItems = {};

  Map<String, FavsAttr> get getFavsItems {
    return {..._favsItems};
  }

  void addAndRemoveFromFav(String cakeId, double price, String title,
      String category, String imageUrl) {
    if (_favsItems.containsKey(cakeId)) {
      removeItem(cakeId);
    } else {
      _favsItems.putIfAbsent(
          cakeId,
          () => FavsAttr(
                id: DateTime.now().toString(),
                title: title,
                category: category,
                price: price,
                imageUrl: imageUrl,
              ));
    }
    notifyListeners();
  }

  void removeItem(String cakeId) {
    _favsItems.remove(cakeId);
    notifyListeners();
  }

  void clearFavs() {
    _favsItems.clear();
    notifyListeners();
  }
}
