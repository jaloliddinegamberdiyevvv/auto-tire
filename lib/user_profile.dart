import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phone = '',
  });

  static const String _storageKey = 'user_profile';
  static const String _passwordKey = 'user_password';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  static Future<UserProfile?> load() async {
    final preferences = await SharedPreferences.getInstance();
    final String? storedProfile = preferences.getString(_storageKey);
    if (storedProfile == null) return null;

    final Object? decoded = jsonDecode(storedProfile);
    if (decoded is! Map<String, dynamic> ||
        decoded['firstName'] is! String ||
        decoded['lastName'] is! String ||
        decoded['email'] is! String) {
      throw const FormatException('Saqlangan profil ma’lumotlari noto‘g‘ri.');
    }

    final String password = await _secureStorage.read(key: _passwordKey) ?? '';

    return UserProfile(
      firstName: decoded['firstName'] as String,
      lastName: decoded['lastName'] as String,
      email: decoded['email'] as String,
      password: password,
      phone: decoded['phone'] as String? ?? '',
    );
  }

  Future<void> save() async {
    await _secureStorage.write(key: _passwordKey, value: password);
    final preferences = await SharedPreferences.getInstance();
    final bool saved = await preferences.setString(
      _storageKey,
      jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
      }),
    );
    if (!saved) {
      throw StateError('Profil ma’lumotlarini saqlab bo‘lmadi.');
    }
  }
}
