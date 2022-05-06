// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/models/order_attr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminOrderCard extends StatefulWidget {
  const AdminOrderCard({Key? key}) : super(key: key);

  @override
  State<AdminOrderCard> createState() => _AdminOrderCardState();
}

class _AdminOrderCardState extends State<AdminOrderCard> {
  String? _userId;
  String? _name;
  String? _email;
  String? _address;
  String? _orderId;
  String? _phoneNumber;

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  void getData() async {
    final DocumentSnapshot<Map<String, dynamic>>? userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();

    if (userDoc == null) {
      return;
    } else {
      if (mounted) {
        setState(() {
          _name = userDoc.get('name');
          _email = userDoc.get('email');
          _phoneNumber = userDoc.get('phoneNumber').toString();
          _address = userDoc.get('address');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersAttr = Provider.of<OrdersAttr>(context);

    setState(() {
      _userId = ordersAttr.userId;
      _orderId = ordersAttr.orderId;
      getData();
    });

    return Padding(
      padding: const EdgeInsets.only(
        left: 5.0,
        right: 5.0,
        bottom: 8.0,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          color: Colors.white70,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  'Order ID: ${ordersAttr.cakeId}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Delivery Date : ',
                    style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                    ),
                    children: [
                      TextSpan(
                        text: ordersAttr.deliveryDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Delivery Method : ',
                    style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                    ),
                    children: [
                      TextSpan(
                        text: ordersAttr.deliveryMethod,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Delivery Address : ',
                    style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                    ),
                    children: [
                      TextSpan(
                        text: ordersAttr.deliveryAddress == ""
                            ? _address
                            : ordersAttr.deliveryAddress,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    child: InkWell(
                      // onTap: () => Navigator.pushNamed(
                      //     context, CakeDetails.routeName,
                      //     arguments: ordersAttr.cakeId),
                      child: Container(
                        width: 150,
                        height: 150,
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ordersAttr.title,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15.0,
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
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
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
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: 'Message: ',
                              style: TextStyle(
                                color: Theme.of(context).textSelectionColor,
                              ),
                              children: [
                                TextSpan(
                                  text: ordersAttr.msg,
                                  style: const TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                  style: const TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Paid: ',
                              style: TextStyle(
                                color: Theme.of(context).textSelectionColor,
                              ),
                              children: [
                                TextSpan(
                                  text: ordersAttr.paid.toStringAsFixed(2),
                                  style: const TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  // height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Customer Details'),
                      const SizedBox(
                        height: 2.0,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Name: ',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                          children: [
                            TextSpan(
                              text: _name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Email: ',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                          children: [
                            TextSpan(
                              text: _email,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Phone No: ',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                          children: [
                            TextSpan(
                              text: _phoneNumber.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Address: ',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                          children: [
                            TextSpan(
                              text: _address,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Order Status: ',
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                  ),
                  children: [
                    TextSpan(
                      text: ordersAttr.status,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        color: ordersAttr.status == 'Pending'
                            ? Colors.red
                            : ordersAttr.status == 'Your cake is Baking'
                                ? const Color.fromARGB(255, 209, 120, 4)
                                : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: ordersAttr.status == 'Pending'
                          ? null
                          : () {
                              setOrderStatus('Pending');
                            },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 7.0, right: 7.0),
                        child: Text('Pending'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: ordersAttr.status == 'Your cake is Baking'
                          ? null
                          : () {
                              setOrderStatus('Your cake is Baking');
                            },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text('Baking'),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ordersAttr.status == 'Your cake is Baking'
                              ? Colors.grey
                              : Colors.orange,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: ordersAttr.status == 'Your cake is Ready'
                          ? null
                          : () {
                              setOrderStatus('Your cake is Ready');
                            },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Text('Ready'),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ordersAttr.status == 'Your cake is Ready'
                              ? Colors.grey
                              : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setOrderStatus(String status) async {
    await FirebaseFirestore.instance.collection('orders').doc(_orderId).update(
      {
        'status': status,
      },
    );
  }
}
