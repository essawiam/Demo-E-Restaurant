import 'package:e_restaurant_app/core/widget/build_drawer_widget.dart';
import 'package:e_restaurant_app/features/favourite/bloc/favourite_bloc.dart';
import 'package:e_restaurant_app/features/food_menu/presentation/widget/food_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/titles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widget/title_widget.dart';
import '../../../../core/widget/top_bar_widget.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(FavouriteListFetched());
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
                favorite,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 48.h),
          const TitleWidget(bodyTitle: favoriteBodyTitle),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: const Divider(),
          ),
          SizedBox(height: 70.h),
          BlocBuilder<FavouriteBloc, FavouriteState>(builder: (context, state) {
            if (state.favouriteFood.isNotEmpty) {
              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.favouriteFood.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (kIsWeb) ? 4 : 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return FoodItemWidget(
                      foodModel: state.favouriteFood[index],
                    );
                  },
                ),
              );
            }
            if (state.favouriteFood.isEmpty) {
              return const Center(
                child: Text(noFavFood),
              );
            }

            return Container();
          }),
        ],
      ),
    );
  }
}
