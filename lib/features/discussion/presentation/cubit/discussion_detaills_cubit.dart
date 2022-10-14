import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../profile/model/profile_model.dart';

part 'discussion_detaills_state.dart';

enum DiscussionDetaillesStatus { initial, submiting, succes, error }

class DiscussionDetaillsCubit extends Cubit<DiscussionDetaillsState> {
  DiscussionDetaillsCubit() : super(DiscussionDetaillsState.initial());

  Future<void> loadPostUser(String userId) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    emit(state.copyWith(
        status: DiscussionDetaillesStatus.submiting,
        profileModel: ProfileModel.empty));
    var userDocRef = fireStore.collection('users').doc(userId);
    var doc = await userDocRef.get();

    var json = doc.data();
    if (json != null) {
      var profileModel = ProfileModel.fromJson(json);

      emit(state.copyWith(
          status: DiscussionDetaillesStatus.succes,
          profileModel: profileModel));
    } else {
      emit(state.copyWith(
          status: DiscussionDetaillesStatus.error,
          profileModel: ProfileModel.empty));
    }
  }

  validComment(String vlaue) {
    emit(state.copyWith(comment: vlaue , status: DiscussionDetaillesStatus.succes));
  }

  addCommnet(String title){

    

  }
}
