// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:d_o_cakes/inner_screens/cake_details.dart';
import 'package:d_o_cakes/models/favs_attr.dart';
import 'package:d_o_cakes/provider/favs_provider.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistFull extends StatefulWidget {
  const WishlistFull({Key? key, required this.cakeId}) : super(key: key);

  final String cakeId;

  @override
  _WishlistFullState createState() => _WishlistFullState();
}

class _WishlistFullState extends State<WishlistFull> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    final favsAttr = Provider.of<FavsAttr>(context);

    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              // spreadRadius: 3,
              offset: Offset(3, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, CakeDetails.routeName,
                      arguments: widget.cakeId),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      favsAttr.imageUrl,
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        favsAttr.title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textSelectionColor,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        favsAttr.category,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Rs.${favsAttr.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  globalMethods.showDialogg(
                      'https://cdn-icons-png.flaticon.com/512/564/564619.png',
                      'Are you sure?',
                      'Do you want to remove this from your cart? ',
                      () => favsProvider.removeItem(widget.cakeId),
                      context);
                },
                icon: const Icon(
                  EvaIcons.close,
                  color: Colors.pink,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
