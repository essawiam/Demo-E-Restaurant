// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_restaurant_app/core/constants/errors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:e_restaurant_app/features/basket/data/model/order_mode.dart';
import 'package:e_restaurant_app/features/basket/data/repository/basket_repo.dart';

import '../../food_menu/data/model/food_model.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketRepo basketRepo;
  BasketBloc({
    required this.basketRepo,
  }) : super(const BasketState()) {
    on<AddToBasket>(_addToBasket);
    on<RemoveFromBasket>(_removeFromBasket);
    on<BasketFetched>(_basketFetched);
    on<OrderSended>(_orderSended);
    on<BasketDeleted>(_basketDeleted);
  }

  FutureOr<void> _addToBasket(AddToBasket event, Emitter<BasketState> emit) {
    emit(
      state.copyWith(
          basketList: [...state.basketList, event.foodModel],
          totalPrice: state.totalPrice + event.foodModel.price),
    );
  }

  FutureOr<void> _removeFromBasket(
      RemoveFromBasket event, Emitter<BasketState> emit) {
    List<FoodModel> updatedBasket = List.from(state.basketList)
      ..remove(event.foodModel);
    emit(
      state.copyWith(
          basketList: updatedBasket,
          totalPrice: state.totalPrice - event.foodModel.price),
    );
  }

  FutureOr<void> _basketFetched(
      BasketFetched event, Emitter<BasketState> emit) {
    emit(state.copyWith(
      basketList: state.basketList,
      totalPrice: state.totalPrice,
    ));
  }

  Future<FutureOr<void>> _orderSended(
      OrderSended event, Emitter<BasketState> emit) async {
    emit(state.copyWith(basketStatus: BasketStatus.loading));
    final result = await basketRepo.sendOrder(event.orderModel);
    if (result.error == null) {
      emit(state.copyWith(
        basketStatus: BasketStatus.success,
      ));
    } else {
      emit(
        state.copyWith(
          basketStatus: BasketStatus.failure,
          errorMessage: result.error!.errorMessage,
        ),
      );
    }
  }

  FutureOr<void> _basketDeleted(
      BasketDeleted event, Emitter<BasketState> emit) {
    emit(
      state.copyWith(
        basketStatus: BasketStatus.processing,
        basketList: [],
        totalPrice: 0.0,
      ),
    );
  }
}
