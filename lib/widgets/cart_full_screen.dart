// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:d_o_cakes/inner_screens/cake_details.dart';
import 'package:d_o_cakes/models/cart_attr.dart';
import 'package:d_o_cakes/provider/cart_provider.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartFullScreen extends StatefulWidget {
  const CartFullScreen({
    Key? key,
    required this.cakeId,
  }) : super(key: key);

  final String cakeId;

  // final String id;
  // final String cakeId;
  // final double price;
  // final int quantity;
  // final String title;
  // final String imageUrl;

  @override
  _CartFullScreenState createState() => _CartFullScreenState();
}

class _CartFullScreenState extends State<CartFullScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final subTotal = cartAttr.price * cartAttr.quantity;
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 8.0, bottom: 10.0),
      child: Container(
        height: 175.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
          ),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 3),
              color: Colors.black38,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0)),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, CakeDetails.routeName,
                    arguments: widget.cakeId),
                child: Container(
                  width: 125,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        cartAttr.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartAttr.title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18.0,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textSelectionColor,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                    // const SizedBox(
                    //   height: 2.0,
                    // ),
                    // Text(
                    //   'Birthday Cake',
                    //   style: TextStyle(
                    //     fontSize: 13.0,
                    //     fontWeight: FontWeight.w400,
                    //     color:
                    //         themeChange.darkTheme ? Colors.white : Colors.grey,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Size : ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                            text: cartAttr.weight,
                          ),
                          TextSpan(
                            text: ' , ',
                          ),
                          TextSpan(
                            text: cartAttr.egg,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'Type: ',
                    //     style: TextStyle(
                    //       color: Theme.of(context).textSelectionColor,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: cartAttr.egg,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 2.0,
                    // ),
                    RichText(
                      text: TextSpan(
                        text: 'Message: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                            text: cartAttr.msg,
                            style: TextStyle(color: Colors.pink),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Delivery Date: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                            text: cartAttr.deliveryDate,
                            style: TextStyle(color: Colors.pink),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Delivery: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                            text: cartAttr.deliveryMethod,
                            style: TextStyle(color: Colors.pink),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Price: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                              text: 'Rs.',
                              style: TextStyle(color: Colors.pink)),
                          TextSpan(
                            text: cartAttr.price.toStringAsFixed(2),
                            style: TextStyle(color: Colors.pink),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Sub Total: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                              text: 'Rs.',
                              style: TextStyle(color: Colors.pink)),
                          TextSpan(
                            text: subTotal.toStringAsFixed(2),
                            style: TextStyle(color: Colors.pink),
                          ),
                        ],
                      ),
                    ),

                    // Row(
                    //   children: [
                    //     const Text(
                    //       'Rs.',
                    //       style: TextStyle(
                    //         fontSize: 13.0,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.pink,
                    //       ),
                    //     ),
                    //     Text(
                    //       documentSnapshot['price'].toString(),
                    //       style: const TextStyle(
                    //         fontSize: 15.0,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.pink,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   width: 30.0,
            // ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, bottom: 15.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: () {
                        globalMethods.showDialogg(
                            'https://cdn-icons-png.flaticon.com/512/564/564619.png',
                            'Are you sure?',
                            'Do you want to remove this from your cart? ',
                            () => cartProvider.removeItem(widget.cakeId),
                            context);
                      },
                      child: Icon(
                        EvaIcons.close,
                        color: Colors.red,
                        size: 25.0,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: cartAttr.quantity < 2
                              ? null
                              : () {
                                  cartProvider.reduceItemByOne(widget.cakeId);
                                },
                          child: SizedBox(
                            child: Icon(
                              EvaIcons.minus,
                              color: cartAttr.quantity < 2
                                  ? Colors.grey
                                  : themeChange.darkTheme
                                      ? Colors.white
                                      : Colors.black,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                        width: 40.0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            cartAttr.quantity.toString(),
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () {
                            cartProvider.addCakeToCart(
                              widget.cakeId,
                              cartAttr.price,
                              cartAttr.title,
                              cartAttr.imageUrl,
                              cartAttr.egg,
                              cartAttr.weight,
                              cartAttr.msg!,
                              cartAttr.deliveryDate,
                              cartAttr.deliveryMethod,
                            );
                          },
                          child: SizedBox(
                            child: Icon(
                              EvaIcons.plus,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
