import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/authentication/presentation/pages/signup_page.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginCubit(this._authenticationRepository) : super(LoginState.initial());
  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> loginWithCridentials() async {
    if (state.status == LoginStatus.submitting) return;

        emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authenticationRepository.loginWithEmailAndPassword(
          email: state.email, password: state.password);
      emit(state.copyWith(status: LoginStatus.succes));
    } catch (_) {}
  }

}
