import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/bloc_export.dart';
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
    on<AppUserSingUp>(_onSingUP);
    on<AppUserInfoComplete>(_onInfoComplete);
    on<AppUserLogoutWithoutCompletInfo>(_onunathntecated);
    _userSubscription = authenticationRepository.user.listen((user) async {
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      if (user.isNotEmpty && user.id != null) {

        var userDocRef = fireStore.collection('users').doc(user.id);
        var doc = await userDocRef.get();
        if (doc.exists) {
          add(AppUserChanged(user));
        } else {
          add(AppUserSingUp());
        }
      } else {
        add(AppUserLogoutWithoutCompletInfo());
      }
    });
  }

  void _onUserChange(AppUserChanged event, Emitter<AuthenticationState> emit) {
    return emit(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated());
  }

  void _onLogOutRequested(
      AppUserLogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_repository.logout());
  }


  void _onSingUP(AppUserSingUp event, Emitter<AuthenticationState> emit) {
    emit(const AuthenticationState.imcomplete());
  }

  void _onInfoComplete(
      AppUserInfoComplete event, Emitter<AuthenticationState> emit) {
    emit(const AuthenticationState.complete());
  }  void _onunathntecated(
      AppUserLogoutWithoutCompletInfo event, Emitter<AuthenticationState> emit) {
    emit(const AuthenticationState.unauthenticated());
  }

  @override
  Future<void> close() {
    add(AppUserLogoutWithoutCompletInfo());
    _userSubscription.cancel();
    return super.close();
  }
}
