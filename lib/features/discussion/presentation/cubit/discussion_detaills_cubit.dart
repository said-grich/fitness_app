import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../profile/model/profile_model.dart';
import '../../model/comment_model.dart';

part 'discussion_detaills_state.dart';

class DiscussionDetaillsCubit extends Cubit<DiscussionDetaillsState> {
  DiscussionDetaillsCubit() : super(DiscussionDetaillsState.initial());

  Future<void> loadPostUser(String userId, String title) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    emit(state.copyWith(
        status: DiscussionDetaillesStatus.submiting,
        profileModel: ProfileModel.empty));
    var userDocRef = fireStore.collection('users').doc(userId);
    var doc = await userDocRef.get();
    var post = await fireStore.collection('postes').doc(title).get();

    var tmp = post.data();

    if (tmp != null) {
      try {
        var json = doc.data();
        if (json != null) {
          var profileModel = ProfileModel.fromJson(json);

          emit(state.copyWith(
              status: DiscussionDetaillesStatus.submiting,
              profileModel: profileModel));
        } else {
          emit(state.copyWith(
              status: DiscussionDetaillesStatus.error,
              profileModel: ProfileModel.empty));
        }

        List commnets = tmp["comments"];

        List<CommnetModel> comnetsList = [];

        commnets.forEach(
          (element) {
            comnetsList.add(CommnetModel.fromJson(element));
          },
        );

        emit(state.copyWith(
            status: DiscussionDetaillesStatus.submiting,
            comments: comnetsList));
      } catch (_) {
        emit(state.copyWith(status: DiscussionDetaillesStatus.error));
      }
    }
  }

  validComment(String value) {
    emit(state.copyWith(
        comment: value, status: DiscussionDetaillesStatus.succes));
  }

  addCommnet(String title) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? auth = FirebaseAuth.instance.currentUser;
    emit(state.copyWith(status: DiscussionDetaillesStatus.submiting));
    var tmpComment = {
      "userId": auth?.uid,
      "photoUrl": state.profileModel.photoUrl,
      "usernname": state.profileModel.fullname,
      "comment": state.comment
    };

    var oldData = await fireStore.collection('postes').doc(title).get();
    var tmp = oldData.data();
    if (tmp != null) {
      try {
        List oldComents = tmp["comments"];
        oldComents.add(tmpComment);
        await fireStore
            .collection('postes')
            .doc(title)
            .update({"comments": oldComents});

        emit(state.copyWith(
            status: DiscussionDetaillesStatus.succes,
            comments: List.from(state.comments)
              ..add(CommnetModel.fromJson(tmpComment))));

      } catch (_) {
        await fireStore.collection('postes').doc(title).update({
          "comments": [tmpComment]
        });
      }
    }
  }
}
