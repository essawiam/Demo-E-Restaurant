import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_color.dart';
import '../constants/titles.dart';

class BuildDrawerWidget extends StatelessWidget {
  const BuildDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: mainColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                navigationJourney,
                style: GoogleFonts.notoSerif(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  home,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/foodMenu');
              },
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  favorite,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/favourite');
              },
              leading: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  basket,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/basket');
              },
              leading: const Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
            ),
            // Add more ListTiles for additional drawer items
          ],
        ),
      ),
    );
  }
}
