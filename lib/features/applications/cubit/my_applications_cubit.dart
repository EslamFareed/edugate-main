import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edugate/features/applications/models/application_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'my_applications_state.dart';

class MyApplicationsCubit extends Cubit<MyApplicationsState> {
  MyApplicationsCubit() : super(MyApplicationsInitial());

  static MyApplicationsCubit get(context) => BlocProvider.of(context);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<StudentApplication> applications = [];

  void getApplications(String userId) async {
    // if (applications.isNotEmpty) return;

    emit(LoadingMyApplicationsState());
    try {
      // get my applications from firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore
              .collection('applications')
              .where('user.uid', isEqualTo: userId)
              .get();

      applications =
          querySnapshot.docs.map((e) {
            var application = e.data();
            application["id"] = e.id;
            return StudentApplication.fromJson(application);
          }).toList();

      emit(SuccessMyApplicationsState());
    } catch (e) {
      emit(ErrorMyApplicationsState());
    }
  }
}
