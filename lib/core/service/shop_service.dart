import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
