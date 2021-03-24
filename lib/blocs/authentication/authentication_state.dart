part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

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
