// ignore_for_file: unused_local_variable, unused_field

import 'package:auth_buttons/auth_buttons.dart';
import 'package:d_o_cakes/const/constants.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/screens/forgot_password_screen.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _emailAddress = '';
  String _password = '';
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;

  final LinearGradient _gradient = const LinearGradient(
    colors: [
      Colors.redAccent,
      Colors.pinkAccent,
    ],
  );

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: _emailAddress, password: _password)
            .then((value) =>
                Navigator.canPop(context) ? Navigator.pop(context) : Null);
        Fluttertoast.showToast(
          msg: "Logged in successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      } on FirebaseAuthException catch (error) {
        _globalMethods.authErrorHandle('${error.message}', context);
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
              'images/background.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              // alignment: FractionalOffset(_animation.value, 0),
            ),
            Container(
              color: themeChange.darkTheme ? Colors.black54 : Colors.white70,
            ),
            SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Text(
                            'Dil\'s',
                            style: GoogleFonts.getFont(
                              'Lobster',
                              textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.19,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Colors.white,
                              ),
                            ),
                          ),
                          ShaderMask(
                            shaderCallback: (Rect rect) {
                              return _gradient.createShader(rect);
                            },
                            child: Text(
                              'Dil\'s',
                              style: GoogleFonts.getFont(
                                'Lobster',
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.09,
                      ),
                      Stack(
                        children: [
                          Text(
                            'Oven',
                            style: GoogleFonts.getFont(
                              'Lobster',
                              textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.19,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Colors.white,
                              ),
                            ),
                          ),
                          ShaderMask(
                            shaderCallback: (Rect rect) {
                              return _gradient.createShader(rect);
                            },
                            child: Text(
                              'Oven',
                              style: GoogleFonts.getFont(
                                'Lobster',
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              key: const ValueKey('email'),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: kFormTextBoxStyle.copyWith(
                                hintText: 'Enter the email address',
                                labelText: 'E-mail',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(
                                    color: themeChange.darkTheme
                                        ? Colors.white70
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty &&
                                    !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(value)) {
                                  return 'Enter a vaild email address.';
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
                              textInputAction: TextInputAction.done,
                              obscureText: _obscureText,
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
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(
                                    color: themeChange.darkTheme
                                        ? Colors.white70
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'Enter a vaild password.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                              onEditingComplete: _submitForm,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, ForgotPasswordScreen.routeName),
                            child: Text(
                              "Forgot your password?",
                              style: TextStyle(
                                color: themeChange.darkTheme
                                    ? Colors.white
                                    : Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.021,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  style: kElevatedButtonStyle,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      'Sign In'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onPressed: _submitForm,
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Divider(
                            thickness: 1.0,
                            indent: 30,
                            endIndent: 30,
                          ),
                          Text(
                            'or Sign in with',
                            style: TextStyle(
                              color: themeChange.darkTheme
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GoogleAuthButton(
                                onPressed: () {},
                                style: const AuthButtonStyle(
                                  iconSize: 25,
                                  elevation: 5,
                                  buttonType: AuthButtonType.icon,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              FacebookAuthButton(
                                onPressed: () {},
                                style: const AuthButtonStyle(
                                  iconSize: 25,
                                  elevation: 5,
                                  buttonType: AuthButtonType.icon,
                                  iconType: AuthIconType.secondary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(
                                        color: themeChange.darkTheme
                                            ? Colors.white
                                            : Colors.black54,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context,
                                              RegistrationScreen.routeName);
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
