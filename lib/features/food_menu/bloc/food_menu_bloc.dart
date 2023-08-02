import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';
import 'package:e_restaurant_app/features/food_menu/data/repository/food_menu_repo.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../core/constants/errors.dart';

part 'food_menu_event.dart';
part 'food_menu_state.dart';

class FoodMenuBloc extends Bloc<FoodMenuEvent, FoodMenuState> {
  final FoodMenuRepo foodMenuRepo;
  FoodMenuBloc({required this.foodMenuRepo})
      : super(
          const FoodMenuState(),
        ) {
    on<FoodMenuFetched>(_foodMenuFetched);
    on<FoodMenuSearched>(_foodMenuSearched);
  }
  Future<FutureOr<void>> _foodMenuFetched(
      FoodMenuFetched event, Emitter<FoodMenuState> emit) async {
    emit(state.copyWith(foodMenuStatus: FoodMenuStatus.loading));
    final result = await foodMenuRepo.getFoodMenu();
    if (result.error == null) {
      emit(state.copyWith(
        foodMenuStatus: FoodMenuStatus.success,
        foodMenu: result.success,
      ));
    } else {
      emit(
        state.copyWith(
          foodMenuStatus: FoodMenuStatus.failure,
          errorMessage: result.error!.errorMessage,
        ),
      );
    }
  }

  FutureOr<void> _foodMenuSearched(
      FoodMenuSearched event, Emitter<FoodMenuState> emit) {
    emit(state.copyWith(foodMenuStatus: FoodMenuStatus.loading));

    final filterdFoodMenu = event.foodMenu
        .where((food) => food.name
            .toLowerCase()
            .startsWith(event.searchedFood.toLowerCase()))
        .toList();
    if (filterdFoodMenu.isEmpty) {
      emit(
        state.copyWith(
          foodMenuStatus: FoodMenuStatus.empty,
          foodMenu: [],
        ),
      );
    } else {
      emit(
        state.copyWith(
          foodMenuStatus: FoodMenuStatus.filterd,
          foodMenu: filterdFoodMenu,
        ),
      );
    }
  }
}
