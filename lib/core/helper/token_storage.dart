import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Add role management methods
  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_role', role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_role');
  }

  static Future<void> clearRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_role');
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Check if user is seller
  static Future<bool> isSeller() async {
    final role = await getRole();
    return role == 'seller';
  }

  // Add shopId management methods
  static Future<void> saveShopId(String shopId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('seller_shop_id', shopId);
  }

  static Future<String?> getShopId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('seller_shop_id');
  }

  static Future<void> clearShopId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('seller_shop_id');
  }

  // Add sellerId management methods
  static Future<void> saveSellerId(String sellerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('seller_id', sellerId);
  }

  static Future<String?> getSellerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('seller_id');
  }

  static Future<void> clearSellerId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('seller_id');
  }

  // Clear all auth data
  static Future<void> clearAll() async {
    await clearToken();
    await clearRole();
    await clearShopId();
    await clearSellerId();
  }
}
