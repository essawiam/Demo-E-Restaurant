import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';

import '../../../../core/data/data_source.dart';
import '../../../../core/error/failure.dart';

/// [FoodMenuRepo] Is like a single point of truth.
///
/// Controls where to call the data like [Local DB, Remote API].
class FoodMenuRepo {
  final DataSource dataSource;

  FoodMenuRepo({required this.dataSource});

  Future<({Failure? error, List<FoodModel>? success})> getFoodMenu() async {
    return await dataSource.getFoodMenu();
  }
}
