import 'dart:async';
import 'dart:developer';

import 'package:flutter_login/common/graphql/graphql_config.dart';
import 'package:flutter_login/common/graphql/queries/bucket.dart';
import 'package:flutter_login/models/user/user.dart';
import 'package:flutter_login/repositories/user/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _queryMutation = LoginQueries();
  final _userRepository = UserRepository();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final client = GraphQLService(null);
      final result = await client.performQuery(
          _queryMutation.getTokenByUsername('firas', 'delln5110'));

      // JsonCodec codec = new JsonCodec();
      // var decoded = codec.decode(
      //     '{"id": 1,"username": "firas", "firstName": "Firas","lastName": "Khmeir","coverPicture": "","email": "firasskhemir@gmail.com","bio": "well hello","birthday": null,"gender": "Male", "picture": "/static/profiles/firas_1/1.jpg","phone": "26595513","following": [2],"followers": [3]}');

      var data =
          result.data['tokenAuth']['payload']['User'] as Map<String, dynamic>;

      var user = _getUserfromData(data);

      _controller.add(AuthenticationStatus.authenticated);

      // log('logging rep ${result.data.toString()}');
      final token = result.data['tokenAuth']['token'].toString();
      final refreshToken = result.data['tokenAuth']['refreshToken'].toString();
      final credentials = {
        'email': username,
        'password': password,
        'token': token,
        'refreshToken': refreshToken,
      };
      await _userRepository.persistUser(credentials, user);
    } catch (e) {
      log(e.toString());
      throw Exception('Wrong username or password');
    }
  }

  Future<void> signInWithRefreshToken() async {
    try {
      final client = GraphQLService(null);
      final result = await client
          .performMutation(await _queryMutation.getTokenFromRefreshToken());

      var data = result.data['refreshToken']['payload']['User']
          as Map<String, dynamic>;

      var user = _getUserfromData(data);

      final token = result.data['refreshToken']['token'].toString();
      final refreshToken =
          result.data['refreshToken']['refreshToken'].toString();
      final credentials = {
        'token': token,
        'refreshToken': refreshToken,
      };

      await _userRepository.persistUser(credentials, user);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception('Invalid refresh token');
    }
  }

  void logOut() async {
    _controller.add(AuthenticationStatus.unauthenticated);
    await _userRepository.deleteToken();
    await _userRepository.deleteRefreshToken();
  }

  void dispose() => _controller.close();

  User _getUserfromData(Map<String, dynamic> data) {
    var user = User.fromJson(data);
    log('user: ${user.firstName} ${user.phone}');
    return user;
    // return User.generic;
  }
}
