import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/authentication/models/user_model.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _repository;
  late final StreamSubscription<UserModel> _userSubscription;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _repository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AuthenticationState.authenticated(
                authenticationRepository.currentUser)
            : const AuthenticationState.unauthenticated()) {
    on<AppUserChanged>(_onUserChange);
    on<AppUserLogoutRequested>(_onLogOutRequested);
    _userSubscription = authenticationRepository.user.listen((user) {
      add(AppUserChanged(user));
    });
  }

  void _onUserChange(AppUserChanged event, Emitter<AuthenticationState> emit) {
  emit(  event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated());
  }

  void _onLogOutRequested(
      AppUserLogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_repository.logout());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
