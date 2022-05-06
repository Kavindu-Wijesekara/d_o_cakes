// ignore_for_file: unused_field

import 'package:auth_buttons/auth_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/screens/login_screen.dart';
import 'package:d_o_cakes/screens/register_screen.dart';
import 'package:d_o_cakes/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  final String _role = 'user';

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _googleSignIn() async {
    final googleSiginIn = GoogleSignIn();
    final googleAccount = await googleSiginIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        try {
          final authResults = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken),
          );
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResults.user!.uid)
              .set({
            'id': authResults.user!.uid,
            'name': authResults.user!.displayName,
            'email': authResults.user!.email,
            'phoneNumber': authResults.user!.phoneNumber,
            'role': _role,
            'joined': Timestamp.now(),
          });
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
        }
      }
    }
  }

  void _signInAnonymously() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signInAnonymously();
      Fluttertoast.showToast(
        msg:
            "Logged in successfully as Guest. Please register befor placing your orders.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 211, 95, 0),
        textColor: Colors.white,
        fontSize: 12.0,
      );
    } on FirebaseAuthException catch (error) {
      _globalMethods.authErrorHandle('${error.message}', context);
    } finally {
      if (mounted) {
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
      body: Stack(
        children: [
          Image.asset(
            'images/landing1.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          // Container(
          //   color: Colors.black38,
          //   child: Image.asset('images/dils_oven_logo.png'),
          // ),
          Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('images/dils_oven_logo.png'),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.03,
                // ),
                // _isLoading
                //     ? const CircularProgressIndicator()
                //     : ElevatedButton(
                //         onPressed: () {
                //           _signInAnonymously();
                //           // Navigator.pushNamed(context, BottomNavBar.routeName);
                //         },
                //         child: const Text('Continue as Guest'),
                //       ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.white54,
                          thickness: 2,
                        ),
                      ),
                    ),
                    Text(
                      'or Sign in with',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.white54),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.white54,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EmailAuthButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      darkMode: themeChange.darkTheme ? true : false,
                      style: const AuthButtonStyle(
                        iconSize: 25,
                        buttonType: AuthButtonType.icon,
                        iconType: AuthIconType.secondary,
                      ),
                    ),
                    GoogleAuthButton(
                      onPressed: _googleSignIn,
                      darkMode: themeChange.darkTheme ? true : false,
                      style: const AuthButtonStyle(
                        iconSize: 25,
                        buttonType: AuthButtonType.icon,
                      ),
                    ),
                    FacebookAuthButton(
                      onPressed: () {},
                      darkMode: themeChange.darkTheme ? true : false,
                      style: const AuthButtonStyle(
                        iconSize: 25,
                        buttonType: AuthButtonType.icon,
                        iconType: AuthIconType.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      TextSpan(
                        text: 'Create',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, RegistrationScreen.routeName);
                          },
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        // color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
