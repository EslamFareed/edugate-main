import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edugate/features/home/models/major_model.dart';
import 'package:edugate/features/home/models/university_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'apply_state.dart';

class ApplyCubit extends Cubit<ApplyState> {
  ApplyCubit() : super(ApplyInitial());

  static ApplyCubit get(context) => BlocProvider.of(context);

  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void apply({
    required UniversityModel university,
    required Map<String, dynamic> user,
    required Major majorSelected,
    required String typeSelected,
    required String idNumber,
    required String highSchoolName,
    required String highSchoolPercentage,
    required String fatherPhone,
    required String fatherJob,
    required String motherName,
    required String motherPhone,
    required String motherJob,
  }) async {
    emit(LoadingApplyState());

    try {
      // Check if the user has already applied to the same university and major
      QuerySnapshot majorQuerySnapshot =
          await firestore
              .collection("applications")
              .where("university.id", isEqualTo: university.id)
              .where("major", isEqualTo: majorSelected.toJson())
              .where("user.uid", isEqualTo: user["uid"])
              .get();

      if (majorQuerySnapshot.docs.isNotEmpty) {
        log("Application already exists", name: "error");
        emit(ErrorApplyState());
        return;
      }

      await firestore
          .collection("applications")
          .add({
            "user": user,
            "university": university.toJson(),
            "major": majorSelected.toJson(),
            "status": "pending",
            "date": DateTime.now().toString(),
            "type": typeSelected,
            "idNumber": idNumber,
            "highSchoolName": highSchoolName,
            "highSchoolPercentage": highSchoolPercentage,
            "fatherPhone": fatherPhone,
            "fatherJob": fatherJob,
            "motherName": motherName,
            "motherPhone": motherPhone,
            "motherJob": motherJob,
            "idPhoto": idPhoto,
            "certificatePhoto": certificatePhoto,
            "interviewDate": DateTime(2010).toString(),
            "interviewDesc": "",
          })
          .then((value) {
            emit(SuccessApplyState());
          })
          .catchError((error) {
            log(error.toString(), name: "error");

            emit(ErrorApplyState());
          });
    } catch (error) {
      log(error.toString(), name: "error");

      emit(ErrorApplyState());
    }
  }

  String? idPhoto;

  void selectIDPhoto() async {
    emit(LoadingUploadIDState());

    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);

        final storageRef = storage.ref();
        final imagesRef = storageRef.child("images/${image.name}");
        await imagesRef.putFile(file);
        String downloadURL = await imagesRef.getDownloadURL();
        idPhoto = downloadURL;
        emit(SuccessUploadIDState());
      } else {
        emit(ErrorUploadIDState());
      }
    } catch (e) {
      emit(ErrorUploadIDState());
    }
  }

  String? certificatePhoto;

  void selectCertificatePhoto() async {
    emit(LoadingUploadCertificateState());

    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);

        final storageRef = storage.ref();
        final imagesRef = storageRef.child("images/${image.name}.jpg");
        await imagesRef.putFile(file);
        String downloadURL = await imagesRef.getDownloadURL();
        certificatePhoto = downloadURL;
        emit(SuccessUploadCertificateState());
      } else {
        emit(ErrorUploadCertificateState());
      }
    } catch (e) {
      emit(ErrorUploadCertificateState());
    }
  }
}
