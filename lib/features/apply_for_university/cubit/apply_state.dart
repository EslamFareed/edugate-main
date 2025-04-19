part of 'apply_cubit.dart';

@immutable
sealed class ApplyState {}

final class ApplyInitial extends ApplyState {}

class LoadingUploadIDState extends ApplyState {}

class SuccessUploadIDState extends ApplyState {}

class ErrorUploadIDState extends ApplyState {}

class LoadingUploadCertificateState extends ApplyState {}

class SuccessUploadCertificateState extends ApplyState {}

class ErrorUploadCertificateState extends ApplyState {}

class LoadingApplyState extends ApplyState {}

class SuccessApplyState extends ApplyState {}

class ErrorApplyState extends ApplyState {}
