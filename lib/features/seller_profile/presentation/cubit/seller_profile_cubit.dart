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

  SellerProfileCubit({
    required GetSellerProfile getSellerProfile,
    required GetSellerProducts getSellerProducts,
    required GetSellerEventsUseCase getSellerEvents,
    required GetSellerReviewsUseCase getSellerReviews,
  }) : _getSellerProfile = getSellerProfile,
       _getSellerProducts = getSellerProducts,
       _getSellerEvents = getSellerEvents,
       _getSellerReviews = getSellerReviews,
       super(SellerProfileInitial());

  Future<void> fetchSellerProfile(String sellerId) async {
    emit(SellerProfileLoadingProfile());
    try {
      final profile = await _getSellerProfile(sellerId);
      if (profile != null) {
        emit(SellerProfileLoadedProfile(profile));
      } else {
        emit(SellerProfileError('تعذر تحميل بيانات البروفايل.'));
      }
    } catch (e) {
      emit(SellerProfileError(e.toString()));
    }
  }

  Future<void> fetchSellerProducts(String sellerId) async {
    emit(SellerProfileLoadingProducts());
    try {
      final products = await _getSellerProducts(sellerId);
      emit(SellerProfileLoadedProducts(products));
    } catch (e) {
      emit(SellerProfileError(e.toString()));
    }
  }

  Future<void> fetchSellerEvents(String sellerId) async {
    emit(SellerProfileLoadingEvents());
    try {
      final events = await _getSellerEvents(sellerId);
      emit(SellerProfileLoadedEvents(events));
    } catch (e) {
      emit(SellerProfileError(e.toString()));
    }
  }

  Future<void> fetchSellerReviews(String sellerId) async {
    emit(SellerProfileLoadingReviews());
    try {
      final reviews = await _getSellerReviews(sellerId);
      emit(SellerProfileLoadedReviews(reviews));
    } catch (e) {
      emit(SellerProfileError(e.toString()));
    }
  }
}
