// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:d_o_cakes/inner_screens/cake_details.dart';
import 'package:d_o_cakes/models/order_attr.dart';
// import 'package:d_o_cakes/provider/dark_theme.dart';
// import 'package:d_o_cakes/services/global_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderFull extends StatefulWidget {
  const OrderFull({Key? key}) : super(key: key);

  @override
  _OrderFullState createState() => _OrderFullState();
}

class _OrderFullState extends State<OrderFull> {
  @override
  Widget build(BuildContext context) {
    // GlobalMethods globalMethods = GlobalMethods();
    // final themeChange = Provider.of<DarkThemeProvider>(context);
    final ordersAttr = Provider.of<OrdersAttr>(context);
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 8.0, bottom: 10.0),
      child: Container(
        height: 210.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
          ),
          color: Theme.of(context).cardColor,
          boxShadow: const [
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
                    arguments: ordersAttr.cakeId),
                child: Container(
                  width: 125,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        ordersAttr.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ordersAttr.title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18.0,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textSelectionColor,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Size : ',
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                            ),
                            children: [
                              TextSpan(
                                text: ordersAttr.weight,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Type: ',
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                            ),
                            children: [
                              TextSpan(
                                text: ordersAttr.egg,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Message: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                            text: ordersAttr.msg,
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
                        text: 'Quantity: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                              text: ordersAttr.quantity,
                              style: TextStyle(color: Colors.pink)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Delivery date: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                              text: ordersAttr.deliveryDate,
                              style: TextStyle(color: Colors.pink)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Delivery method: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                        children: [
                          TextSpan(
                              text: ordersAttr.deliveryMethod,
                              style: TextStyle(color: Colors.pink)),
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
                            text: ordersAttr.price.toStringAsFixed(2),
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
                            text: ordersAttr.paid.toStringAsFixed(2),
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
                        text: 'Status: ',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: ordersAttr.status,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ordersAttr.status == 'Pending'
                                  ? Colors.red
                                  : ordersAttr.status == 'Your cake is Baking'
                                      ? Colors.orange
                                      : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
