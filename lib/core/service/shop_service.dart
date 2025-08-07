import 'dart:convert';
import 'dart:io';
import 'package:bingo/core/network/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopService {
  static final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  static Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }

  // Take photo with camera
  static Future<File?> takePhotoWithCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to take photo: $e');
    }
  }

  // static Future<Response> uploadImage(File file) async {
  //   final Future<Dio> dioFuture = DioClient.createDio(ApiTarget.product);
  //   final dio = await dioFuture;

  //   final formData = FormData.fromMap({
  //     "file": await MultipartFile.fromFile(file.path),
  //   });

  //   return await dio.post(
  //     'upload-product-image',
  //     data: formData,
  //   ); // Adjust the URL if needed
  // }

  static Future<Map<String, dynamic>?> uploadImage(File imageFile) async {
    // 1. Check if user is a seller
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('auth_role');

    if (role != 'seller') {
      print("Only sellers are allowed to upload images.");
      return null;
    }

    // 2. Optional: Get auth token if required by API
    final token = prefs.getString('auth_token'); // change key if needed

    final dio = await DioClient.createDio(ApiTarget.product);

    // Convert image to base64
    final bytes = await imageFile.readAsBytes();
    final base64String = base64Encode(bytes);
    
    // Send as JSON instead of FormData
    final requestData = {
      'fileName': base64String,
    };

    try {
      final response = await dio.post(
        'upload-product-image', // make sure this path is correct
        data: requestData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        print("Upload failed: ${response.statusCode}");
        print("Response: ${response.data}");
        return null;
      }
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  // // Create shop with image
  // static Future<String> createShop({
  //   required String name,
  //   required String bio,
  //   required List<String> category,
  //   required String openingHours,
  //   required String sellerId,
  //   required File imageFile,
  // }) async {
  //   return await ShopEntity.addShopWithImage(
  //     name: name,
  //     bio: bio,
  //     category: category,
  //     openingHours: openingHours,
  //     sellerId: sellerId,
  //     imageFile: imageFile,
  //   );
  // }
}
