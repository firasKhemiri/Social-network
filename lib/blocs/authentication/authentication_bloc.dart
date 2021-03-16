import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/models/user/user.dart';
import 'package:flutter_login/repositories/user/user_repository.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })   : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(AuthenticationInitial()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    log('event status: ${event.status}');
    switch (event.status) {
      case AuthenticationStatus.unknown:
        final _user = await _userRepository.getUser();
        if (_user != null) {
          log('user: ${_user.toString()}');
          return AuthenticationSuccess(user: _user);
        }
        return const AuthenticationFailure(message: 'message');

      case AuthenticationStatus.unauthenticated:
        return const AuthenticationFailure(message: 'message');

      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return user != null
            ? AuthenticationSuccess(user: user)
            : const AuthenticationFailure(message: 'message');

      default:
        return AuthenticationInitial();
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
