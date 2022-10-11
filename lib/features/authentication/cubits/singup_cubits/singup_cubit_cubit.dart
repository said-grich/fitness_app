import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';

part 'singup_cubit_state.dart';

class SingupCubit extends Cubit<SingupState> {
  final AuthenticationRepository _authenticationRepository;

  SingupCubit(this._authenticationRepository) : super(SingupState.initial());
  void emailChanged(String value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      emit(
        state.copyWith(
            status: SingupStatus.error,
            emailMsgError: AppString.nonValidEmail,
            passwordMsgError: ''),
      );
    } else {
      emit(state.copyWith(email: value, status: SingupStatus.initial));
    }
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SingupStatus.initial));
  }

  Future<void> singupWithEmailAndPassword() async {
    if (state.status == SingupStatus.submitting) return;
    emit(state.copyWith(status: SingupStatus.submitting));
    if (state.email.isEmpty) {
      emit(
        state.copyWith(
            status: SingupStatus.error,
            emailMsgError: AppString.isEmpty,
            passwordMsgError: ''),
      );
    } else if (state.password.isEmpty) {
      emit(
        state.copyWith(
            status: SingupStatus.error,
            emailMsgError: '',
            passwordMsgError: AppString.isEmpty),
      );
    }
    try {
      await _authenticationRepository.singupWithEmailAndPassword(
          email: state.email, password: state.password);

      emit(state.copyWith(status: SingupStatus.succes));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(state.copyWith(
            status: SingupStatus.error,
            passwordMsgError: AppString.passwordMsgError,
            emailMsgError: ''));
      } else if (e.code == 'email-already-in-use') {
        emit(
          state.copyWith(
              status: SingupStatus.error,
              emailMsgError: AppString.emailInUseMsgError,
              passwordMsgError: ''),
        );
      }
    }
  }
}
