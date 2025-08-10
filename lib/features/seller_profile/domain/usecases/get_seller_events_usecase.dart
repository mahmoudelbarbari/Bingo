import '../entities/event.dart';
import '../repo/seller_profile_repo.dart';

class GetSellerEventsUseCase {
  final SellerProfileRepository repository;

  GetSellerEventsUseCase(this.repository);

  Future<List<Event>> call(String sellerId) async {
    return await repository.getSellerEvents(sellerId);
  }
}

//async
