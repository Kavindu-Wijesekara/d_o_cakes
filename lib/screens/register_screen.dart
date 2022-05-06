// ignore_for_file: unused_field, deprecated_member_use

import 'package:auth_buttons/auth_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/const/constants.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/screens/login_screen.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const routeName = '/RegistrationScreen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  final String _role = 'user';
  late int _phoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailAddress.toLowerCase().trim(),
          password: _password.trim(),
        );
        final User user = _auth.currentUser!;
        final _uid = user.uid;
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullName,
          'email': _emailAddress,
          'phoneNumber': _phoneNumber,
          'role': _role,
          'joined': Timestamp.now(),
          'address': '',
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
        // Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } on FirebaseAuthException catch (error) {
        _globalMethods.authErrorHandle('${error.message}', context);
        // print('error occured ${error.message}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'images/cake_patt.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              // alignment: FractionalOffset(_animation.value, 0),
            ),
            Container(
              color: themeChange.darkTheme
                  ? Colors.black87
                  : Colors.white.withOpacity(0.9),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Text(
                              'Create new account',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).textSelectionColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              key: const ValueKey('name'),
                              textInputAction: TextInputAction.next,
                              decoration: kFormTextBoxStyle.copyWith(
                                hintText: 'Enter the full name',
                                labelText: 'Full Name',
                                prefixIcon: const Icon(Icons.account_box),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: themeChange.darkTheme
                                        ? Colors.white54
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Name can't be empty.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _fullName = value!;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              key: const ValueKey('phone'),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                              ],
                              decoration: kFormTextBoxStyle.copyWith(
                                hintText: 'Enter the mobile number',
                                labelText: 'Mobile number',
                                helperText: 'Ex: 0712345678',
                                prefixIcon: const Icon(Icons.phone_android),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: themeChange.darkTheme
                                        ? Colors.white54
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Phone number can't be empty.";
                                } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$')
                                    .hasMatch(val)) {
                                  return "Please enter a valid phone number.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _phoneNumber = int.parse(value!);
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              key: const ValueKey('email'),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: kFormTextBoxStyle.copyWith(
                                hintText: 'Enter the e-mail address',
                                labelText: 'E-mail',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: themeChange.darkTheme
                                        ? Colors.white54
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "E-mail can't be empty.";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(val)) {
                                  return "Please enter a valid e-mail address.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailAddress = value!;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              key: const ValueKey('password'),
                              controller: _pass,
                              obscureText: _obscureText,
                              textInputAction: TextInputAction.next,
                              decoration: kFormTextBoxStyle.copyWith(
                                hintText: 'Enter the password',
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    _obscureText
                                        ? EvaIcons.eye
                                        : EvaIcons.eyeOff2,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: themeChange.darkTheme
                                        ? Colors.white54
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Password can't be empty.";
                                } else if (!RegExp(r'^.{6,}$').hasMatch(val)) {
                                  return "Must be at least 6 characters in length.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value.toString();
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              key: const ValueKey('rePassword'),
                              controller: _confirmPass,
                              obscureText: _obscureText,
                              textInputAction: TextInputAction.done,
                              decoration: kFormTextBoxStyle.copyWith(
                                hintText: 'Re-type the password',
                                labelText: 'Re-type Password',
                                prefixIcon: const Icon(Icons.password),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: themeChange.darkTheme
                                        ? Colors.white54
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Confirm password can't be empty.";
                                }
                                if (val != _pass.text) {
                                  return "Password dosen't match.";
                                }
                                return null;
                              },
                              onEditingComplete: _submitForm,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: kElevatedButtonStyle,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 10, 50, 10),
                                child: Text(
                                  "Register".toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: _submitForm,
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                color: themeChange.darkTheme
                                    ? Colors.white
                                    : Colors.black54,
                                thickness: 2,
                              ),
                            ),
                          ),
                          Text(
                            'or Sign up with',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: themeChange.darkTheme
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                color: themeChange.darkTheme
                                    ? Colors.white
                                    : Colors.black54,
                                thickness: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Column(
                        children: [
                          GoogleAuthButton(
                            onPressed: () {},
                            text: 'Sign up with Google',
                            style: const AuthButtonStyle(
                              iconSize: 25,
                              elevation: 5,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          FacebookAuthButton(
                            onPressed: () {},
                            text: 'Sign up with Facebook',
                            style: const AuthButtonStyle(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              iconSize: 25,
                              elevation: 5,
                              iconType: AuthIconType.secondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Have an account? ",
                              style: TextStyle(
                                color: themeChange.darkTheme
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, LoginScreen.routeName);
                                },
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: themeChange.darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              // color: Theme.of(context).accentColor),
                            ),
                          ],
                        ),
                      ),
                    ],
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
