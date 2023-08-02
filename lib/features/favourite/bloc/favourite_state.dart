part of 'favourite_bloc.dart';

enum FavouriteStatus {
  success,
}

extension FoodMenuStatusX on FavouriteStatus {
  bool get isSuccess => this == FavouriteStatus.success;
}

class FavouriteState extends Equatable {
  final FavouriteStatus favouriteStatus;
  final List<FoodModel> favouriteFood;

  const FavouriteState({
    this.favouriteStatus = FavouriteStatus.success,
    this.favouriteFood = const [],
  });

  FavouriteState copyWith({
    FavouriteStatus? favouriteStatus,
    List<FoodModel>? favouriteFood,
  }) {
    return FavouriteState(
      favouriteStatus: favouriteStatus ?? this.favouriteStatus,
      favouriteFood: favouriteFood ?? this.favouriteFood,
    );
  }

  @override
  List<Object?> get props => [favouriteStatus, favouriteFood];
}
