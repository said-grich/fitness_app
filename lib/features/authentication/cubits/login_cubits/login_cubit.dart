import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';

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

    if(state.password.isEmpty || state.email.isEmpty){
      emit(state.copyWith(status: LoginStatus.error ,errorMsg: AppString.isEmpty1));
    }
    try {
      
      await _authenticationRepository.loginWithEmailAndPassword(
          email: state.email, password: state.password);

          
      emit(state.copyWith(status: LoginStatus.succes)
      
      
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.copyWith(
            status: LoginStatus.error, errorMsg: AppString.noUserFoundError));
      } else if (e.code == 'wrong-password') {
        emit(state.copyWith(
            status: LoginStatus.error, errorMsg: AppString.worgPasswordError));
      }
    }

  }
}
