part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class AddToFavouriteList extends FavouriteEvent {
  final FoodModel foodModel;

  AddToFavouriteList({
    required this.foodModel,
  });
}

class RemoveFromFavouriteList extends FavouriteEvent {
  final FoodModel foodModel;

  RemoveFromFavouriteList({
    required this.foodModel,
  });
}

class FavouriteListFetched extends FavouriteEvent {}
