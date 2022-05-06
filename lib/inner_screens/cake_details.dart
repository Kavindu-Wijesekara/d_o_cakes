// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:d_o_cakes/inner_screens/add_to_cart.dart';
import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/provider/cart_provider.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/provider/favs_provider.dart';
import 'package:d_o_cakes/widgets/hero_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CakeDetails extends StatefulWidget {
  const CakeDetails({Key? key}) : super(key: key);

  static const routeName = '/CakeDetails';

  @override
  _CakeDetailsState createState() => _CakeDetailsState();
}

class _CakeDetailsState extends State<CakeDetails> {
  late List<bool> isSelectedWeight;
  late List<bool> isSelectedMix;

  int total = 0;
  int weightPrice = 0;
  int eggPrice = 0;
  // String? _msg;

  void totalPrice() {
    total = weightPrice + eggPrice;
    // return total;
  }

  @override
  void initState() {
    isSelectedWeight = [false, false];
    isSelectedMix = [false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cakeData = Provider.of<Cakes>(context);
    final cakeId = ModalRoute.of(context)!.settings.arguments as String;
    final cartProvider = Provider.of<CartProvider>(context);
    final favsProvider = Provider.of<FavsProvider>(context);

    // print('cake id $cakeId');
    final cakeAttr = cakeData.findById(cakeId);
    return Scaffold(
      body: Stack(
        children: [
          detailImage(context, cakeAttr.imageUrl),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 300.0,
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cakeAttr.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    cakeAttr.cakeCategoryName,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 300.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      cakeAttr.oldPrice == 0
                                          ? ''
                                          : 'Rs.${cakeAttr.oldPrice!.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2.0,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'Rs.${cakeAttr.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.pinkAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                          ),
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          cakeAttr.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.black38,
              actions: [
                Consumer<FavsProvider>(
                  builder: (_, favs, ch) => Badge(
                    badgeColor: Colors.pinkAccent,
                    animationType: BadgeAnimationType.fade,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 2, end: 2),
                    badgeContent: Text(
                      favs.getFavsItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      onPressed: () {
                        favsProvider.addAndRemoveFromFav(
                            cakeId,
                            cakeAttr.price,
                            cakeAttr.title,
                            cakeAttr.cakeCategoryName,
                            cakeAttr.imageUrl);
                      },
                      icon: favsProvider.getFavsItems.containsKey(cakeId)
                          ? Icon(EvaIcons.heart)
                          : Icon(EvaIcons.heartOutline),
                      splashRadius: 20.0,
                      color: favsProvider.getFavsItems.containsKey(cakeId)
                          ? Colors.pink
                          : Colors.white,
                      splashColor: Colors.pink,
                      highlightColor: Colors.transparent,
                      tooltip: 'Add to wishlist',
                    ),
                  ),
                ),
                Consumer<CartProvider>(
                  builder: (_, cart, ch) => Badge(
                    badgeColor: Colors.pink,
                    animationType: BadgeAnimationType.fade,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 2, end: 2),
                    badgeContent: Text(
                      cart.getCartItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        cartProvider.getCartItems.containsKey(
                          cakeAttr.id,
                        )
                            ? Icons.remove_shopping_cart
                            : Icons.add_shopping_cart,
                      ),
                      // splashRadius: 20.0,
                      color: cartProvider.getCartItems.containsKey(cakeId)
                          ? Colors.pink
                          : Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      tooltip: 'Add to cart',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                  splashRadius: 20.0,
                  splashColor: Colors.pink,
                  highlightColor: Colors.transparent,
                  tooltip: 'Share',
                ),
              ],
            ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(30.0),
          //   child: InkWell(
          //     onTap: () {
          //       setState(() {
          //         bottomSheet(context, cakeAttr, cartProvider, cakeId);
          //       });
          //     },
          //     child: Container(
          //       height: 50.0,
          //       width: 50.0,
          //       color: Colors.pink,
          //       child: Icon(
          //         Icons.add_shopping_cart,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(
            builder: (context) {
              return AddToCart(
                cakeId: cakeId,
              );
            },
          ));
        },
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width * 0.02,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Material(
            type: MaterialType.button,
            color: Colors.pink,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add to cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _showToast(BuildContext context) {
  //   final scaffold = ScaffoldMessenger.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: const Text('Added to favorite'),
  //       action: SnackBarAction(
  //           label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
  //     ),
  //   );
  // }

//Detail image

  Widget detailImage(BuildContext context, String url) {
    return Image.network(
      url,
      height: MediaQuery.of(context).size.height * 0.39999,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.contain,
    );
  }
}
