part of 'basket_bloc.dart';

enum BasketStatus {
  processing,
  success,
  loading,
  failure,
}

extension BasketStatusX on BasketStatus {
  bool get isprocessing => this == BasketStatus.processing;
  bool get isSuccess => this == BasketStatus.success;
  bool get isLoading => this == BasketStatus.loading;
  bool get isFailure => this == BasketStatus.failure;
}

class BasketState extends Equatable {
  final BasketStatus basketStatus;
  final List<FoodModel> basketList;
  final double totalPrice;
  final String errorMessage;

  const BasketState({
    this.basketStatus = BasketStatus.processing,
    this.basketList = const [],
    this.totalPrice = 0.0,
    this.errorMessage = noError,
  });

  BasketState copyWith({
    BasketStatus? basketStatus,
    List<FoodModel>? basketList,
    double? totalPrice,
    String? errorMessage,
  }) {
    return BasketState(
      basketStatus: basketStatus ?? this.basketStatus,
      basketList: basketList ?? this.basketList,
      totalPrice: totalPrice ?? this.totalPrice,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        basketStatus,
        basketList,
        totalPrice,
        errorMessage,
      ];
}
