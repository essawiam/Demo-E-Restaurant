part of 'food_menu_bloc.dart';

@immutable
abstract class FoodMenuEvent {}

class FoodMenuFetched extends FoodMenuEvent {}

class FoodMenuSearched extends FoodMenuEvent {
  final String searchedFood;
  final List<FoodModel> foodMenu;
  FoodMenuSearched({
    required this.searchedFood,
    required this.foodMenu,
  });
}
