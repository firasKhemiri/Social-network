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
        super(AuthenticationInitial());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      log('app statreted event called');
      final _user = await _userRepository.getConnectedUser();
      if (_user != null) {
        log('user: ${_user.toString()}');
        yield AuthenticationSuccess(user: _user);
      } else
        add(const NotAuthenticated());
    }

    if (event is NotAuthenticated) {
      yield const AuthenticationFailure(message: 'User is not authenticated');
    }

    if (event is FacebookAuthenticationRequested) {
      yield AuthenticationLoading();
      try {
        var user = await _authenticationRepository.facebookLogIn();
        add(Authenticated(user: user));
      } on Exception catch (_) {
        log('${_.toString()}');
        yield const AuthenticationFailure(message: 'An issue has occured');
      }
    }

    if (event is Authenticated) {
      var user = event.user;
      yield AuthenticationSuccess(user: user);
    }
    if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
      add(const NotAuthenticated());
    }
    log('event ${state.toString()}');
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
