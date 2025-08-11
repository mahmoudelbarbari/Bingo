import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../helper/token_storage.dart';

class CurrentUserService {
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    return await TokenStorage.getCurrentUser();
  }

  static Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userMap = prefs.getString('current_user');
    if (userMap == null) return null;

    final user = jsonDecode(userMap);
    return user['id']?.toString();
  }

  static Future<String?> getCurrentUserEmail() async {
    final user = await getCurrentUser();
    return user?['email'];
  }

  static Future<bool> isCurrentUserSeller() async {
    final role = await TokenStorage.getRole();
    return role == 'seller';
  }

  static Future<String?> getCurrentSellerId() async {
    if (await isCurrentUserSeller()) {
      return await TokenStorage.getSellerId();
    }
    return null;
  }
}
