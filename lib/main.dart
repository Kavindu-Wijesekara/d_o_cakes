import 'package:d_o_cakes/const/them_data.dart';
import 'package:d_o_cakes/inner_screens/update_cake_details.dart';
import 'package:d_o_cakes/provider/admin_order_provider.dart';
import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/provider/cart_provider.dart';
import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/provider/favs_provider.dart';
import 'package:d_o_cakes/provider/orders_provider.dart';
import 'package:d_o_cakes/screens/admin_screens/admin_cakes_screen.dart';
import 'package:d_o_cakes/screens/admin_screens/admin_customers_screen.dart';
import 'package:d_o_cakes/screens/admin_screens/admin_dashboard_screen.dart';
import 'package:d_o_cakes/screens/admin_screens/admin_home.dart';
import 'package:d_o_cakes/screens/admin_screens/admin_orders_screen.dart';
import 'package:d_o_cakes/screens/feed_screen.dart';
import 'package:d_o_cakes/screens/order_screens/order_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'inner_screens/upload_new_cake.dart';
import 'screens/bottom_navy_bar.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/register_screen.dart';
import 'screens/user_state.dart';
import 'screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inner_screens/cake_details.dart';
import 'inner_screens/category_feeds.dart';
import 'screens/cart_screen.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangerProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangerProvider.darkTheme =
        await themeChangerProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occurred'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangerProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => Cakes(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => AdminOrdersProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeData, child) {
                return MaterialApp(
                  title: 'Dil\'s Oven',
                  debugShowCheckedModeBanner: false,
                  theme:
                      Styles.themeData(themeChangerProvider.darkTheme, context),
                  home: const UserState(),
                  routes: {
                    CartScreen.routeName: (ctx) => const CartScreen(),
                    WishlistScreen.routeName: (ctx) => const WishlistScreen(),
                    FeedScreen.routeName: (ctx) => const FeedScreen(),
                    CategoryFeedScreen.routeName: (ctx) =>
                        const CategoryFeedScreen(),
                    CakeDetails.routeName: (ctx) => const CakeDetails(),
                    LoginScreen.routeName: (ctx) => const LoginScreen(),
                    RegistrationScreen.routeName: (ctx) =>
                        const RegistrationScreen(),
                    BottomNavBar.routeName: (ctx) => const BottomNavBar(),
                    UploadProductForm.routeName: (ctx) =>
                        const UploadProductForm(),
                    UpdateCakeDetails.routeName: (ctx) =>
                        const UpdateCakeDetails(),
                    OrderScreen.routeName: (ctx) => const OrderScreen(),
                    ForgotPasswordScreen.routeName: (ctx) =>
                        const ForgotPasswordScreen(),
                    AdminHomeScreen.routeName: (ctx) => const AdminHomeScreen(),
                    AdminOrderScreen.routeName: (ctx) =>
                        const AdminOrderScreen(),
                    AdminCakeScreen.routeName: (ctx) => const AdminCakeScreen(),
                    AdminCustomerScreen.routeName: (ctx) =>
                        const AdminCustomerScreen(),
                    AdminDashboardScreen.routeName: (ctx) =>
                        const AdminDashboardScreen(),
                  },
                );
              },
            ),
          );
        });
  }
}
