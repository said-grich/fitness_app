part of 'singup_bloc.dart';

abstract class SingupEvent extends Equatable {
  const SingupEvent();

  @override
  List<Object> get props => [];
}

class OnSingUpEvent extends SingupEvent {
  final User user;
  const OnSingUpEvent({required this.user});
}
