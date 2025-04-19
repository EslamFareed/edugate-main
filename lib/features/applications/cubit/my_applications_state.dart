part of 'my_applications_cubit.dart';

@immutable
sealed class MyApplicationsState {}

final class MyApplicationsInitial extends MyApplicationsState {}

class LoadingMyApplicationsState extends MyApplicationsState {}

class SuccessMyApplicationsState extends MyApplicationsState {}

class ErrorMyApplicationsState extends MyApplicationsState {}
