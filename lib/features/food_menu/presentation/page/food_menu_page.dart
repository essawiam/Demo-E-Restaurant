import 'package:e_restaurant_app/core/utils/responsive.dart';
import 'package:e_restaurant_app/core/widget/build_drawer_widget.dart';
import 'package:e_restaurant_app/core/widget/top_bar_widget.dart';
import 'package:e_restaurant_app/features/food_menu/bloc/food_menu_bloc.dart';
import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';
import 'package:e_restaurant_app/features/food_menu/presentation/widget/food_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/errors.dart';
import '../../../../core/constants/titles.dart';
import '../../../../core/widget/title_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({super.key});

  @override
  _FoodMenuPageState createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  late List<FoodModel> _foodMenuList;
  late List<FoodModel> _searchedFoodList;
  late TextEditingController _searchTextController;
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    context.read<FoodMenuBloc>().add(FoodMenuFetched());
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
                titleOfTheApp,
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
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(
              left: 7.0.w,
              right: 7.0.w,
              top: 5.h,
              bottom: 5.h,
            ),
            child: const TitleWidget(bodyTitle: foodMenuBodyTitle),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0.w,
              right: 10.0.w,
              top: 5.h,
              bottom: 5.h,
            ),
            child: TextField(
              controller: _searchTextController,
              onChanged: (query) => context.read<FoodMenuBloc>().add(
                    FoodMenuSearched(
                        foodMenu: _foodMenuList, searchedFood: query),
                  ),
              decoration: InputDecoration(
                labelText: searchForFood,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.w))),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.h),
            child: const Divider(),
          ),
          SizedBox(height: 10.h),
          BlocBuilder<FoodMenuBloc, FoodMenuState>(builder: (context, state) {
            if (state.foodMenuStatus.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.foodMenuStatus.isFailure) {
              return Center(
                child: Text(state.errorMessage!),
              );
            }
            if (state.foodMenuStatus.isEmpty) {
              return const Center(
                child: Text(noFood),
              );
            }
            if (state.foodMenuStatus.isSuccess ||
                state.foodMenuStatus.isFilterd) {
              if (state.foodMenuStatus.isSuccess) {
                _foodMenuList = state.foodMenu!;
              }
              if (state.foodMenuStatus.isFilterd) {
                _searchedFoodList = state.foodMenu!;
              }
              return Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(12.h),
                  itemCount: _searchTextController.text.isEmpty
                      ? _foodMenuList.length
                      : _searchedFoodList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (kIsWeb) ? 4 : 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return FoodItemWidget(
                      foodModel: _searchTextController.text.isEmpty
                          ? _foodMenuList[index]
                          : _searchedFoodList[index],
                    );
                  },
                ),
              );
            }
            return Container();
          }),
        ],
      ),
    );
  }
}
