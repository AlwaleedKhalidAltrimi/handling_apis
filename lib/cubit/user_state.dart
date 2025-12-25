part of 'user_cubit.dart';

@immutable
sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UsersLoading extends UserState {
  const UsersLoading();
}

final class UsersLoaded extends UserState {
  final List<UserModel> users;

  const UsersLoaded({required this.users});
}

final class UsersFailure extends UserState {
  final String message;

  const UsersFailure({required this.message});
}
