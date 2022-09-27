part of 'authentication_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

 class AuthenticationState extends Equatable {
  final AppStatus status;
  final UserModel user;
  const AuthenticationState._({required this.status,this.user =UserModel.empty});
  const AuthenticationState.authenticated(UserModel user):this._(status: AppStatus.authenticated, user:user);
  const AuthenticationState.unauthenticated():this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [status,user];
}
