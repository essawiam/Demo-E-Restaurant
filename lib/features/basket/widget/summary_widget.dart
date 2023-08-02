import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/titles.dart';
import '../bloc/basket_bloc.dart';
import '../presentation/page/order_page.dart';

class SummaryWidget extends StatelessWidget {
  final double totalPrice;

  const SummaryWidget({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(36.0.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: mainColor,
        ),
        padding: EdgeInsets.all(24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  totalPriceTitle,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8.h),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.all(12.h),
                child: const Row(
                  children: [
                    Text(
                      payNow,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<BasketBloc>(context),
                      child: const OrderPage(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
