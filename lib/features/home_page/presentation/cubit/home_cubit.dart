import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/discussion/model/discussion_model.dart';
import 'package:fitness_app/features/profile/model/profile_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initialState());

  onDestinationSelected(index) {
    emit(state.copyWith(status: HomeStatus.submiting));

    emit(state.copyWith(status: HomeStatus.succes, selectedIndex: index));
  }

  setindex(int value) {
        loadProfileFromFirabse();

    emit(state.copyWith(selectedIndex: value));
    
  }

  Future<void> loadProfileFromFirabse() async {
    User? auth = FirebaseAuth.instance.currentUser;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    emit(state.copyWith(
        status: HomeStatus.submiting, profile: ProfileModel.empty));
    if (true) {
      emit(state.copyWith(status: HomeStatus.submiting));
      var userDocRef = fireStore.collection('users').doc(auth?.uid);
      var doc = await userDocRef.get();

      var json = doc.data();

      if (json != null) {
        var profileModel = ProfileModel.fromJson(json);

        emit(state.copyWith(status: HomeStatus.succes, profile: profileModel));
      } else {
        emit(state.copyWith(
            status: HomeStatus.error, profile: ProfileModel.empty));
      }
    }
  }
}
