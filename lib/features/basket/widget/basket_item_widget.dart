import 'package:e_restaurant_app/features/basket/bloc/basket_bloc.dart';
import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasketItemWidget extends StatelessWidget {
  final FoodModel foodModel;

  const BasketItemWidget({
    super.key,
    required this.foodModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.network(
          foodModel.imageUrl,
          height: 36.h,
        ),
        title: Text(
          foodModel.name,
          style: TextStyle(fontSize: 18.sp),
        ),
        subtitle: Text(
          '\$${foodModel.price}',
          style: TextStyle(fontSize: 12.sp),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => {
            context
                .read<BasketBloc>()
                .add(RemoveFromBasket(foodModel: foodModel))
          },
        ));
  }
}
