import 'package:e_restaurant_app/features/favourite/bloc/favourite_bloc.dart';
import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/basket/bloc/basket_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FoodDetailsPage extends StatefulWidget {
  final FoodModel foodModel;

  const FoodDetailsPage({
    Key? key,
    required this.foodModel,
  }) : super(key: key);

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 450.h,
      automaticallyImplyLeading: ((kIsWeb) ? false : true),
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          widget.foodModel.name,
          style: const TextStyle(color: Colors.white),
        ),
        background: Padding(
          padding: (kIsWeb)
              ? EdgeInsets.only(left: 65.w, right: 65.w)
              : EdgeInsets.all(3.h),
          child: Hero(
            tag: widget.foodModel.id,
            child: Image.network(
              widget.foodModel.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget foodInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30.h,
      endIndent: endIndent.w,
      color: Colors.black,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: (kIsWeb)
                      ? EdgeInsets.only(left: 65.w, right: 65.w)
                      : EdgeInsets.all(3.h),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 0.h),
                    padding: EdgeInsets.all(8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BlocBuilder<FavouriteBloc, FavouriteState>(
                              builder: (context, state) {
                                var isFavourite = state.favouriteFood
                                    .contains(widget.foodModel);
                                return isFavourite
                                    ? InkWell(
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          context
                                              .read<FavouriteBloc>()
                                              .add(RemoveFromFavouriteList(
                                                foodModel: widget.foodModel,
                                              ));
                                        },
                                      )
                                    : InkWell(
                                        child:
                                            const Icon(Icons.favorite_border),
                                        onTap: () {
                                          context.read<FavouriteBloc>().add(
                                                AddToFavouriteList(
                                                  foodModel: widget.foodModel,
                                                ),
                                              );
                                        });
                              },
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            BlocBuilder<BasketBloc, BasketState>(
                              builder: (context, state) {
                                var isInBasket =
                                    state.basketList.contains(widget.foodModel);
                                return isInBasket
                                    ? InkWell(
                                        child: const Icon(Icons.shopping_bag),
                                        onTap: () {
                                          context
                                              .read<BasketBloc>()
                                              .add(RemoveFromBasket(
                                                foodModel: widget.foodModel,
                                              ));
                                        },
                                      )
                                    : InkWell(
                                        child: const Icon(
                                            Icons.shopping_bag_outlined),
                                        onTap: () {
                                          context.read<BasketBloc>().add(
                                                AddToBasket(
                                                  foodModel: widget.foodModel,
                                                ),
                                              );
                                        });
                              },
                            ),
                          ],
                        ),
                        buildDivider(10),
                        foodInfo(
                          'Price: ',
                          widget.foodModel.price.toString(),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        foodInfo(
                          'Descrption: ',
                          widget.foodModel.description.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 300.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
