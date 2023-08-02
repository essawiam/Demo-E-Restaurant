import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_color.dart';
import '../constants/titles.dart';

class TopBarContents extends StatefulWidget {
  const TopBarContents();

  @override
  // ignore: library_private_types_in_public_api
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width / 4,
              ),
              Text(
                titleOfTheApp,
                style: TextStyle(
                  color: mainColor,
                  fontSize: 30.sp,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              SizedBox(width: screenSize.width / 15),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[0] = true : _isHovering[0] = false;
                  });
                },
                onTap: () {
                  Navigator.pushNamed(context, '/foodMenu');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      home,
                      style: TextStyle(
                        color: _isHovering[0] ? mainColor : mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Visibility(
                      maintainAnimation: true,
                      maintainState: true,
                      maintainSize: true,
                      visible: _isHovering[0],
                      child: Container(
                        height: 2.h,
                        width: 20.w,
                        color: const Color(0xFF051441),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[1] = true : _isHovering[1] = false;
                  });
                },
                onTap: () {
                  Navigator.pushNamed(context, '/favourite');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      favorite,
                      style: TextStyle(
                        color: _isHovering[1] ? mainColor : mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Visibility(
                      maintainAnimation: true,
                      maintainState: true,
                      maintainSize: true,
                      visible: _isHovering[1],
                      child: Container(
                        height: 2.h,
                        width: 20.w,
                        color: const Color(0xFF051441),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[2] = true : _isHovering[2] = false;
                  });
                },
                onTap: () {
                  Navigator.pushNamed(context, '/basket');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      basket,
                      style: TextStyle(
                        color: _isHovering[2] ? mainColor : mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Visibility(
                      maintainAnimation: true,
                      maintainState: true,
                      maintainSize: true,
                      visible: _isHovering[2],
                      child: Container(
                        height: 2.h,
                        width: 20.w,
                        color: const Color(0xFF051441),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //);
  }
}
