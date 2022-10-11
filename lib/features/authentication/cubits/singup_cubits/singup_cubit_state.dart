// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
part of 'singup_cubit_cubit.dart';

enum SingupStatus { initial, submitting, succes, error }

class SingupState extends Equatable {
  final String email;
  final String password;
  final SingupStatus status;
  final String emailMsgError;
  final String passwordMsgError;

  const SingupState({required this.emailMsgError,required this.passwordMsgError, 
      required this.email, required this.password, required this.status});

  factory SingupState.initial() {
    return   SingupState(emailMsgError:'',passwordMsgError:'',email: '', password: '', status: SingupStatus.initial);
  }

  @override
  List<Object> get props => [email, password, status,emailMsgError,passwordMsgError];



  SingupState copyWith({
    String? email,
    String? password,
    SingupStatus? status,
    String? emailMsgError,
    String? passwordMsgError,
  }) {
    return SingupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      emailMsgError: emailMsgError ?? this.emailMsgError,
      passwordMsgError: passwordMsgError ?? this.passwordMsgError,
    );
  }
  
}
