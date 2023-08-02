import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc()
      : super(
          const FavouriteState(),
        ) {
    on<AddToFavouriteList>(_addToFavouriteList);
    on<RemoveFromFavouriteList>(_removeFromFavouriteList);
    on<FavouriteListFetched>(_favouriteListFetched);
  }

  FutureOr<void> _addToFavouriteList(
      AddToFavouriteList event, Emitter<FavouriteState> emit) {
    emit(
      state.copyWith(
        favouriteFood: [...state.favouriteFood, event.foodModel],
      ),
    );
  }

  FutureOr<void> _removeFromFavouriteList(
      RemoveFromFavouriteList event, Emitter<FavouriteState> emit) {
    List<FoodModel> updatedFavouriteFood = List.from(state.favouriteFood)
      ..remove(event.foodModel);
    emit(
      state.copyWith(
        favouriteFood: updatedFavouriteFood,
      ),
    );
  }

  FutureOr<void> _favouriteListFetched(
      FavouriteListFetched event, Emitter<FavouriteState> emit) {
    emit(
      state.copyWith(
        favouriteFood: state.favouriteFood,
      ),
    );
  }
}
