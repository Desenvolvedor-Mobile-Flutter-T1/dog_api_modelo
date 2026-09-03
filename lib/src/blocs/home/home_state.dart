part of 'home_bloc.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final BreedModel breed;

  HomeSuccess({required this.breed});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
