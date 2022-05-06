import 'package:d_o_cakes/provider/dark_theme.dart';
import 'package:d_o_cakes/screens/wishlist_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 25.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35.0,
                    child: Text(
                      'Will you have',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        textStyle: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                    child: Text(
                      'some more',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        textStyle: TextStyle(
                          fontSize: 30.0,
                          color: themeChange.darkTheme
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    child: Text(
                      'cakes?',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        textStyle: TextStyle(
                          fontSize: 30.0,
                          color: themeChange.darkTheme
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: Colors.grey.shade100,
                ),
                height: 50.0,
                width: 50.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishlistScreen.routeName);
                  },
                  icon: const Icon(EvaIcons.heart),
                  color: Colors.pink,
                  tooltip: 'WishList',
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
            child: Marquee(
              text:
                  'Please place your orders, 3 days before the due date.  දින 3කට පෙර ඔබේ ඇනුවුම් ලබා දෙන්න.',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.red,
              ),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 100.0,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 1.0,
              accelerationDuration: const Duration(seconds: 10),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 1000),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ],
      ),
    );
  }
}
