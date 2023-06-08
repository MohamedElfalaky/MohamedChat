part of 'get_users_cubit.dart';

@immutable
abstract class GetUsersState {}

class GetUsersInitial extends GetUsersState {}

class GetUsersLoading extends GetUsersState {}

class GetUsersSuccess extends GetUsersState {
  final List<UserData> myList;
  GetUsersSuccess(this.myList);
}

class GetUsersError extends GetUsersState {}
