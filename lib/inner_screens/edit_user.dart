// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditUserData extends StatefulWidget {
  const EditUserData({Key? key, required this.uid}) : super(key: key);

  final String? uid;

  @override
  _EditUserDataState createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final GlobalMethods _globalMethods = GlobalMethods();

  Future<void> getData() async {
    final DocumentSnapshot<Map<String, dynamic>>? userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .get();

    if (userDoc == null) {
      return;
    } else {
      if (mounted) {
        setState(() {
          _name.text = userDoc.get('name');
          _phoneNumber.text = userDoc.get('phoneNumber').toString();
          _address.text = userDoc.get('address');
        });
      }
    }
  }

  Future<void> updateUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({
        'name': _name.text,
        'phoneNumber': _phoneNumber.text,
        'address': _address.text,
      });
    } on FirebaseAuthException catch (error) {
      _globalMethods.authErrorHandle('${error.message}', context);
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _address.dispose();
    _name.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Update User Details',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).textSelectionColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                TextFormField(
                  controller: _name,
                  onSaved: (value) {
                    _name.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    labelText: 'Full name',
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _phoneNumber,
                  onSaved: (value) {
                    _name.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    labelText: 'Phone number',
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _address,
                  onSaved: (value) {
                    _name.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    labelText: 'Address ',
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Colors.pink, Color.fromARGB(255, 223, 54, 138)],
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        alignment: Alignment.center,
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.only(
                              right: 50, left: 50, top: 15, bottom: 15),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        )),
                    onPressed: updateUser,
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
