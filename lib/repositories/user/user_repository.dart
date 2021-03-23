import 'dart:async';
import 'dart:developer';
import 'package:flutter_login/common/storage/secure_storage.dart';
import 'package:flutter_login/main.dart';
import 'package:flutter_login/repositories/user/sembast_user_repository.dart';

import '../../models/user/bucket.dart';

class UserRepository {
  final SecureStorage _secureStorage = SecureStorage();
  final SembastUserRepository _userRepositoryDB = SembastUserRepository();
  Future<void> deleteToken() async {
    return await _secureStorage.deleteSecureData('token');
  }

  Future<void> deleteRefreshToken() async {
    return await _secureStorage.deleteSecureData('refreshToken');
  }

  Future<void> persistUser(Map<String, String> credentials, User user) async {
    /// write to keystore/keychain
    await _secureStorage.writeSecureDataMap(credentials);
    await _userRepositoryDB.addUser(user);

    // var dbUser = await _userRepositoryDB.getUser(user);

    // var ser = await _userRepositoryDB.getAllUsers();
    // ser.forEach((element) {
    //   log('db user ${element.phone} name ${element.firstName}');
    // });
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

  void _checkForConnectedUserFB() {}
}
