import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../repo/user_repo.dart';
import '../models/user_model.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  UserCubit(this.userRepo) : super(const UserInitial());

  Future<void> getUsers() async {
    try {
      emit(const UsersLoading());
      final users = await userRepo.getAllUsers();
      emit(UsersLoaded(users: users));
    } catch (e) {
      emit(UsersFailure(message: e.toString()));
    }
  }
}
