import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/features/discussion/model/discussion_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'discussion_state.dart';

class DiscussionCubit extends Cubit<DiscussionState> {
  DiscussionCubit() : super(DiscussionState.initial());

  titleChanged(String value) {
    emit(state.copyWith(
        title: value, photoError: '', status: DiscussionStatus.succes));
  }

  descChanged(String value) {
    emit(state.copyWith(
        desc: value, photoError: '', status: DiscussionStatus.succes));
  }

  Future<void> uploadImage() async {
    User? auth = await FirebaseAuth.instance.currentUser;

    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (state.title.isNotEmpty) {
      if (permissionStatus.isGranted) {
        //Select Image
        PickedFile? pickedFile = await ImagePicker().getImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
        );

        File file;
        if (pickedFile != null) {
          emit(state.copyWith(status: DiscussionStatus.submiting));
          //Upload to Firebase
          file = File(pickedFile.path);
          var snapshot = await _firebaseStorage
              .ref()
              // ignore: prefer_interpolation_to_compose_strings
              .child('images/posts/' + auth!.uid + "/" + state.title)
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();

          emit(state.copyWith(
              photourl: downloadUrl, status: DiscussionStatus.succes));
        }
      }
    } else {
      emit(state.copyWith(
          photoError: AppString.titleEmpty, status: DiscussionStatus.error));
    }
  }

  Future<void> submit() async {
    User? auth = FirebaseAuth.instance.currentUser;
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    if (state.desc.isNotEmpty &&
        state.title.isNotEmpty &&
        state.photourl.isNotEmpty &&
        state.status == DiscussionStatus.succes) {
      emit(state.copyWith(status: DiscussionStatus.submiting));
      await _fireStore.collection("postes").doc(state.title).set({
        "userId": auth?.uid,
        "title": state.title,
        "desc": state.desc,
        "photourl": state.photourl,
      });

      emit(state.copyWith(
          status: DiscussionStatus.submiting,
          disscutionList: List.from(state.disscutionList)
            ..add(DiscussionModel.fromJson({
              "userId": auth?.uid,
              "title": state.title,
              "desc": state.desc,
              "photourl": state.photourl,
            }))));

    } else {
      emit(state.copyWith(
          status: DiscussionStatus.error, photoError: AppString.isEmpty));
    }
  }

  Future<void> loadDissuction() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    emit(state.copyWith(status: DiscussionStatus.submiting));
    await _fireStore.collection("postes").get().then(
          (res) => {
            res.docs.forEach((element) {
              var tmp = element.data();

              emit(state.copyWith(
                  disscutionList: List.from(state.disscutionList)
                    ..add(DiscussionModel.fromJson(tmp))));
            })
          },
          onError: (e) => print("Error completing: $e"),
        );
  }
}
