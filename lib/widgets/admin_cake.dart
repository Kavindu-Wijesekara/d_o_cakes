// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/inner_screens/cake_details.dart';
import 'package:d_o_cakes/inner_screens/update_cake_details.dart';
import 'package:d_o_cakes/models/cake_model.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminCake extends StatefulWidget {
  const AdminCake({
    Key? key,
  }) : super(key: key);

  @override
  _AdminCakeState createState() => _AdminCakeState();
}

class _AdminCakeState extends State<AdminCake> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cakeAttributes = Provider.of<Cake>(context);
    GlobalMethods globalMethods = GlobalMethods();

    Future<void> deleteCake() async {
      await FirebaseFirestore.instance
          .collection('cakes')
          .doc(cakeAttributes.id)
          .delete()
          .then((_) => print('Deleted'))
          .catchError(
            (error) => print('Delete failed: $error'),
          );
      // await FirebaseStorage.instance
      //     .refFromURL(cakeAttributes.imageUrl)
      //     .delete();
    }

    Future<void> changeStatus(String status) async {
      await FirebaseFirestore.instance
          .collection('cakes')
          .doc(cakeAttributes.id)
          .update(
        {
          'status': status,
        },
      );
    }

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
            color: cakeAttributes.status == 'Disable'
                ? Colors.white54
                : Theme.of(context).cardColor,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cakeAttributes.cakeCategoryName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: cakeAttributes.status == 'Disable'
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Rs.${cakeAttributes.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                        PopupMenuButton(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Edit'),
                              value: 'edit',
                            ),
                            PopupMenuItem(
                              child: Text('Delete'),
                              value: 'del',
                              onTap: () {},
                            ),
                            PopupMenuItem(
                              child: cakeAttributes.status == 'Enable'
                                  ? Text('Disable')
                                  : Text('Enable'),
                              value: 'status',
                              onTap: () => cakeAttributes.status == 'Enable'
                                  ? changeStatus('Disable')
                                  : changeStatus('Enable'),
                            ),
                          ],
                          onSelected: (String value) {
                            if (value == 'edit') {
                              Navigator.pushNamed(
                                context,
                                UpdateCakeDetails.routeName,
                                arguments: cakeAttributes.id,
                              );
                              print(cakeAttributes.id);
                            } else if (value == 'del') {
                              globalMethods.showDialogg(
                                'https://cdn-icons-png.flaticon.com/512/564/564619.png',
                                'Delete the cake',
                                'Are you sure? This process can\'t be undo. ',
                                () => deleteCake(),
                                context,
                              );
                            }
                          },
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
