part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


final class GetAllTodosListSuccessState extends HomeState {}
final class GetAllTodosListFailedState extends HomeState {}




final class FunPaginationListToDoSuccessState  extends HomeState {}