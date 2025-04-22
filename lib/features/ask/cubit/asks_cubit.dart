import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edugate/features/ask/models/ask_model.dart';
import 'package:edugate/features/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'asks_state.dart';

class AsksCubit extends Cubit<AsksState> {
  AsksCubit() : super(AsksInitial());

  static AsksCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  List<AskModel> asks = [];

  void getAsks(BuildContext context) async {
    emit(LoadingGetAsksState());
    try {
      firestore
          .collection("asks")
          .where("user.uid", isEqualTo: LoginCubit.get(context).userData["uid"])
          .snapshots()
          .listen((data) {
            asks =
                data.docs.map((e) {
                  return AskModel.fromJson(e.data());
                }).toList();
            emit(SuccessGetAsksState());
          });
    } catch (e) {
      emit(ErrorGetAsksState());
    }
  }

  void addQuestion(String question, BuildContext context) async {
    emit(LoadingAddAsksState());
    try {
      await firestore.collection("asks").add({
        "question": question,
        "createdAt": DateTime.now().toString(),
        "answer": "",
        "user": LoginCubit.get(context).userData,
      });
      emit(SuccessAddAsksState());
    } catch (e) {
      emit(ErrorAddAsksState());
    }
  }
}
