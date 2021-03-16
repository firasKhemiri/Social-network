import 'package:flutter_login/repositories/user/user_repository.dart';

class LoginQueries {
  final UserRepository _userRepository = UserRepository();
  Future<String> getTokenFromRefreshToken() async {
    return """
    mutation {
      refreshToken(refreshToken: "${await _userRepository.getRefreshToken()}")
      {
        token
        payload
        refreshToken
        refreshExpiresIn
      }
    }
    """;
  }

  String getTokenByUsername(String username, String pass) {
    return """
    mutation {
      tokenAuth(username: "$username", password: "$pass")
      {
        token
        payload
        refreshToken
        refreshExpiresIn
      }
    }
    """;
  }
}
