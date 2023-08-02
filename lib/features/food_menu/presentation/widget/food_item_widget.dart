import 'package:e_restaurant_app/core/page/food_details_page.dart';
import 'package:e_restaurant_app/features/basket/bloc/basket_bloc.dart';
import 'package:e_restaurant_app/features/favourite/bloc/favourite_bloc.dart';
import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodItemWidget extends StatelessWidget {
  final FoodModel foodModel;

  const FoodItemWidget({Key? key, required this.foodModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8.w, 8.h, 8.h, 8.w),
      padding: EdgeInsetsDirectional.all(4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: BlocProvider.of<FavouriteBloc>(context),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<BasketBloc>(context),
                    ),
                  ],
                  child: FoodDetailsPage(foodModel: foodModel),
                ),
              )),
        },
        child: GridTile(
          footer: Hero(
            tag: foodModel.id,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h,
              ),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                foodModel.name,
                style: TextStyle(
                  height: 1.3.h,
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: Colors.grey,
            child: (kIsWeb)
                ? Image.network(
                    foodModel.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: 'asset/images/spin.gif',
                    image: foodModel.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
