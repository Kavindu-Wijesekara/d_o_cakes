// ignore_for_file: deprecated_member_use, unused_element, unused_field

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/const/constants.dart';
import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UpdateCakeDetails extends StatefulWidget {
  static const routeName = '/UpdateCakeDetails';

  const UpdateCakeDetails({Key? key, this.cakeId}) : super(key: key);
  final String? cakeId;

  @override
  _UpdateCakeDetailsState createState() => _UpdateCakeDetailsState();
}

class _UpdateCakeDetailsState extends State<UpdateCakeDetails> {
  late String _cakeId;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _cakeTitle = TextEditingController();
  final TextEditingController _cakePrice = TextEditingController();
  final TextEditingController _cakeTwoPrice = TextEditingController();
  final TextEditingController? _cakeOldPrice = TextEditingController();
  final TextEditingController _cakeCategory = TextEditingController();
  final TextEditingController _cakeDescription = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalMethods _globalMethods = GlobalMethods();
  String? _categoryValue;
  File? _pickedImage;
  bool _isLoading = false;
  late String url;
  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _cakeTitle.dispose();
    _cakePrice.dispose();
    _cakeTwoPrice.dispose();
    _cakeOldPrice!.dispose();
    _cakeDescription.dispose();
    _cakeCategory.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context, String title, String body) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _tryUpdate() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
    }
    if (isValid) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });
        // final ref = FirebaseStorage.instance
        //     .ref()
        //     .child('cakeImages')
        //     .child(_cakeTitle.text + '.jpg');
        // await ref.putFile(_pickedImage!);
        // url = await ref.getDownloadURL();

        final User user = _auth.currentUser!;
        final _uid = user.uid;

        await FirebaseFirestore.instance
            .collection('cakes')
            .doc(_cakeId)
            .update({
          'cakeId': _cakeId,
          'cakeTitle': _cakeTitle.text,
          'price': _cakePrice.text,
          'twoKgPrice': _cakeTwoPrice.text,
          'oldPrice': _cakeOldPrice!.text,
          'cakeCategory': _cakeCategory.text,
          'cakeDescription': _cakeDescription.text,
          'updatedUserId': _uid,
          'cakeImage': url,
          'updatedAt': DateTime.now(),
        });
      } on FirebaseAuthException catch (error) {
        _globalMethods.authErrorHandle('${error.message}', context);
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
    // widget.imagePickFn(pickedImageFile);
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  void _clearFeilds() {
    setState(() {
      _cakeTitle.clear();
      _categoryController.clear();
      _cakePrice.clear();
      _cakeTwoPrice.clear();
      _cakeOldPrice!.clear();
      _cakeCategory.clear();
      _cakeDescription.clear();
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cakeData = Provider.of<Cakes>(context);
    final cakeId = ModalRoute.of(context)!.settings.arguments as String;
    final cakeAttr = cakeData.findById(cakeId);
    _cakeTitle.text = cakeAttr.title;
    _cakePrice.text = cakeAttr.price.toStringAsFixed(0);
    _cakeTwoPrice.text = cakeAttr.twoPrice.toStringAsFixed(0);
    _cakeOldPrice!.text = cakeAttr.oldPrice!.toStringAsFixed(0);
    if (_cakeOldPrice?.text == "") {
      _cakeOldPrice!.text = "";
    }
    url = cakeAttr.imageUrl;
    _categoryController.text = cakeAttr.cakeCategoryName;
    _cakeDescription.text = cakeAttr.description;
    // final cakeId = ModalRoute.of(context)!.settings.arguments as String;
    setState(() {
      _cakeId = cakeId;
    });
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue,
            Color.fromARGB(255, 144, 46, 79),
          ],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Update cake details',
            style: TextStyle(fontSize: 15.0),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: _clearFeilds,
              icon: const Icon(Icons.delete),
              tooltip: 'Clear all feilds',
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: GestureDetector(
          onTap: _tryUpdate,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.width * 0.02,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Material(
              type: MaterialType.button,
              color: Colors.pink,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _isLoading
                    ? Text(
                        'Updating...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Update',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04,
                            right: MediaQuery.of(context).size.width * 0.04,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                /* Image picker here ***********************************/
                                // InkWell(
                                //   onTap: () {
                                //     showDialog(
                                //       context: context,
                                //       builder: (BuildContext contex) {
                                //         return AlertDialog(
                                //           title: Text(
                                //             'Choose option',
                                //             style: TextStyle(
                                //               fontWeight: FontWeight.w600,
                                //               color: Theme.of(context)
                                //                   .textSelectionColor,
                                //             ),
                                //           ),
                                //           content: SingleChildScrollView(
                                //             child: ListBody(
                                //               children: [
                                //                 icoButton(
                                //                   _pickImageCamera,
                                //                   'From camera',
                                //                   const Icon(Ionicons.camera),
                                //                 ),
                                //                 icoButton(
                                //                   _pickImageGallery,
                                //                   'From gallery',
                                //                   const Icon(Ionicons.image),
                                //                 ),
                                //                 icoButton(
                                //                   _removeImage,
                                //                   _pickedImage == null
                                //                       ? 'Nothing to remove'
                                //                       : 'Remove',
                                //                   const Icon(Ionicons
                                //                       .remove_circle_outline),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     );
                                //   },
                                //   child: _pickedImage == null
                                //       ? Padding(
                                //           padding: const EdgeInsets.only(
                                //               top: 8.0, bottom: 20.0),
                                //           child: Container(
                                //             height: MediaQuery.of(context)
                                //                     .size
                                //                     .height *
                                //                 0.32,
                                //             width: MediaQuery.of(context)
                                //                     .size
                                //                     .width *
                                //                 0.8,
                                //             decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(35.0),
                                //               border: Border.all(
                                //                   color: Colors.black12),
                                //               color: themeChange.darkTheme
                                //                   ? Theme.of(context).cardColor
                                //                   : Colors.white70,
                                //             ),
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.center,
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.center,
                                //               children: [
                                //                 const Text('Choose a picture'),
                                //                 Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment.center,
                                //                   children: const [
                                //                     Icon(Ionicons.camera),
                                //                     Icon(Ionicons.image),
                                //                   ],
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         )
                                //       : Padding(
                                //           padding: const EdgeInsets.only(
                                //               top: 8.0, bottom: 20.0),
                                //           child: ClipRRect(
                                //             borderRadius:
                                //                 BorderRadius.circular(35.0),
                                //             child: SizedBox(
                                //               height: MediaQuery.of(context)
                                //                       .size
                                //                       .height *
                                //                   0.32,
                                //               width: MediaQuery.of(context)
                                //                       .size
                                //                       .width *
                                //                   0.8,
                                //               child: Image.file(
                                //                 _pickedImage!,
                                //                 fit: BoxFit.contain,
                                //                 alignment: Alignment.center,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                // ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.105,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: _cakeTitle,
                                    key: const ValueKey('Title'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the name of the cake.';
                                      }
                                      return null;
                                    },
                                    decoration:
                                        kCakeUploadTextBoxStyle.copyWith(
                                      labelText: 'Name of the cake',
                                      hintText: 'Enter the name of the cake',
                                      fillColor: themeChange.darkTheme
                                          ? Theme.of(context).cardColor
                                          : Colors.white,
                                    ),
                                    onSaved: (value) {
                                      _cakeTitle.text = value!;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.105,
                                  child: TextFormField(
                                    textAlign: TextAlign.end,
                                    textInputAction: TextInputAction.next,
                                    controller: _cakePrice,
                                    key: const ValueKey('Price \$'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter the cake price.';
                                      }
                                      return null;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[.,0-9]')),
                                    ],
                                    decoration:
                                        kCakeUploadTextBoxStyle.copyWith(
                                      labelText: 'Price',
                                      prefixText: 'Rs. ',
                                      suffixText: '.00',
                                      fillColor: themeChange.darkTheme
                                          ? Theme.of(context).cardColor
                                          : Colors.white,
                                    ),
                                    onSaved: (value) {
                                      _cakePrice.text = value!;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.105,
                                  child: TextFormField(
                                    textAlign: TextAlign.end,
                                    textInputAction: TextInputAction.next,
                                    controller: _cakeTwoPrice,
                                    key: const ValueKey('Price \$'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter the cake 2KG price.';
                                      }
                                      return null;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[.,0-9]')),
                                    ],
                                    decoration:
                                        kCakeUploadTextBoxStyle.copyWith(
                                      labelText: '2KG Price',
                                      prefixText: 'Rs. ',
                                      suffixText: '.00',
                                      fillColor: themeChange.darkTheme
                                          ? Theme.of(context).cardColor
                                          : Colors.white,
                                    ),
                                    onSaved: (value) {
                                      _cakeTwoPrice.text = value!;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.105,
                                  child: TextFormField(
                                    textAlign: TextAlign.end,
                                    textInputAction: TextInputAction.done,
                                    controller: _cakeOldPrice,
                                    key: const ValueKey('oldPrice'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[.,0-9]')),
                                    ],
                                    decoration:
                                        kCakeUploadTextBoxStyle.copyWith(
                                      labelText: 'Old price',
                                      prefixText: 'Rs. ',
                                      suffixText: '.00',
                                      fillColor: themeChange.darkTheme
                                          ? Theme.of(context).cardColor
                                          : Colors.white,
                                    ),
                                    onSaved: (value) {
                                      _cakeOldPrice!.text = value!;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.105,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        // flex: 2,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 9),
                                          child: TextFormField(
                                            controller: _categoryController,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            key: const ValueKey('Category'),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Choose a Category.';
                                              }
                                              return null;
                                            },
                                            readOnly: true,
                                            decoration: kCakeUploadTextBoxStyle
                                                .copyWith(
                                              labelText: 'Category',
                                              filled: false,
                                              labelStyle: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onSaved: (value) {
                                              _cakeCategory.text = value!;
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: themeChange.darkTheme
                                              ? Theme.of(context).cardColor
                                              : Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              35,
                                            ),
                                          ),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        // margin: const EdgeInsets.only(
                                        //     left: 50.0, right: 5.0),
                                        // padding: const EdgeInsets.all(5.0),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                          ),
                                          child: DropdownButton<String>(
                                            dropdownColor: themeChange.darkTheme
                                                ? Theme.of(context).cardColor
                                                : Colors.white,
                                            elevation: 3,
                                            underline: Container(),
                                            items: const [
                                              DropdownMenuItem<String>(
                                                child: Text('Birthday Cake'),
                                                value: 'Birthday Cake',
                                                alignment:
                                                    AlignmentDirectional.center,
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Wedding Cake'),
                                                value: 'Wedding Cake',
                                                alignment:
                                                    AlignmentDirectional.center,
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Anniversary Cake'),
                                                value: 'Anniversary Cake',
                                                alignment:
                                                    AlignmentDirectional.center,
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _categoryValue = value;
                                                _categoryController.text =
                                                    value!;
                                                // print(_cakeCategory);
                                              });
                                            },
                                            hint:
                                                const Text('Select a Category'),
                                            value: _categoryValue,
                                            borderRadius:
                                                BorderRadius.circular(35.0),
                                            iconEnabledColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller: _cakeDescription,
                                  key: const ValueKey('Description'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'product description is required.';
                                    }
                                    return null;
                                  },
                                  //controller: this._controller,
                                  maxLines: 10,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  textInputAction: TextInputAction.newline,
                                  decoration: kCakeUploadTextBoxStyle.copyWith(
                                    //  counterText: charLength.toString(),
                                    labelText: 'Description',
                                    hintText: 'Product description',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 25.0),
                                    fillColor: themeChange.darkTheme
                                        ? Theme.of(context).cardColor
                                        : Colors.white,
                                  ),
                                  onSaved: (value) {
                                    _cakeDescription.text = value!;
                                  },
                                  onChanged: (text) {
                                    // setState(() => charLength -= text.length);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget icoButton(VoidCallback fn, String lbl, Icon ico) {
    return ElevatedButton.icon(
      onPressed: fn,
      icon: ico,
      label: Text(
        lbl,
      ),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).cardColor,
        onPrimary: Theme.of(context).textSelectionColor,
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(this.icon, this.size, this.gradient, {Key? key})
      : super(key: key);

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
