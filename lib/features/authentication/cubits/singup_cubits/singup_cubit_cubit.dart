import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';

part 'singup_cubit_state.dart';

class SingupCubit extends Cubit<SingupState> {
  final AuthenticationRepository _authenticationRepository;

  SingupCubit(this._authenticationRepository) : super(SingupState.initial());
  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SingupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SingupStatus.initial));
  }

  Future<void> singupWithEmailAndPassword() async {
    if (state.status == SingupStatus.submitting) return;
    emit(state.copyWith(status: SingupStatus.submitting));
    try {
      await _authenticationRepository.singupWithEmailAndPassword(
          email: state.email, password: state.password);
      emit(state.copyWith(status: SingupStatus.succes));

      print(state);
    } catch (_) {}
  }
}
