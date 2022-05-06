// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:d_o_cakes/const/constants.dart';
import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/provider/cart_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key, required this.cakeId}) : super(key: key);

  final String cakeId;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  late List<bool> isSelectedWeight;
  late List<bool> isSelectedMix;
  final TextEditingController _msg = TextEditingController();
  final TextEditingController _dT = TextEditingController();
  final TextEditingController _dTController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  final TextEditingController _deliveryM = TextEditingController();
  String? _deliveryS;
  double weightPrice = 0;
  String weight = '';
  String egg = '';
  final dateTimeNow = DateTime.now();
  late DateTime dateTime = DateTime.now();

  @override
  void initState() {
    isSelectedWeight = [false, false];
    isSelectedMix = [false, false];
    super.initState();
  }

  // void _tryAddToCart() {}

  @override
  Widget build(BuildContext context) {
    final cakeData = Provider.of<Cakes>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cakeAttr = cakeData.findById(widget.cakeId);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.78,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cakeAttr.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textSelectionColor,
                            ),
                          ),
                          Text(
                            cakeAttr.cakeCategoryName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            cakeAttr.oldPrice == 0
                                ? ''
                                : 'Rs.${cakeAttr.oldPrice!.toStringAsFixed(2)}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Rs.${cakeAttr.price.toStringAsFixed(2)}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.w500,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Text(
                  'Size',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                ToggleButtons(
                  isSelected: isSelectedWeight,
                  selectedColor: Colors.white,
                  color: Colors.black,
                  fillColor: Colors.pinkAccent,
                  // selectedBorderColor: Colors.red,
                  renderBorder: true,
                  borderWidth: 2.0,
                  borderRadius: BorderRadius.circular(10.0),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Text(
                        '1Kg',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Text(
                        '2Kg',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    if (index == 0) {
                      setState(() {
                        weightPrice = cakeAttr.price;
                        weight = '1Kg';
                      });
                      // print(weightPrice);
                    } else {
                      setState(() {
                        weightPrice = cakeAttr.twoPrice;
                        weight = '2Kg';
                      });
                      // print(weightPrice);
                    }
                    setState(
                      () {
                        for (int i = 0; i < isSelectedWeight.length; i++) {
                          if (i == index) {
                            isSelectedWeight[i] = true;
                          } else {
                            isSelectedWeight[i] = false;
                          }
                        }
                      },
                    );
                  },
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Text(
                  'Type',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                ToggleButtons(
                  isSelected: isSelectedMix,
                  selectedColor: Colors.white,
                  color: Colors.black,
                  fillColor: Colors.pinkAccent,
                  // selectedBorderColor: Colors.red,
                  renderBorder: true,
                  borderWidth: 2.0,
                  borderRadius: BorderRadius.circular(10.0),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Text(
                        'With Egg',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Text(
                        'Eggless',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    if (index == 0) {
                      setState(() {
                        egg = 'With Egg';
                      });
                    } else {
                      setState(() {
                        egg = 'Eggless';
                      });
                    }
                    setState(
                      () {
                        for (int j = 0; j < isSelectedMix.length; j++) {
                          if (j == index) {
                            isSelectedMix[j] = true;
                          } else {
                            isSelectedMix[j] = false;
                          }
                        }
                      },
                    );
                  },
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.05,
                  color: Colors.transparent,
                ),
                TextFormField(
                  controller: _msg,
                  onSaved: (value) {
                    _msg.text = value!;
                  },
                  maxLength: 30,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Message on the cake.',
                    labelText: 'Message on the cake.',
                    helperText: 'Ex: Happy Birthday Mother!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.01,
                  color: Colors.transparent,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextFormField(
                        controller: _dTController,
                        textAlign: TextAlign.center,
                        decoration: kCakeUploadTextBoxStyle.copyWith(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5.0),
                          labelText: 'Choose the date and time',
                          filled: false,
                        ),
                        onSaved: (value) {
                          _dT.text = value!;
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () => _showSheet(
                          context,
                          child: dateTimePicker(),
                          onClicked: () {
                            final dT =
                                DateFormat.yMMMMd().add_jm().format(dateTime);
                            _dTController.text = dT;
                            Navigator.pop(context);
                          },
                        ),
                        child: Text('Choose'),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.02,
                  color: Colors.transparent,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Flexible(
                    //   flex: 3,
                    //   child: TextFormField(
                    //     controller: _deliveryController,
                    //     textAlign: TextAlign.center,
                    //     decoration: kCakeUploadTextBoxStyle.copyWith(
                    //       floatingLabelBehavior: FloatingLabelBehavior.never,
                    //       contentPadding:
                    //           const EdgeInsets.symmetric(horizontal: 5.0),
                    //       labelText: 'Delivery',
                    //       filled: false,
                    //     ),
                    //     key: ValueKey('Delivery'),
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Choose a delivery method.';
                    //       }
                    //       return null;
                    //     },
                    //     onSaved: (value) {
                    //       _deliveryM.text = value!;
                    //     },
                    //   ),
                    // ),
                    Flexible(
                      // flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextFormField(
                          controller: _deliveryController,
                          textAlign: TextAlign.center,
                          key: ValueKey('Delivery'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Choose a delivery method.';
                            }
                            return null;
                          },
                          readOnly: true,
                          decoration: kCakeUploadTextBoxStyle.copyWith(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            labelText: 'Delivery',
                            filled: false,
                          ),
                          onSaved: (value) {
                            _deliveryM.text = value!;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5.0,
                        right: 8.0,
                      ),
                      child: DropdownButton<String>(
                        // dropdownColor: themeChange.darkTheme
                        //     ? Theme.of(context).cardColor
                        //     : Colors.white,
                        elevation: 3,
                        underline: Container(),
                        items: const [
                          DropdownMenuItem<String>(
                            child: Text('Take away'),
                            value: 'Take away',
                            alignment: AlignmentDirectional.center,
                          ),
                          DropdownMenuItem<String>(
                            child: Text('To Address'),
                            value: 'Address',
                            alignment: AlignmentDirectional.center,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _deliveryS = value;
                            _deliveryController.text = value!;
                            //_controller.text= _cakeCategory;
                          });
                        },
                        hint: const Text('Select a delivery method'),
                        value: _deliveryS,
                        borderRadius: BorderRadius.circular(35.0),
                        iconEnabledColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.02,
                  color: Colors.transparent,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // print(dateTimeNow);
                    // print(dateTimeNow.difference(dateTime).inDays);
                    // print(_dTController.text);
                    // print(_deliveryController.text);
                    if (weightPrice == 0 || egg == '') {
                      Fluttertoast.showToast(
                        msg: "Please chosse the Size and Type.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0,
                      );
                    } else if (_dTController.text == '') {
                      Fluttertoast.showToast(
                        msg: "Please choose a date & time.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0,
                      );
                    } else if (dateTimeNow.difference(dateTime).inDays >= -2) {
                      Fluttertoast.showToast(
                        msg:
                            "Please Select the date, at least 3 business days from now.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0,
                      );
                    } else if (_deliveryController.text == '') {
                      Fluttertoast.showToast(
                        msg: "Please choose the delivery method.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0,
                      );
                    } else {
                      if (cartProvider.getCartItems
                          .containsKey(widget.cakeId)) {
                        Fluttertoast.showToast(
                          msg: "Already in the cart.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          fontSize: 12.0,
                        );
                      } else {
                        cartProvider.addCakeToCart(
                          widget.cakeId,
                          weightPrice,
                          cakeAttr.title,
                          cakeAttr.imageUrl,
                          egg,
                          weight,
                          _msg.text,
                          _dTController.text,
                          _deliveryController.text,
                        );
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text('Done!'),
                        //   backgroundColor: Colors.green,
                        //   duration: Duration(milliseconds: 1000),
                        // ));
                        Fluttertoast.showToast(
                          msg: "Added to the cart.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 12.0,
                        );
                      }
                    }
                  },

                  // cartProvider.getCartItems.containsKey(widget.cakeId)
                  //     ? null
                  //     : () {
                  //         cartProvider.addCakeToCart(
                  //             widget.cakeId,
                  //             cakeAttr.price,
                  //             cakeAttr.title,
                  //             cakeAttr.imageUrl);
                  //       },
                  label: Text(
                      cartProvider.getCartItems.containsKey(widget.cakeId)
                          ? 'In cart'
                          : 'Rs.${weightPrice.toStringAsFixed(2)}'),
                  // label: Text('Rs.$total'),
                  icon: const Icon(EvaIcons.shoppingCartOutline),
                  style: ElevatedButton.styleFrom(
                    primary:
                        cartProvider.getCartItems.containsKey(widget.cakeId)
                            ? Colors.grey
                            : Colors.pink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dateTimePicker() {
    return SizedBox(
      height: 150.0,
      child: CupertinoDatePicker(
        minimumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.dateAndTime,
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (dateTime) {
          setState(() {
            this.dateTime = dateTime;
          });
        },
      ),
    );
  }

  static void _showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: onClicked,
            child: Text('Done'),
          ),
        ),
      );
}


//   final birthday = DateTime(2022,03,05);
//   final date2 = DateTime.now();
//   final difference = date2.difference(birthday).inDays;
   
//    if(difference != -2){
//      print('plz place orders before 3 days');
//    } else {
//      print('Order done');
//    }