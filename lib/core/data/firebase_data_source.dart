import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_restaurant_app/core/error/failure.dart';
import 'package:e_restaurant_app/features/basket/data/model/order_mode.dart';

import 'package:e_restaurant_app/features/food_menu/data/model/food_model.dart';

import 'data_source.dart';

class FirebaseDataSource extends DataSource {
  final FirebaseFirestore firebaseFirestore;

  FirebaseDataSource({
    required this.firebaseFirestore,
  });

  @override
  Future<({Failure? error, List<FoodModel>? success})> getFoodMenu() async {
    final CollectionReference foodCollection =
        firebaseFirestore.collection('food_menu');
    List<FoodModel> foodMenu = [];
    try {
      QuerySnapshot snapshot = await foodCollection.get();

      for (var doc in snapshot.docs) {
        FoodModel food =
            FoodModel.fromJson(doc.id, doc.data() as Map<String, dynamic>);
        foodMenu.add(food);
      }
      return (error: null, success: foodMenu);
    } catch (e) {
      return (
        error: Failure(
          errorMessage: e.toString(),
        ),
        success: null
      );
    }
  }

  @override
  Future<({Failure? error, bool? success})> sendOrder(OrderModel order) async {
    final CollectionReference odersCollection =
        firebaseFirestore.collection('orders');
    try {
      await odersCollection.add(order.toMap());
      return (error: null, success: true);
    } catch (e) {
      return (
        error: Failure(
          errorMessage: e.toString(),
        ),
        success: null
      );
    }
  }
}
