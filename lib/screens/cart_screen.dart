// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/provider/cart_provider.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:d_o_cakes/services/payhere_credentials.dart';
import 'package:d_o_cakes/widgets/cart_full_screen.dart';
import 'package:d_o_cakes/widgets/empty_cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/CartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? paymentStatus;
  final TextEditingController _addressCtrl = TextEditingController();
  late double totalAmount;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods globalMethods = GlobalMethods();
  String? _uid;
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _address;

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot<Map<String, dynamic>>? userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc == null) {
      return;
    } else {
      if (mounted) {
        setState(() {
          _name = userDoc.get('name');
          _email = user.email;
          _phoneNumber = userDoc.get('phoneNumber').toString();
          _address = userDoc.get('address');
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    paymentStatus = "Not Paid";
    getData();
  }

  Map paymentObjectOneTime = {
    "sandbox": true,
    "merchant_id": PayHereAccountCredentials().merchantId,
    "merchant_secret": PayHereAccountCredentials().merchantSecret,
    "notify_url": "http://sample.com/notify",
    "order_id": "ItemNo12345",
    "items": "One Time Payment",
  };

  void setPaymentStatus(String status) {
    setState(() {
      paymentStatus = status;
      debugPrint(status);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // paymentObjectOneTime.update(
    //     "amount", ((value) => (cartProvider.totalAmount + cartProvider.fee)));
    paymentObjectOneTime.addAll(
      {
        "amount": (cartProvider.totalAmount + cartProvider.fee),
        "currency": "LKR",
        "first_name": _name,
        "last_name": "",
        "email": _email,
        "phone": _phoneNumber,
        "address": _addressCtrl.text.isEmpty ? _address : _addressCtrl.text,
        "city": "",
        "country": "Sri Lanka",
        "delivery_address": "",
        "delivery_city": "",
        "delivery_country": "Sri Lanka",
        "custom_1": "",
        "custom_2": ""
      },
    );

    return cartProvider.getCartItems.isEmpty
        ? const Scaffold(
            body: CartEmptyScreen(),
          )
        : Scaffold(
            bottomSheet: checkoutSection(
                context, cartProvider.totalAmount, cartProvider.fee),
            appBar: AppBar(
              title: Text('Cart (${cartProvider.getCartItems.length})'),
              // backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'https://cdn-icons-png.flaticon.com/512/564/564619.png',
                        'Are you sure?',
                        'Do you want to clear your cart? ',
                        () => cartProvider.clearCart(),
                        context);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60.0),
              child: ListView.builder(
                itemCount: cartProvider.getCartItems.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                    value: cartProvider.getCartItems.values.toList()[index],
                    child: CartFullScreen(
                      cakeId: cartProvider.getCartItems.keys.toList()[index],
                      // id: cartProvider.getCartItems.values.toList()[index].id,
                      // cakeId: cartProvider.getCartItems.values
                      //     .toList()[index]
                      //     .toString(),
                      // price: cartProvider.getCartItems.values
                      //     .toList()[index]
                      //     .price,
                      // title: cartProvider.getCartItems.values
                      //     .toList()[index]
                      //     .title,
                      // imageUrl: cartProvider.getCartItems.values
                      //     .toList()[index]
                      //     .imageUrl,
                      // quantity: cartProvider.getCartItems.values
                      //     .toList()[index]
                      //     .quantity,
                    ),
                  );
                },
              ),
            ),
          );
  }

  Widget checkoutSection(BuildContext context, double subtotal, double fee) {
    final cartProvider = Provider.of<CartProvider>(context);
    var uuid = Uuid();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    final _uid = user!.uid;

    payNow() {
      PayHere.startPayment(
        paymentObjectOneTime,
        (paymentId) {
          debugPrint("One Time Payment Success. Payment Id: $paymentId");
          setPaymentStatus("Successful");
          // if (paymentStatus == 'Successful') {
          cartProvider.getCartItems.forEach(
            (key, orderValue) async {
              final orderId = uuid.v4();
              try {
                await FirebaseFirestore.instance
                    .collection('orders')
                    .doc(orderId)
                    .set(
                  {
                    'orderId': orderId,
                    'userId': _uid,
                    'cakeId': orderValue.cakeId,
                    'title': orderValue.title,
                    'imageUrl': orderValue.imageUrl,
                    'price': orderValue.price,
                    'paid': orderValue.price * orderValue.quantity,
                    'egg': orderValue.egg,
                    'weight': orderValue.weight,
                    'msg': orderValue.msg,
                    'deliveryDate': orderValue.deliveryDate,
                    'deliveryMethod': orderValue.deliveryMethod,
                    'deliveryAddress': _addressCtrl.text,
                    'status': 'Pending',
                    'quantity': orderValue.quantity,
                    'orderDate': Timestamp.now(),
                  },
                );
                cartProvider.clearCart();
              } on FirebaseAuthException catch (error) {
                debugPrint('error $error');
              }
            },
          );
          // }
        },
        (error) {
          debugPrint("One Time Payment Failed. Error: $error");
          setPaymentStatus("Failed");
          globalMethods.authErrorHandle(error, context);
        },
        () {
          debugPrint("One Time Payment Dismissed");
          setPaymentStatus("Dismissed");
        },
      );
    }

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 4.0, left: 15.0, right: 15.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          'Fee',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Rs.${subtotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          'Rs.${fee.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.pink,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30.0),
                  // onTap: () async {
                  //   User? user = _auth.currentUser;
                  //   final _uid = user!.uid;
                  //   cartProvider.getCartItems.forEach((key, orderValue) async {
                  //     final orderId = uuid.v4();
                  //     try {
                  //       await FirebaseFirestore.instance
                  //           .collection('orders')
                  //           .doc(orderId)
                  //           .set({
                  //         'orderId': orderId,
                  //         'userId': _uid,
                  //         'cakeId': orderValue.cakeId,
                  //         'title': orderValue.title,
                  //         'imageUrl': orderValue.imageUrl,
                  //         'price': orderValue.price,
                  //         'paid': orderValue.price * orderValue.quantity,
                  //         'egg': orderValue.egg,
                  //         'weight': orderValue.weight,
                  //         'msg': orderValue.msg,
                  //         'deliveryDate': orderValue.deliveryDate,
                  //         'deliveryMethod': orderValue.deliveryMethod,
                  //         'status': 'Pending',
                  //         'quantity': orderValue.quantity,
                  //         'orderDate': Timestamp.now(),
                  //       });
                  //       cartProvider.clearCart();
                  //     } on FirebaseAuthException catch (error) {
                  //       print('error $error');
                  //     }
                  //   });
                  // },
                  onTap: () {
                    user.isAnonymous
                        ? globalMethods.showDialogg(
                            "https://cdn-icons-png.flaticon.com/512/564/564619.png",
                            "Guest User",
                            "You are logged as a Guest user. Please register before placing your orders.",
                            () async {
                              await _auth.signOut().then((value) => {});
                            },
                            context,
                          )
                        : globalMethods.inputBox(
                            'https://img.icons8.com/color/344/address--v1.png',
                            'Delivery Address',
                            'If the profile address is not the delivery address, Please enter the delivery address or Else leave it blank',
                            _addressCtrl,
                            () {
                              payNow();
                            },
                            context,
                          );
                  },
                  // onTap: () async {
                  //   payNow();
                  //   debugPrint("After all $paymentStatus");
                  //   if (paymentStatus == 'Successful') {
                  //     cartProvider.getCartItems
                  //         .forEach((key, orderValue) async {
                  //       final orderId = uuid.v4();
                  //       try {
                  //         await FirebaseFirestore.instance
                  //             .collection('orders')
                  //             .doc(orderId)
                  //             .set({
                  //           'orderId': orderId,
                  //           'userId': _uid,
                  //           'cakeId': orderValue.cakeId,
                  //           'title': orderValue.title,
                  //           'imageUrl': orderValue.imageUrl,
                  //           'price': orderValue.price,
                  //           'paid': orderValue.price * orderValue.quantity,
                  //           'egg': orderValue.egg,
                  //           'weight': orderValue.weight,
                  //           'msg': orderValue.msg,
                  //           'deliveryDate': orderValue.deliveryDate,
                  //           'deliveryMethod': orderValue.deliveryMethod,
                  //           'deliveryAddress': _addressCtrl.text,
                  //           'status': 'Pending',
                  //           'quantity': orderValue.quantity,
                  //           'orderDate': Timestamp.now(),
                  //         });
                  //         cartProvider.clearCart();
                  //       } on FirebaseAuthException catch (error) {
                  //         debugPrint('error $error');
                  //       }
                  //     });
                  //   } else if (paymentStatus == "Failed") {
                  //     globalMethods.authErrorHandle("", context);
                  //   }
                  // },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                        ),
                        Text(
                          'Rs.${(subtotal + fee).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
