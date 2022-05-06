import 'package:d_o_cakes/provider/favs_provider.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:d_o_cakes/widgets/empty_wishlist.dart';
import 'package:d_o_cakes/widgets/wishlist_full.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  static const routeName = '/WishlistScreen';

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    return favsProvider.getFavsItems.isEmpty
        ? const Scaffold(
            body: EmptyWishlist(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlist(${favsProvider.getFavsItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'https://cdn-icons-png.flaticon.com/512/564/564619.png',
                        'Are you sure?',
                        'Do you want to clear your wishlist? ',
                        () => favsProvider.clearFavs(),
                        context);
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: favsProvider.getFavsItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                  value: favsProvider.getFavsItems.values.toList()[index],
                  child: WishlistFull(
                    cakeId: favsProvider.getFavsItems.keys.toList()[index],
                  ),
                );
              },
            ),
          );
  }
}
