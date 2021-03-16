import 'dart:async';
import 'package:flutter_login/common/storage/secure_storage.dart';

import '../../models/user/bucket.dart';

class UserRepository {
  final SecureStorage _secureStorage = SecureStorage();

  // Future<User> getUser() async {
  //   if (_user != null) return _user;
  //   return Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () => _user = const User(id: 1, name: '', imageUrl: ''),
  //   );
  // }

  Future<void> deleteToken() async {
    return await _secureStorage.deleteSecureData('token');
  }

  Future<void> deleteRefreshToken() async {
    return await _secureStorage.deleteSecureData('refreshToken');
  }

  Future<void> persistUserCredentials(Map<String, String> credentials) async {
    /// write to keystore/keychain
    return await _secureStorage.writeSecureDataMap(credentials);
  }

  Future<String> getToken() async {
    return await _secureStorage.readSecureData('token');
  }

  Future<String> getRefreshToken() async {
    return await _secureStorage.readSecureData('refreshToken');
  }

  Future<User?> getUser() async {
    var _user = await _secureStorage.readAllSecureData().then(
        (credentials) => credentials['token'] != null ? User.generic : null);
    return _user;
  }
}
