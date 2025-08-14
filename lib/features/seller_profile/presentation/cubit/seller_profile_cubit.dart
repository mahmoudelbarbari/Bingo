import 'package:bingo/features/seller_profile/domain/usecases/get_seller_data_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_seller_events_usecase.dart';
import '../../domain/usecases/get_seller_products.dart';
import '../../domain/usecases/get_seller_profile.dart';
import '../../domain/usecases/get_seller_reviews_usecase.dart';
import 'seller_profile_state.dart';

class SellerProfileCubit extends Cubit<SellerProfileState> {
  final GetSellerProfile _getSellerProfile;
  final GetSellerProducts _getSellerProducts;
  final GetSellerEventsUseCase _getSellerEvents;
  final GetSellerReviewsUseCase _getSellerReviews;
  final GetSellerDataUsecase _getSellerDataUsecase;

  SellerProfileCubit({
    required GetSellerProfile getSellerProfile,
    required GetSellerProducts getSellerProducts,
    required GetSellerEventsUseCase getSellerEvents,
    required GetSellerReviewsUseCase getSellerReviews,
    required GetSellerDataUsecase getSellerDataUsecase,
  }) : _getSellerProfile = getSellerProfile,
       _getSellerProducts = getSellerProducts,
       _getSellerEvents = getSellerEvents,
       _getSellerReviews = getSellerReviews,
       _getSellerDataUsecase = getSellerDataUsecase,
       super(const SellerProfileState());

  Future<void> fetchSellerProfile(String sellerId) async {
    emit(state.copyWith(isProfileLoading: true, errorMessage: null));
    try {
      final profile = await _getSellerProfile(sellerId);
      final sellerData = await _getSellerDataUsecase();
      emit(
        state.copyWith(
          profile: profile,
          shopEntity: sellerData,
          isProfileLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isProfileLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> fetchSellerProducts(String sellerId) async {
    emit(state.copyWith(isProductsLoading: true, errorMessage: null));
    try {
      final products = await _getSellerProducts(sellerId);
      emit(state.copyWith(products: products, isProductsLoading: false));
    } catch (e) {
      emit(
        state.copyWith(isProductsLoading: false, errorMessage: e.toString()),
      );
    }
  }

  Future<void> fetchSellerEvents(String sellerId) async {
    emit(state.copyWith(isEventsLoading: true, errorMessage: null));
    try {
      final events = await _getSellerEvents(sellerId);
      emit(state.copyWith(events: events, isEventsLoading: false));
    } catch (e) {
      emit(state.copyWith(isEventsLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> fetchSellerReviews(String sellerId) async {
    emit(state.copyWith(isReviewsLoading: true, errorMessage: null));
    try {
      final reviews = await _getSellerReviews(sellerId);
      emit(state.copyWith(reviews: reviews, isReviewsLoading: false));
    } catch (e) {
      emit(state.copyWith(isReviewsLoading: false, errorMessage: e.toString()));
    }
  }
}
