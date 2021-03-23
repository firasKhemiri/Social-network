import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/login/bucket.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:formz/formz.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class LoginBloc extends Bloc<SignupEvent, SignupState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(const SignupState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is SignupPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignupSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  SignupState _mapUsernameChangedToState(
    SignupUsernameChanged event,
    SignupState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  SignupState _mapPasswordChangedToState(
    SignupPasswordChanged event,
    SignupState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<SignupState> _mapLoginSubmittedToState(
    SignupSubmitted event,
    SignupState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
