import 'package:bingo/core/service/current_user_service.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bingo/core/util/base_response.dart';

class FirebaseDatasourceProvider {
  static final _firebaseDatasourceProvider =
      FirebaseDatasourceProvider._internal();

  factory FirebaseDatasourceProvider() {
    return _firebaseDatasourceProvider;
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatasourceProvider._internal();
}

abstract class CartDatasourceInterface extends FirebaseDatasourceProvider {
  CartDatasourceInterface() : super._internal();

  Future<BaseResponse> addProductToCart(ProductModel productModel);
  Future<List<ProductModel>> getAllCartItems();
  Future<BaseResponse> clearCartItems();
  Future<List<ProductModel>> viewwOrder();
  Future<BaseResponse> deleteItemById(String id);
  Future<BaseResponse> updateQuantity(String productId, int quantity);
  Future<int> getCartItemCount();
  Future<double> getCartTotal();
}

class CartDatasourceImpl extends CartDatasourceInterface {
  CartDatasourceImpl() : super();

  @override
  Future<BaseResponse> addProductToCart(ProductModel productModel) async {
    try {
      // Get current user ID from local storage
      final userId = await CurrentUserService.getCurrentUserId();
      if (userId == null) {
        return BaseResponse(status: false, message: 'User not authenticated');
      }

      // Create cart item data
      final cartItemData = {
        'userId': userId,
        'productId': productModel.id,
        'title': productModel.title,
        'shortDescription': productModel.shortDescription,
        'price': productModel.price,
        'salePrice': productModel.salePrice,
        'image': productModel.image?.first['url'] ?? '',
        'quantity': 1,
        'addedAt': FieldValue.serverTimestamp(),
        'shopId': productModel.shopId,
      };

      // Check if product already exists in cart
      final existingItem = await firebaseFirestore
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .where('productId', isEqualTo: productModel.id)
          .get();

      if (existingItem.docs.isNotEmpty) {
        // Update quantity if product already exists
        await firebaseFirestore
            .collection('cart')
            .doc(existingItem.docs.first.id)
            .update({
              'quantity': existingItem.docs.first.data()['quantity'] + 1,
              'updatedAt': FieldValue.serverTimestamp(),
            });
      } else {
        // Add new product to cart
        await firebaseFirestore.collection('cart').add(cartItemData);
      }

      return BaseResponse(
        status: true,
        message: 'Product added to cart successfully',
      );
    } catch (e) {
      return BaseResponse(
        status: false,
        message: 'Failed to add product to cart: $e',
      );
    }
  }

  @override
  Future<List<ProductModel>> getAllCartItems() async {
    try {
      // Get current user ID from local storage
      final userId = await CurrentUserService.getCurrentUserId();
      if (userId == null) {
        print('No user ID found, returning empty cart');
        return [];
      }

      print('Getting cart items for user: $userId');

      // Get cart items for the current user only
      final cartSnapshot = await firebaseFirestore
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .get();

      print('Found ${cartSnapshot.docs.length} cart items in Firebase');

      return cartSnapshot.docs.map((doc) {
        final data = doc.data();
        print('Cart item data: $data');

        String imageUrl = data['image'] ?? '';
        // Handle relative URLs if needed
        if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
          imageUrl = 'https://ik.imagekit.io/zeyuss/$imageUrl';
        }

        return ProductModel(
          id: data['productId'],
          title: data['title'],
          shortDescription: data['shortDescription'],
          price: (data['price'] as num?)?.toDouble(),
          salePrice: (data['salePrice'] as num?)?.toDouble(),
          image: [
            {'url': imageUrl},
          ],
          shopId: data['shopId'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      if (e.code == 'failed-precondition') {
        print('Create missing index: ${e.message}');
      }
      throw Exception(e.message);
    } catch (e) {
      print('Error getting cart items: $e');
      throw Exception('Failed to get cart items: $e');
    }
  }

  @override
  Future<BaseResponse> updateQuantity(String productId, int quantity) async {
    try {
      // Get current user ID from local storage
      final userId = await CurrentUserService.getCurrentUserId();
      if (userId == null) {
        return BaseResponse(status: false, message: 'User not authenticated');
      }

      final cartItem = await firebaseFirestore
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .where('productId', isEqualTo: productId)
          .get();

      if (cartItem.docs.isNotEmpty) {
        if (quantity <= 0) {
          // Remove item if quantity is 0 or less
          await firebaseFirestore
              .collection('cart')
              .doc(cartItem.docs.first.id)
              .delete();
        } else {
          // Update quantity
          await firebaseFirestore
              .collection('cart')
              .doc(cartItem.docs.first.id)
              .update({
                'quantity': quantity,
                'updatedAt': FieldValue.serverTimestamp(),
              });
        }
        return BaseResponse(
          status: true,
          message: 'Quantity updated successfully',
        );
      }
      return BaseResponse(status: false, message: 'Product not found in cart');
    } catch (e) {
      return BaseResponse(
        status: false,
        message: 'Failed to update quantity: $e',
      );
    }
  }

  @override
  Future<BaseResponse> clearCartItems() async {
    try {
      // Get current user ID from local storage
      final userId = await CurrentUserService.getCurrentUserId();
      if (userId == null) {
        return BaseResponse(status: false, message: 'User not authenticated');
      }

      final cartSnapshot = await firebaseFirestore
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .get();

      final batch = firebaseFirestore.batch();
      for (var doc in cartSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      return BaseResponse(status: true, message: 'Cart cleared successfully');
    } catch (e) {
      return BaseResponse(status: false, message: 'Failed to clear cart: $e');
    }
  }

  @override
  Future<BaseResponse> deleteItemById(String id) async {
    try {
      // Get current user ID from local storage
      final userId = await CurrentUserService.getCurrentUserId();
      if (userId == null) {
        return BaseResponse(status: false, message: 'User not authenticated');
      }

      final cartItem = await firebaseFirestore
          .collection('cart')
          .where('productId', isEqualTo: id)
          .get();

      if (cartItem.docs.isNotEmpty) {
        await firebaseFirestore
            .collection('cart')
            .doc(cartItem.docs.first.id)
            .delete();
        return BaseResponse(status: true, message: 'Item removed from cart');
      }
      return BaseResponse(status: false, message: 'Product not found in cart');
    } catch (e) {
      return BaseResponse(status: false, message: 'Failed to remove item: $e');
    }
  }

  @override
  Future<int> getCartItemCount() async {
    try {
      // Get current user ID from local storage
      final userId = await CurrentUserService.getCurrentUserId();
      if (userId == null) return 0;

      final cartSnapshot = await firebaseFirestore
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .get();

      return cartSnapshot.docs.length;
    } catch (e) {
      print('Error getting cart count: $e');
      return 0;
    }
  }

  @override
  Future<double> getCartTotal() async {
    try {
      // Get current user ID from local storage
      final userId = await CurrentUserService.getCurrentUserId();
      if (userId == null) return 0;

      final cartSnapshot = await firebaseFirestore
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .get();

      // Synchronous fold
      final total = cartSnapshot.docs.fold<double>(0.0, (total, doc) {
        final data = doc.data();
        final price = (data['price'] as num?)?.toDouble() ?? 0;
        final quantity = data['quantity'] as int? ?? 1;
        return total + (price * quantity);
      });

      return total;
    } catch (e) {
      print('Error calculating cart total: $e');
      return 0;
    }
  }

  @override
  Future<List<ProductModel>> viewwOrder() {
    throw UnimplementedError();
  }
}
