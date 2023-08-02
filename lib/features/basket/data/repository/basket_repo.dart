import 'package:e_restaurant_app/features/basket/data/model/order_mode.dart';

import '../../../../core/data/data_source.dart';
import '../../../../core/error/failure.dart';

/// [BasketRepo] Is like a single point of truth.
///
/// Controls where to call the data like [Local DB, Remote API].
class BasketRepo {
  final DataSource dataSource;

  BasketRepo({required this.dataSource});

  Future<({Failure? error, bool? success})> sendOrder(OrderModel order) async {
    return await dataSource.sendOrder(order);
  }
}
