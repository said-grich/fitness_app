import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/singup/domain/entities/user.dart';
import 'package:flutter/material.dart';

part 'singup_event.dart';
part 'singup_state.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
  SingupBloc()
      : super(SingupState(
            User(uid: "uid", fullname: "", email: "", password: ""), false)) {
    on<OnSingUpEvent>((event, emit) {
      debugPrint(event.user.toString());
      
    });
  }
}
