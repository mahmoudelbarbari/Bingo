import 'dart:convert';
import 'dart:io';

import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/shops/data/models/shop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatasourceProvider {
  static final _firebaseDatasourceProvider =
      FirebaseDatasourceProvider._internal();

  factory FirebaseDatasourceProvider() {
    return _firebaseDatasourceProvider;
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseDatasourceProvider._internal();
}

abstract class ShopDatasource extends FirebaseDatasourceProvider {
  ShopDatasource() : super._internal();

  Future<BaseResponse> addShop(ShopModel shopModel, File imageFile);
}

class ShopDatasourceImpl extends ShopDatasource {
  @override
  Future<BaseResponse> addShop(ShopModel shopModel, File imageFile) async {
    try {
      // Read image as bytes

      final bytes = await imageFile.readAsBytes();
      // Convert to base64
      final base64Image = base64Encode(bytes);

      await firebaseFirestore.collection('shops').doc().set({
        'name': shopModel.name,
        'bio': shopModel.bio,
        'category': shopModel.category,
        'openingHours': shopModel.openingHours,
        'rating': '0.0',
        'sellerId': shopModel.sellerId,
        'imageBase64': base64Image,
      });
      return BaseResponse(status: true, message: 'Shop Added Successfully');
    } catch (e) {
      return BaseResponse(status: false, message: 'Failed to add shop: $e');
    }
  }
}
