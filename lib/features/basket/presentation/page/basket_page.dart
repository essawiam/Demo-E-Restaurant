import 'package:e_restaurant_app/core/constants/titles.dart';
import 'package:e_restaurant_app/features/basket/bloc/basket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../core/widget/build_drawer_widget.dart';
import '../../../../core/widget/top_bar_widget.dart';
import '../../widget/basket_item_widget.dart';
import '../../widget/summary_widget.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  void initState() {
    super.initState();
    context.read<BasketBloc>().add(BasketFetched());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        drawer: const BuildDrawerWidget(),
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? AppBar(
                backgroundColor: Colors.grey.shade400,
                elevation: 0,
                title: Text(
                  basket,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[700],
                  ),
                ),
                centerTitle: false,
              )
            : PreferredSize(
                preferredSize: Size(screenSize.width, 100),
                child: const TopBarContents(),
              ),
        body: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            if (state.basketList.isEmpty) {
              return const Center(
                child: Text(noOrders),
              );
            }
            if (state.basketList.isNotEmpty) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12.0.h),
                        child: ListView.builder(
                          itemCount: state.basketList.length,
                          padding: EdgeInsets.all(12.h),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(12.0.h),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: BasketItemWidget(
                                    foodModel: state.basketList[index],
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                    SummaryWidget(
                      totalPrice: state.totalPrice,
                    )
                  ]);
            }
            return Container();
          },
        ));
  }
}
