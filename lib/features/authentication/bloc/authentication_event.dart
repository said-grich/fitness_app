part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppUserLogoutRequested extends AuthenticationEvent {}
class AppUserSingUp extends AuthenticationEvent {}
class AppUserInfoComplete extends AuthenticationEvent {}
class AppUserLogoutWithoutCompletInfo extends AuthenticationEvent {}

class AppUserChanged extends AuthenticationEvent {
  final UserModel user;
 const AppUserChanged(this.user);
  @override
  List<Object> get props => [user];
  
}

