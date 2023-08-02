import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';

import '../../features/basket/data/model/order_mode.dart';
import '../error/failure.dart';

/// [DataSource] Is intended to be used as a base class for various data source implementations.

abstract class DataSource {
  Future<({Failure? error, List<FoodModel>? success})> getFoodMenu();
  Future<({Failure? error, bool? success})> sendOrder(OrderModel order);
}
