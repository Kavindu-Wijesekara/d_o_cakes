// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_o_cakes/inner_screens/add_to_cart.dart';
import 'package:d_o_cakes/inner_screens/cake_details.dart';
import 'package:d_o_cakes/models/cake_model.dart';
import 'package:d_o_cakes/provider/cart_provider.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/provider/favs_provider.dart';
import 'package:d_o_cakes/widgets/hero_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCakes extends StatefulWidget {
  const HomeCakes({
    Key? key,
  }) : super(key: key);

  @override
  _HomeCakesState createState() => _HomeCakesState();
}

class _HomeCakesState extends State<HomeCakes> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cakeAttributes = Provider.of<Cake>(context);
    final favsProvider = Provider.of<FavsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, CakeDetails.routeName,
            arguments: cakeAttributes.id),
        child: Container(
          height: 265.0,
          width: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          cakeAttributes.imageUrl,
                          height: 100.0,
                          width: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5.0,
                      top: 5.0,
                      child: InkWell(
                        onTap: () {
                          favsProvider.addAndRemoveFromFav(
                              cakeAttributes.id,
                              cakeAttributes.price,
                              cakeAttributes.title,
                              cakeAttributes.cakeCategoryName,
                              cakeAttributes.imageUrl);
                        },
                        child: CircleAvatar(
                          backgroundColor: favsProvider.getFavsItems
                                  .containsKey(cakeAttributes.id)
                              ? Colors.white38
                              : Colors.transparent,
                          radius: 15.0,
                          child: Icon(
                            favsProvider.getFavsItems
                                    .containsKey(cakeAttributes.id)
                                ? EvaIcons.heart
                                : EvaIcons.heartOutline,
                            size: 15.0,
                            color: favsProvider.getFavsItems
                                    .containsKey(cakeAttributes.id)
                                ? Colors.pink
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        cakeAttributes.title,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: themeChange.darkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        cakeAttributes.cakeCategoryName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs.${cakeAttributes.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(HeroDialogRoute(
                                builder: (context) {
                                  return AddToCart(
                                    cakeId: cakeAttributes.id,
                                  );
                                },
                              ));
                            },
                            child: Icon(
                              cartProvider.getCartItems.containsKey(
                                cakeAttributes.id,
                              )
                                  ? Icons.remove_shopping_cart
                                  : Icons.add_shopping_cart,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
