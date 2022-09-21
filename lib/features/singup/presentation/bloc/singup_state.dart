// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'singup_bloc.dart';

class SingupState extends Equatable {
  final User user;
  final bool? isLogin;
   SingupState(this.user, this.isLogin){
    isLogin ?? false;
  }

  @override
  List<Object> get props => [user];
}


