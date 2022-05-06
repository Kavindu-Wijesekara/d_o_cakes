import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_o_cakes/inner_screens/edit_user.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/screens/order_screens/order_screen.dart';
import 'package:d_o_cakes/screens/wishlist_screen.dart';
import 'package:d_o_cakes/widgets/hero_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _address;

  @override
  void initState() {
    super.initState();
    getData();
  }

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
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    final _uid = user!.uid;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: user.isAnonymous
                ? [
                    tileTitle(
                      'Other',
                      const Icon(
                        Icons.add,
                        color: Colors.transparent,
                      ),
                      () {},
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () => Navigator.of(context)
                              .pushNamed(WishlistScreen.routeName),
                          title: const Text('Wishlist'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          leading: const Icon(EvaIcons.heart),
                        ),
                      ),
                    ),
                    ListTileSwitch(
                      value: themeChange.darkTheme,
                      onChanged: (value) {
                        setState(() {
                          themeChange.darkTheme = value;
                        });
                      },
                      leading: const Icon(Icons.nightlight),
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      title: const Text('Dark mode'),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6.0),
                                          child: Image.network(
                                            'https://cdn-icons-png.flaticon.com/128/595/595067.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Sign out'),
                                        ),
                                      ],
                                    ),
                                    content:
                                        const Text('Do you want to Sign out?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            await _auth.signOut().then(
                                                (value) =>
                                                    Navigator.pop(context));
                                          },
                                          child: const Text(
                                            'OK',
                                          ))
                                    ],
                                  );
                                });
                          },
                          title: const Text('Logout'),
                          leading: const Icon(Icons.exit_to_app_rounded),
                        ),
                      ),
                    ),
                    // Material(
                    //   color: Colors.transparent,
                    //   child: InkWell(
                    //     splashColor: Theme.of(context).splashColor,
                    //     child: ListTile(
                    //       onTap: () {
                    //         Navigator.pushNamed(
                    //             context, UploadProductForm.routeName);
                    //       },
                    //       title: const Text('New'),
                    //       leading: const Icon(Icons.exit_to_app_rounded),
                    //     ),
                    //   ),
                    // ),
                  ]
                : [
                    tileTitle(
                      'User Information',
                      const Icon(
                        Icons.add,
                      ),
                      () {
                        Navigator.of(context).push(HeroDialogRoute(
                          builder: (context) {
                            return EditUserData(
                              uid: _uid,
                            );
                          },
                        ));
                      },
                    ),
                    userListTile(context, 'Name', _name ?? 'Anonymous user', 0),
                    userListTile(context, 'Email', _email ?? '', 1),
                    userListTile(
                        context, 'Phone number', _phoneNumber ?? '', 2),
                    userListTile(context, 'Address', _address ?? '', 3),
                    tileTitle(
                      'Other',
                      const Icon(
                        Icons.add,
                        color: Colors.transparent,
                      ),
                      () {},
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () => Navigator.of(context)
                              .pushNamed(WishlistScreen.routeName),
                          title: const Text('Wishlist'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          leading: const Icon(EvaIcons.heart),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(OrderScreen.routeName);
                          },
                          title: const Text('My Orders'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          leading: const Icon(Icons.shopping_bag),
                        ),
                      ),
                    ),
                    ListTileSwitch(
                      value: themeChange.darkTheme,
                      onChanged: (value) {
                        setState(() {
                          themeChange.darkTheme = value;
                        });
                      },
                      leading: const Icon(Icons.nightlight),
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      title: const Text('Dark mode'),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6.0),
                                          child: Image.network(
                                            'https://cdn-icons-png.flaticon.com/128/595/595067.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Sign out'),
                                        ),
                                      ],
                                    ),
                                    content:
                                        const Text('Do you want to Sign out?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            await _auth.signOut().then(
                                                (value) =>
                                                    Navigator.pop(context));
                                          },
                                          child: const Text(
                                            'OK',
                                          ))
                                    ],
                                  );
                                });
                          },
                          title: const Text('Logout'),
                          leading: const Icon(Icons.exit_to_app_rounded),
                        ),
                      ),
                    ),
                    // Material(
                    //   color: Colors.transparent,
                    //   child: InkWell(
                    //     splashColor: Theme.of(context).splashColor,
                    //     child: ListTile(
                    //       onTap: () {
                    //         Navigator.pushNamed(
                    //             context, UploadProductForm.routeName);
                    //       },
                    //       title: const Text('New'),
                    //       leading: const Icon(Icons.exit_to_app_rounded),
                    //     ),
                    //   ),
                    // ),
                  ],
          ),
        ),
      ),
    );
  }

  final List<IconData> _userTileIcons = [
    Icons.account_box_outlined,
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app,
    Icons.add,
  ];

  Widget userListTile(
    BuildContext context,
    String title,
    String subTitle,
    int index,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(_userTileIcons[index]),
        ),
      ),
    );
  }

  Widget tileTitle(String title, Icon? _ico, VoidCallback? fn) {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.5,
          // ),
          user.isAnonymous
              ? const Icon(
                  Icons.add,
                  color: Colors.transparent,
                )
              : GestureDetector(
                  onTap: fn,
                  child: Tooltip(
                    message: 'Edit Information',
                    child: _ico,
                  ),
                ),
        ],
      ),
    );
  }

  Widget tileTitleWithIcon(String title, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
