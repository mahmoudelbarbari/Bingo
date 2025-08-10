import '../../domain/entities/event.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/entities/seller_profile.dart';

abstract class SellerProfileState {}

class SellerProfileInitial extends SellerProfileState {}

class SellerProfileLoadingProfile extends SellerProfileState {}

class SellerProfileLoadedProfile extends SellerProfileState {
  final SellerProfile profile;
  SellerProfileLoadedProfile(this.profile);
}

class SellerProfileLoadingProducts extends SellerProfileState {}

class SellerProfileLoadedProducts extends SellerProfileState {
  final List<Product> products;
  SellerProfileLoadedProducts(this.products);
}

class SellerProfileLoadingEvents extends SellerProfileState {}

class SellerProfileLoadedEvents extends SellerProfileState {
  final List<Event> events;
  SellerProfileLoadedEvents(this.events);
}

class SellerProfileLoadingReviews extends SellerProfileState {}

class SellerProfileLoadedReviews extends SellerProfileState {
  final List<Review> reviews;
  SellerProfileLoadedReviews(this.reviews);
}

class SellerProfileError extends SellerProfileState {
  final String message;
  SellerProfileError(this.message);
}
