import '../../../food_menu/data/model/food_model.dart';

class OrderModel {
  final List<FoodModel> foodItems;
  final double totalPrice;
  final String address;
  OrderModel({
    required this.foodItems,
    required this.totalPrice,
    required this.address,
  });
  Map<String, dynamic> toMap() {
    return {
      'foodItems': foodItems.map((item) => item.toMap()).toList(),
      'price': totalPrice,
      'address': address,
    };
  }
}
