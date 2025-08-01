abstract class ShopState {}

class ShopStateInit extends ShopState {}

class ShopSuccessState extends ShopState {
  final String message;

  ShopSuccessState(this.message);
}

class ShopErrorState extends ShopState {
  final String errMessage;

  ShopErrorState(this.errMessage);
}

class ShopLoadingState extends ShopState {}
