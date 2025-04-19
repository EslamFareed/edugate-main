part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class LoadingHomeState extends HomeState {}

class SuccessHomeState extends HomeState {}

class ErrorHomeState extends HomeState {}

class LoadingMakeFavouriteState extends HomeState {}

class SavedFavouriteState extends HomeState {}

class RemovedFavouriteState extends HomeState {}
