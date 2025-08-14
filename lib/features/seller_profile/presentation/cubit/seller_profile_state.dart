import 'package:bingo/features/shops/domain/entity/shop_entity.dart';

import '../../domain/entities/event.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/entities/seller_profile.dart';

class SellerProfileState {
  final SellerProfile? profile;
  final ShopEntity? shopEntity;
  final List<Product> products;
  final List<Event> events;
  final List<Review> reviews;

  final bool isProfileLoading;
  final bool isProductsLoading;
  final bool isEventsLoading;
  final bool isReviewsLoading;

  final String? errorMessage;

  const SellerProfileState({
    this.profile,
    this.shopEntity,
    this.products = const [],
    this.events = const [],
    this.reviews = const [],
    this.isProfileLoading = false,
    this.isProductsLoading = false,
    this.isEventsLoading = false,
    this.isReviewsLoading = false,
    this.errorMessage,
  });

  SellerProfileState copyWith({
    SellerProfile? profile,
    ShopEntity? shopEntity,
    List<Product>? products,
    List<Event>? events,
    List<Review>? reviews,
    bool? isProfileLoading,
    bool? isProductsLoading,
    bool? isEventsLoading,
    bool? isReviewsLoading,
    String? errorMessage,
  }) {
    return SellerProfileState(
      profile: profile ?? this.profile,
      shopEntity: shopEntity ?? this.shopEntity,
      products: products ?? this.products,
      events: events ?? this.events,
      reviews: reviews ?? this.reviews,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      isEventsLoading: isEventsLoading ?? this.isEventsLoading,
      isReviewsLoading: isReviewsLoading ?? this.isReviewsLoading,
      errorMessage: errorMessage,
    );
  }
}
