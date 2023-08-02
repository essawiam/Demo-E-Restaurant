import 'package:e_restaurant_app/features/basket/data/model/order_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/titles.dart';
import '../../../../core/widget/title_widget.dart';
import '../../bloc/basket_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50.h),
          const TitleWidget(bodyTitle: enterYourAddress),
          SizedBox(height: 50.h),
          BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              if (state.basketStatus.isprocessing) {
                return Padding(
                  padding: EdgeInsets.all(16.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: enterAddress,
                            prefixIcon: const Icon(Icons.home_filled),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.w))),
                          ),
                        ),
                      ),
                      SizedBox(height: 100.h),
                      Padding(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<BasketBloc>().add(OrderSended(
                                    orderModel: OrderModel(
                                  address: _addressController.text,
                                  foodItems: state.basketList,
                                  totalPrice: state.totalPrice,
                                )));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(mainColor),
                          ),
                          child: const Text(
                            placeOrder,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state.basketStatus.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.basketStatus.isSuccess) {
                return Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(done),
                      SizedBox(
                        width: 1.w,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/foodMenu');
                          context.read<BasketBloc>().add(BasketDeleted());
                        },
                        child: const Text(backToHome),
                      )
                    ],
                  ),
                );
              }
              if (state.basketStatus.isFailure) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
