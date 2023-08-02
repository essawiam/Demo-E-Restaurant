import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/titles.dart';

class InroPage extends StatefulWidget {
  const InroPage({super.key});

  @override
  State<InroPage> createState() => _InroPageState();
}

class _InroPageState extends State<InroPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/foodMenu');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 200.h),
              child: Center(
                child: Text(
                  introTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                      fontSize: 36.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              introDetails,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
