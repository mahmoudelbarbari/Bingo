import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:get/get.dart';

class CartController {
  var cartDataDetails = <ProductModel>[].obs;

  double cartTotalPrice() {
    double total = 0;
    double delivartFee = 25.0;
    double serviceFee = 12.0;
    for (var item in cartDataDetails) {
      double? price = item.price;
      total += price! + delivartFee + serviceFee;
    }
    return total;
  }
}
