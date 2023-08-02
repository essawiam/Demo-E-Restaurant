// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_menu_bloc.dart';

enum FoodMenuStatus {
  initial,
  loading,
  success,
  failure,
  filterd,
  empty,
}

extension FoodMenuStatusX on FoodMenuStatus {
  bool get isInitial => this == FoodMenuStatus.initial;
  bool get isLoading => this == FoodMenuStatus.loading;
  bool get isSuccess => this == FoodMenuStatus.success;
  bool get isFailure => this == FoodMenuStatus.failure;
  bool get isFilterd => this == FoodMenuStatus.filterd;
  bool get isEmpty => this == FoodMenuStatus.empty;
}

class FoodMenuState extends Equatable {
  final FoodMenuStatus foodMenuStatus;
  final List<FoodModel>? foodMenu;
  final String? errorMessage;

  const FoodMenuState({
    this.foodMenuStatus = FoodMenuStatus.initial,
    this.foodMenu = const [],
    this.errorMessage = noError,
  });

  FoodMenuState copyWith({
    FoodMenuStatus? foodMenuStatus,
    List<FoodModel>? foodMenu,
    String? errorMessage,
  }) {
    return FoodMenuState(
      foodMenuStatus: foodMenuStatus ?? this.foodMenuStatus,
      foodMenu: foodMenu ?? this.foodMenu,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [foodMenuStatus, foodMenu, errorMessage];
}
