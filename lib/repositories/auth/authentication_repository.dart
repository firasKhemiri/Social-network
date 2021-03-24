import 'dart:async';
import 'dart:developer';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login/common/graphql/graphql_config.dart';
import 'package:flutter_login/common/graphql/queries/bucket.dart';
import 'package:flutter_login/models/user/user.dart';
import 'package:flutter_login/repositories/user/user_repository.dart';

class AuthenticationRepository {
  final _queryMutation = LoginQueries();
  final _userRepository = UserRepository();

  Future<User> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final client = GraphQLService(null);
      final result = await client.performQuery(
          _queryMutation.getTokenByUsername('firas', 'delln5110'));

      var data =
          result.data['tokenAuth']['payload']['User'] as Map<String, dynamic>;
      var user = _userRepository.getUserfromData(data);

      final token = result.data['tokenAuth']['token'].toString();
      final refreshToken = result.data['tokenAuth']['refreshToken'].toString();
      final credentials = {
        'id': user.id.toString(),
        'email': username,
        'password': password,
        'token': token,
        'refreshToken': refreshToken,
      };
      await _userRepository.persistUser(credentials, user);
      return user;
    } catch (e) {
      log(e.toString());
      throw Exception('Wrong username or password');
    }
  }

  Future<User> facebookLogIn() async {
    try {
      var _accessToken = await _getFacebookToken();

      final client = GraphQLService(null);
      final result = await client
          .performQuery(_queryMutation.getTokenByFB(_accessToken.token));

      var data =
          result.data['authUserFacebook']['user'] as Map<String, dynamic>;

      log('data ${result.data.toString()}');

      var user = _userRepository.getUserfromData(data);

      final token = result.data['authUserFacebook']['token'].toString();
      final refreshToken =
          result.data['authUserFacebook']['refreshToken'].toString();

      final credentials = {
        'id': user.id.toString(),
        'token': token,
        'refreshToken': refreshToken,
      };
      await _userRepository.persistUser(credentials, user);
      return user;
    } catch (e) {
      log(e.toString());
      throw Exception('Something went wrong');
    }
  }

  Future<AccessToken> _getFacebookToken() async {
    var _accesToken = await FacebookAuth.instance.accessToken;
    if (_accesToken == null) {
      try {
        _accesToken = await FacebookAuth.instance.login();
      } on FacebookAuthException catch (e) {
        switch (e.errorCode) {
          case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
            print('You have a previous login operation in progress');
            rethrow;
          case FacebookAuthErrorCode.CANCELLED:
            print('login cancelled');
            rethrow;
          case FacebookAuthErrorCode.FAILED:
            print('login failed');
            rethrow;
        }
      }
    }
    return _accesToken!;
  }

  Future<User?> signInWithRefreshToken() async {
    try {
      final client = GraphQLService(null);
      final result = await client
          .performMutation(await _queryMutation.getTokenFromRefreshToken());

      var data = result.data['refreshToken']['payload']['User']
          as Map<String, dynamic>;
      var user = _userRepository.getUserfromData(data);

      final token = result.data['refreshToken']['token'].toString();
      final refreshToken =
          result.data['refreshToken']['refreshToken'].toString();
      final credentials = {
        'token': token,
        'refreshToken': refreshToken,
      };

      await _userRepository.persistUser(credentials, user);
      return user;
    } catch (e) {
      throw Exception('Invalid refresh token');
    }
  }

  void logOut() async {
    await _userRepository.deleteSecureData();
    if (await FacebookAuth.instance.accessToken != null)
      await FacebookAuth.instance.logOut();
  }
}
