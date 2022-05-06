// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GlobalMethods {
  Future<void> showDialogg(String iconUrl, String title, String subtitle,
      Function fn, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.0),
                child: Image.network(
                  iconUrl,
                  height: 20.0,
                  width: 20.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title),
              ),
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  fn();
                  Navigator.pop(context);
                },
                child: Text('OK')),
          ],
        );
      },
    );
  }

  Future<void> inputBox(String iconUrl, String title, String subtitle,
      TextEditingController _address, Function fn, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Image.network(
                      iconUrl,
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title),
                  ),
                ],
              ),
              TextFormField(
                controller: _address,
                onSaved: (value) {
                  _address.text = value!;
                },
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: title,
                  labelText: title,
                  helperText: subtitle,
                  helperMaxLines: 5,
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
                onPressed: () {
                  fn();
                  Navigator.pop(context);
                },
                child: Text('Next')),
          ],
        );
      },
    );
  }

  Future<void> authErrorHandle(String subtitle, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 6.0),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/564/564619.png',
                    height: 20.0,
                    width: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Error occured'),
                ),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}
