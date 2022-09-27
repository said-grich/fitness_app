// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'singup_cubit_cubit.dart';
enum SingupStatus { initial, submitting, succes, error }

class SingupState extends Equatable {
    final String email;
  final String password;
  final SingupStatus status;

  const SingupState(
      {required this.email, required this.password, required this.status});

  factory SingupState.initial() {
    return const SingupState(email: '', password: '', status: SingupStatus.initial);
  }
  

  @override
  List<Object> get props => [email, password, status];





  SingupState copyWith({
    String? email,
    String? password,
    SingupStatus? status,
  }) {
    return SingupState(
      email:email ?? this.email,
     password: password ?? this.password,
      status:status ?? this.status,
    );
  }
}

