part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// class AuthenticationStatusChanged extends AuthenticationEvent {
//   const AuthenticationStatusChanged(this.status);

//   final AuthenticationStatus status;

//   @override
//   List<Object> get props => [status];
// }

class AppStarted extends AuthenticationEvent {
  const AppStarted();
  @override
  List<Object> get props => [];
}

class AuthenticationRequest extends AuthenticationEvent {
  AuthenticationRequest({required this.username, required this.password});
  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class Authenticated extends AuthenticationEvent {
  Authenticated({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class NotAuthenticated extends AuthenticationEvent {
  const NotAuthenticated();
  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class FacebookAuthenticationRequested extends AuthenticationEvent {}
