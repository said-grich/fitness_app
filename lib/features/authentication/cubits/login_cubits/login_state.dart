// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, succes, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final String errorMsg;
  final LoginStatus status;

  const LoginState({required this.errorMsg, 
              required this.email, required this.password, required this.status});

  factory LoginState.initial() {
    return const LoginState(email: '', password: '', status: LoginStatus.initial, errorMsg: '');
  }

  @override
  List<Object> get props => [email, password, status ,errorMsg];


  LoginState copyWith({
    String? email,
    String? password,
    String? errorMsg,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
    );
  }
}
