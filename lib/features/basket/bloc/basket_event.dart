part of 'basket_bloc.dart';

@immutable
abstract class BasketEvent {}

class AddToBasket extends BasketEvent {
  final FoodModel foodModel;

  AddToBasket({
    required this.foodModel,
  });
}

class RemoveFromBasket extends BasketEvent {
  final FoodModel foodModel;

  RemoveFromBasket({
    required this.foodModel,
  });
}

class BasketFetched extends BasketEvent {}

class OrderSended extends BasketEvent {
  final OrderModel orderModel;

  OrderSended({
    required this.orderModel,
  });
}

class BasketDeleted extends BasketEvent {}
