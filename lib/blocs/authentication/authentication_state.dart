part of 'authentication_bloc.dart';

// class AuthenticationState extends Equatable {
//   const AuthenticationState._({
//     this.status = AuthenticationStatus.unknown,
//     this.user = User.generic,
//   });

//   const AuthenticationState.unknown() : this._();

//   const AuthenticationState.authenticated(User user)
//       : this._(status: AuthenticationStatus.authenticated, user: user);

//   const AuthenticationState.unauthenticated()
//       : this._(status: AuthenticationStatus.unauthenticated);

//   final AuthenticationStatus status;
//   final User user;

//   @override
//   List<Object> get props => [status, user];
// }

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationNotAuthenticated extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess({required this.user});
  final User user;
  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  const AuthenticationFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
