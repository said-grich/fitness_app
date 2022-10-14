import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.InitialState());
  Future<void> loadProfileFromFirabse() async {
    User? auth = FirebaseAuth.instance.currentUser;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    emit(state.copyWith(
        status: ProfileStatus.submiting, profileModel: ProfileModel.empty));
    if (true) {
      emit(state.copyWith(status: ProfileStatus.submiting));
      var userDocRef = fireStore.collection('users').doc(auth?.uid);
      var doc = await userDocRef.get();

      var json = doc.data();

      if (json != null) {
        var profileModel = ProfileModel.fromJson(json);

        emit(state.copyWith(
            status: ProfileStatus.succes, profileModel: profileModel));
      } else {
        emit(state.copyWith(
          status: ProfileStatus.error,
          profileModel: ProfileModel.empty
        ));
      }
    }

  }
}
