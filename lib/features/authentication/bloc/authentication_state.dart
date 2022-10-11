part of 'authentication_bloc.dart';

enum AppStatus { authenticated,incomplete,complete,unauthenticated}

 class AuthenticationState extends Equatable {
  final AppStatus status;
  final UserModel user;
  const AuthenticationState._({required this.status,this.user =UserModel.empty});
  const AuthenticationState.authenticated(UserModel user):this._(status: AppStatus.authenticated, user:user);
  const AuthenticationState.unauthenticated():this._(status: AppStatus.unauthenticated);
  const AuthenticationState.imcomplete():this._(status: AppStatus.incomplete);
  const AuthenticationState.complete():this._(status: AppStatus.complete);

  @override
  List<Object> get props => [status,user];
}
