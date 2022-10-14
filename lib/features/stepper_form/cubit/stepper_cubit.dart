import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/bloc_export.dart';
part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  final AuthenticationRepository _authenticationRepository;

  StepperCubit(this._authenticationRepository) : super(StepperState.initial());

  tapped(int step) {
    emit(state.copyWith(status: StepperStatus.submitting));
    emit(state.copyWith(currentStep: step, status: StepperStatus.succes));
  }

  continued() {
    emit(state.copyWith(status: StepperStatus.submitting));
    state.currentStep < 2
        ? emit(state.copyWith(
            currentStep: state.currentStep + 1, status: StepperStatus.succes))
        : null;
  }

  cancel() {
    emit(state.copyWith(status: StepperStatus.submitting));
    state.currentStep > 0
        ? emit(state.copyWith(
            currentStep: state.currentStep - 1, status: StepperStatus.succes))
        : null;
  }

// validate form :
  void nameValidation(String value) {
    if (value.isNotEmpty && value.length < 4) {
      emit(state.copyWith(
          errorMsgName: AppString.nameValidationError,
          status: StepperStatus.error));
    } else if (value.isEmpty) {
      emit(state.copyWith(
          errorMsgName: AppString.isEmpty, status: StepperStatus.error));
    } else {
      emit(state.copyWith(
          errorMsgName: '', fullname: value, status: StepperStatus.succes));
    }
  }

  void phoneNumberValidation(String value) {
    if (value.isNotEmpty && value.length < 10) {
      emit(state.copyWith(
          errorMsgPhone: AppString.phoneValidationError,
          status: StepperStatus.error));
    } else {
      emit(state.copyWith(
          errorMsgPhone: '', phone: value, status: StepperStatus.succes));
    }
  }

  void ageValidation(String value) {
    if (value.isNotEmpty) {
      emit(state.copyWith(
          errorMsgAge: '', age: value, status: StepperStatus.succes));
    } else {
      emit(state.copyWith(
          errorMsgAge: AppString.isEmpty, status: StepperStatus.error));
    }
  }

  void poidValidation(String value) {
    if (value.isNotEmpty) {
      emit(state.copyWith(
          errorMsgPoids: '', poids: value, status: StepperStatus.succes));
    } else {
      emit(state.copyWith(
          errorMsgPoids: AppString.isEmpty, status: StepperStatus.error));
    }
  }

  void lenghtValidation(String value) {
    if (value.isNotEmpty) {
      emit(state.copyWith(
          errorMsgLength: '', length: value, status: StepperStatus.succes));
    } else {
      emit(state.copyWith(
          errorMsgPoids: AppString.isEmpty, status: StepperStatus.error));
    }
  }

  Future<void> uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      File file;
      if (pickedFile != null) {
        emit(state.copyWith(status: StepperStatus.submitting));
        //Upload to Firebase
        file = File(pickedFile.path);
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/' + state.fullname)
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        emit(state.copyWith(
            photoUrl: downloadUrl, status: StepperStatus.submitting));
        emit(state.copyWith(status: StepperStatus.succes));
      }
    }
  }

  Future<void> saveUserTodb(String sex, String role) async {
    User? auth =  FirebaseAuth.instance.currentUser;
    FirebaseFirestore _fireStore =  FirebaseFirestore.instance;
    if (state.fullname.isEmpty) {
      emit(state.copyWith(
          status: StepperStatus.error, errorMsgName: AppString.isEmpty));
    } else if (state.age.isEmpty) {
      emit(state.copyWith(
          status: StepperStatus.error, errorMsgAge: AppString.isEmpty));
    } else if (state.poids.isEmpty) {
      emit(state.copyWith(
          status: StepperStatus.error, errorMsgPoids: AppString.isEmpty));
    } else if (state.length.isEmpty) {
      emit(state.copyWith(
          status: StepperStatus.error, errorMsgLength: AppString.isEmpty));
    } else if (state.phone.isEmpty) {
      emit(state.copyWith(
          status: StepperStatus.error, errorMsgPhone: AppString.isEmpty));
    }
    if (state.status == StepperStatus.succes) {
      emit(state.copyWith(status: StepperStatus.submitting));
      var userDocRef = _fireStore.collection('collection_name').doc(auth?.uid);
      var doc = await userDocRef.get();

      if (doc.exists) {
        emit(state.copyWith(status: StepperStatus.error));
      } else {
        await _fireStore.collection("users").doc(auth?.uid).set({
          "id": auth?.uid,
          "email": auth?.email,
          "fullname": state.fullname,
          "age": state.age,
          "poids": state.poids,
          "length": state.length,
          "phone": state.phone,
          "role": role,
          "sex": sex,
          "photoUrl": state.photoUrl
        });
        emit(state.copyWith(status: StepperStatus.succes));
      }
    }
  }
}
